<?php
class hierarchy extends model
{
    // Поле с идентификатором родительской записи
    protected $parent_field = '';
    
    // Родительский объект
    protected $parent = null;
    
    // Массив дочерних объектов
    protected $children = array();
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    public function __construct($object)
    {
        parent::__construct($object);
        
        $object_desc = metadata::$objects[$object];
        foreach ($object_desc['fields'] as $field_name => $field_desc) {
            if ($field_desc['type'] == 'parent') {
                $this->parent_field = $field_name;
            }
        }
        if (!$this->parent_field) {
            throw new Exception('Ошибка в описании таблицы "' . $object . '". Отсутствует поле родительской записи.', true);
        }
    }
    
    // Получение объекта-родителя
    public function get_parent()
    {
        return $this->parent;
    }
    
    // Получение списка дочерних объектов
    public function get_children()
    {
        return $this->children;
    }
    
    // Колчество дочерних объектов
    public function children_count()
    {
        return count($this->children);
    }
    
    // Есть ли дочерние объекты
    public function has_children()
    {
        return $this->children_count() > 0;
    }
    
    // Построение дерева записей
    public function get_tree(&$records, $begin = 0, $except = array())
    {
        $begin_parent = null;
        $parent_method = 'get_' . $this->parent_field;
        $primary_method = 'get_' . $this->primary_field;
        foreach ($records as $parent_record) {
            foreach ($records as $child_record) {
                if ($child_record->$parent_method() == $parent_record->$primary_method() &&
                        !in_array($child_record->$primary_method(), $except)) {
                    $child_record->parent = $parent_record;
                    $parent_record->children[] = $child_record;
                }
            }
            if ($parent_record->$primary_method() == $begin) {
                $begin_parent = $parent_record;
            }
        }
        return $begin_parent;
    }
}