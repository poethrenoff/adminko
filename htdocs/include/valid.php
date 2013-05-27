<?php
abstract class valid
{
    abstract public function check($content);
    
    // Создание объекта валидатора
    public static final function factory($type)
    {
        $class_name = 'valid_' . $type;
        return new $class_name();
    }
}