<?php
abstract class field
{
    // Значение поля
    protected $value = null;
    
    // Кеш объектов
    private static $object_cache = array();
    
    ///////////////////////////////////////////////////////////////////////////
    
    // Конвертирует значение поля из внешнего представления во внутреннее
    public function parse($content) {
        $this->set($content);
        return true;
    }
    
    // Устанавливает значение поля во внутреннем формате
    public function set($content) {
        $this->value = $content;
        return $this;
    }
    
    // Возвращает значение поля во внутреннем формате
    public function get() {
        return $this->value;
    }
    
    // Возвращает значение поля для вывода в форме
    public function form() {
        return $this->get();
    }
    
    // Возвращает значение поля для вывода в списке
    public function view() {
        return $this->get();
    }
    
    // Проверяет валидности поля
    public function check($errors = array()) {
        foreach ($errors as $error) {
            if (!valid::factory($error)->check($this->get())) {
                return false;
            }
        }
        return true;
    }
    
    // Создание объекта поля
    public static final function factory($type)
    {
        if (!isset(self::$object_cache[$type])) {
            $class_name = 'field_' . $type;
            self::$object_cache[$type] = new $class_name();
        }
        return self::$object_cache[$type];
    }
}
