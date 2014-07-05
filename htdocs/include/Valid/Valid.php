<?php
namespace Adminko\Valid;

abstract class Valid
{
    // Кеш объектов
    private static $object_cache = array();
    
    abstract public function check($content);
    
    // Создание объекта валидатора
    public static final function factory($type)
    {
        if (!isset(self::$object_cache[$type])) {
            $class_name = __NAMESPACE__ . '\\' . ucfirst($type) . 'Valid';
            self::$object_cache[$type] = new $class_name();
        }
        return self::$object_cache[$type];
    }
}