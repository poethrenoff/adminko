<?php
namespace Adminko\Model;

use Adminko\Metadata;
use Adminko\Db\Db;
use Adminko\Field\Field;

class Model
{
    // Название таблицы
    protected $object = '';

    // Поле с идентификатором первичного ключа
    protected $primary_field = '';

    // Поля таблицы
    protected $fields = array();

    // Описание полей таблицы
    protected $fields_desc = array();

    // Вновь созданный объект
    protected $is_new = true;

    // Кеш объектов
    private static $object_cache = array();
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    public function __construct($object)
    {
        if (!isset(metadata::$objects[$object])) {
            throw new \AlarmException('Ошибка. Объект не описан в метаданных.');
        }
        
        $object_desc = metadata::$objects[$object];
        if (!(isset($object_desc['fields']) && $object_desc['fields'])) {
            throw new \AlarmException('Ошибка. Объект не является таблицей.');
        }
        $this->object = $object;
        $this->fields_desc = $object_desc['fields'];
        
        foreach ($this->fields_desc as $field_name => $field_desc) {
            $this->fields[$field_name] = Field::factory($this->fields_desc[$field_name]['type']);
            if ($field_desc['type'] == 'pk') {
                $this->primary_field = $field_name;
            }
        }
        if (!$this->primary_field) {
            throw new \AlarmException('Ошибка в описании таблицы "' . $object . '". Отсутствует ключевое поле.');
        }
    }

    // Диспетчер неявных аксессоров
    public function __call($method, $vars) {
        if (!preg_match("/^(get|set)_(\w+)/", $method, $matches)) {
            throw new \AlarmException("Ошибка. Метод " . get_called_class() . "::{$method}() не найден.");
        }
        if (!(isset($this->fields_desc[$matches[2]]) && is_array($this->fields_desc[$matches[2]]))) {
            throw new \AlarmException("Ошибка. Поле {$this->object}->{$matches[2]} не описано в метаданных.");
        }
        
        $field = $this->fields[$matches[2]];
        switch ($matches[1]) {
            case 'get':
                return $field->get();
            case 'set':
                if (!empty($vars)) {
                    $field->set($vars[0]);
                }
                return $this;
        }
    }

    // Создание объекта модели
    public static final function factory($object)
    {
        if (isset(Metadata::$objects[$object]['model'])) {
            $class_name = metadata::$objects[$object]['model'];
        } else {
            $class_name = ucfirst($object);
        }
        
        $class_name = __NAMESPACE__ . '\\' . $class_name . 'Model';
        
        if (!class_exists($class_name)) {
            $class_name = __NAMESPACE__ . '\\' . 'Model';
        }
        
        return new $class_name($object);
    }

    // Заполнение полей объекта из БД
    public function get($primary_field, $record = null) {
        if (!isset(self::$object_cache[$this->object][$primary_field])) {
            if (is_null($record)) {
                $record = Db::selectRow("select * from {$this->object} where {$this->primary_field} = :{$this->primary_field}",
                    array($this->primary_field => $primary_field)
                );
                if (!$record){
                    throw new \AlarmException("Ошибка. Запись {$this->object}({$primary_field}) не найдена.");
                }
            }
            foreach ($this->fields_desc as $field_name => $field_desc) {
                self::$object_cache[$this->object][$primary_field][$field_name] =
                    Field::factory($this->fields_desc[$field_name]['type'])->set($record[$field_name]);
            }
        }
        $this->fields = self::$object_cache[$this->object][$primary_field];
        $this->is_new = false;
        return $this;
    }

    // Получение списка объектов
    public function get_batch(&$records = array()) {
        $objects = array();
        foreach ($records as $record) {
            $objects[$record[$this->primary_field]] = model::factory($this->object)->get($record[$this->primary_field], $record);
        }
        return $objects;
    }

    // Получение условия фильтрации записей
    public function get_filter_condition($where = array()) {
        $filter_conds = $filter_binds = array();
        foreach ($where as $name => $value) {
            $filter_conds[] = "{$name} = :{$name}";
            $filter_binds[$name] = $value;
        }
        $filter_clause = $filter_conds ? 'where ' . join(' and ', $filter_conds) : '';
        return array($filter_clause, $filter_binds);
    }
    
    // Получение условия сортировки записей
    protected function get_order_clause($order = array()) {
        $order_conds = array();
        foreach ($order as $field => $dir) {
            $order_conds[] = "{$field} {$dir}";
        }
        return $order_conds ? 'order by ' . join(', ', $order_conds) : '';
    }
    
    // Получение условия ограничения количества записей
    protected function get_limit_clause($limit = null, $offset = null) {
        $limit_clause = '';
        if (isset($limit)) {
            $limit_clause .= 'limit ' . $limit;
            if (isset($offset)) {
                $limit_clause .= ' offset ' . $offset;
            }
        }
        return $limit_clause;
    }

    // Получение количества объектов
    public function get_count($where = array()) {
        list($filter_clause, $filter_binds) = $this->get_filter_condition($where);
        return Db::selectCell("select count(*) from {$this->object} {$filter_clause}", $filter_binds);
    }

    // Получение списка объектов
    public function get_list($where = array(), $order = array(), $limit = null, $offset = null) {
        list($filter_clause, $filter_binds) = $this->get_filter_condition($where);
        $order_clause = $this->get_order_clause($order);
        $limit_clause = $this->get_limit_clause($limit, $offset);
        
        $records = Db::selectAll("select * from {$this->object} {$filter_clause} {$order_clause} {$limit_clause}", $filter_binds);
        
        return $this->get_batch($records);
    }

    // Сохранение объекта в БД
    public function save() {
        $record = array();
        foreach($this->fields_desc as $field_name => $field_desc) {
           if (!(isset($field_desc[$this->is_new ? 'no_add' : 'no_edit']) &&
                    $field_desc[$this->is_new ? 'no_add' : 'no_edit'] ||
                $this->is_new && $field_desc['type'] == 'pk'))
            {
                $errors = isset($field_desc['errors']) && is_array($field_desc['errors']) ? $field_desc['errors'] : array();
                if (!$this->fields[$field_name]->check($errors)) {
                    throw new AlarmException('Ошибочное значение поля "' . $field_desc['title'] . '".');
                }
                
                $get_method = 'get_' . $field_name;
                $record[$field_name] = $this->$get_method();
            }
        }
        
        if ($this->is_new) {
            Db::insert($this->object, $record); $this->get(Db::lastInsertId());
        } else {
            Db::update($this->object, $record, array($this->primary_field => $this->get_id()));
        }
        return $this;
    }

    // Удаление объекта из БД
    public function delete() {
        if($this->is_new){
            throw new AlarmException("Ошибка. Запись не можеть быть удалена из БД, так как не имеет идентификатора.");
        }
        Db::delete($this->object, array($this->primary_field => $this->get_id()));
        self::purge($this->object, $this->primary_field);
    }

    // Получение идентификатора объекта
    public function get_id() {
        if($this->is_new){
            throw new AlarmException("Ошибка. Запись не была сохранена в БД, поэтому не имеет идентификатора.");
        }
        return $this->fields[$this->primary_field]->get();
    }

    // Получение поля с идентификатором первичного ключа
    public function get_primary_field() {
        return $this->primary_field;
    }

    // Очистка кеша объектов
    public static function purge($object = null, $primary_field = null) {
        if (!is_null($object) && !is_null($primary_field)) {
            unset(self::$object_cache[$object][$primary_field]);
        } elseif (!is_null($object)) {
            unset(self::$object_cache[$object]);
        } else {
            self::$object_cache = array();
        }
    }
}