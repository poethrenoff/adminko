<?php
class model
{
    // Название таблицы
    protected $object = '';

    // Поле с идентификатором первичного ключа
    protected $primary_field = '';

    // Поле с идентификатором родительской записи
    protected $parent_field = '';

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
            throw new Exception('Ошибка. Объект не описан в метаданных.', true);
        }
        
        $object_desc = metadata::$objects[$object];
        if (!(isset($object_desc['fields']) && $object_desc['fields'])) {
            throw new Exception('Ошибка. Объект не является таблицей.', true);
        }
        $this->object = $object;
        $this->fields_desc = $object_desc['fields'];
        
        foreach ($object_desc['fields'] as $field_name => $field_desc) {
            if ($field_desc['type'] == 'pk') {
                $this->primary_field = $field_name;
            }
            if ($field_desc['type'] == 'parent') {
                $this->parent_field = $field_name;
            }
        }
        if (!$this->primary_field) {
            throw new Exception('Ошибка в описании таблицы "' . $object . '". Отсутствует ключевое поле.', true);
        }
    }

    // Диспетчер неявных аксессоров
    public function __call($method, $vars) {
        if (!preg_match("/^(get|set)_(\w+)/", $method, $matches)) {
            throw new Exception("Ошибка. Метод " . get_called_class() . "::{$method}() не найден.", true);
        }
        if (!(isset($this->fields_desc[$matches[2]]) && is_array($this->fields_desc[$matches[2]]))) {
            throw new Exception("Ошибка. Поле {$this->object}->{$matches[2]} не описано в метаданных.", true);
        }
        
        $field_name = $matches[2]; $field_desc = $this->fields_desc[$field_name];
        switch ($matches[1]) {
            case 'get':
                return isset($this->fields[$field_name]) ? $this->fields[$field_name] : null;
            case 'set':
                $this->fields[$field_name] = $vars[0];
                return $this;
        }
    }

    // Создание объекта модели
    public static final function factory($object)
    {
        $class_name = 'model_' . $object;
        
        if (!class_exists($class_name)) {
            $class_name = 'model';
        }
        
        return new $class_name($object);
    }

    // Заполнение полей объекта из БД
    public function get($primary_field, $record = null) {
        if (!isset(self::$object_cache[$this->object][$primary_field])) {
            if (is_null($record)) {
                $record = db::select_row("select * from {$this->object} where {$this->primary_field} = :{$this->primary_field}",
                    array($this->primary_field => $primary_field)
               );
                if (!$record){
                    throw new Exception("Ошибка. Запись {$this->object}({$primary_field}) не найдена.");
                }
            }
            foreach ($this->fields_desc as $field_name => $field_desc) {
                self::$object_cache[$this->object][$primary_field][$field_name] = $record[$field_name];
            }
        }
        $this->fields = self::$object_cache[$this->object][$primary_field];
        $this->is_new = false;
        return $this;
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
    protected function get_limit_clause($limit = 0, $offset = 0) {
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
        return db::select_cell("select count(*) from {$this->object}" . $filter_clause, $filter_binds);
    }

    // Получение списка объектов
    public function get_list($where = array(), $order = array(), $limit = null, $offset = null) {
        list($filter_clause, $filter_binds) = $this->get_filter_condition($where);
        $order_clause = $this->get_order_clause($order);
        $limit_clause = $this->get_limit_clause($limit, $offset);
        
        $records = db::select_all("select * from {$this->object} {$filter_clause} {$order_clause} {$limit_clause}", $filter_binds);
        
        $objects = array();
        foreach ($records as $record) {
            $objects[] = model::factory($this->object)->get($record[$this->primary_field], $record);
        }
        return $objects;
    }

    // Сохранение объекта в БД
    public function save() {
        $record = array();
        foreach($this->fields_desc as $field_name => $field_desc) {
            if (!(isset($field_desc['no_add']) && $field_desc['no_add'] || isset($field_desc['no_edit']) && $field_desc['no_edit']) &&
                $field_desc['type'] != 'pk' && $field_desc['type'] != 'order'
         ) {
                $record[$field_name] = $this->fields[$field_name];
                
                // @todo Валидация
                
                // Порядковое поле должно заполнятся само
                // А значит нужна проверка и учет группировки
                // А еще многоязычные записи...
                
                // Наверное, будет проще отделить метаданные модели от метаданных админки...
            }
        }
        
        if ($this->is_new) {
            db::insert($this->object, $record); $this->get(db::last_insert_id());
        } else {
            db::update($this->object, $record, array($this->primary_field => $this->get_id()));
        }
        return $this;
    }

    // Удаление объекта из БД
    public function delete() {
        if($this->is_new){
            throw new Exception("Ошибка. Запись не можеть быть удалена из БД, так как не имеет идентификатора.");
        }
        db::delete($this->object, array($this->primary_field => $this->get_id()));
        self::purge($this->object, $this->primary_field);
    }

    // Получение идентификатора объекта
    public function get_id() {
        if($this->is_new){
            throw new Exception("Ошибка. Запись не была сохранена в БД, поэтому не имеет идентификатора.");
        }
        return $this->fields[$this->primary_field];
    }

    // Построение дерева записей
    public function get_tree(&$records, $begin = 0, $except = array())
    {
        $this->except = $except;
        $this->records_by_parent = array();
        $parent_method = 'get_' . $this->parent_field;
        foreach ($records as $record) {
            $this->records_by_parent[$record->$parent_method()][] = $record;
        }
        
        $this->records_as_tree = array();
        $this->build_tree($begin);
        
        return $this->records_as_tree;
    }

    // Рекурсивный метод постройки уровня дерева
    private function build_tree($parent_field_id, $depth = 0)
    {
        if (isset($this->records_by_parent[$parent_field_id])) {
            $primary_method = 'get_' . $this->primary_field;
            foreach ($this->records_by_parent[$parent_field_id] as $record) {
                $primary_field_id = $record->$primary_method();
                if (!in_array($primary_field_id, $this->except)) {
                    $record->_depth = $depth;
                    $record->_has_children = isset($this->records_by_parent[$primary_field_id]);
                    if ($record->_has_children)
                        $record->_children_count = count($this->records_by_parent[$primary_field_id]);
                    
                    $this->records_as_tree[] = $record;
                    $this->build_tree($primary_field_id, $depth + 1);
                }
            }
        }
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