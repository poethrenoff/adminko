<?php
abstract class valid
{
    abstract public function check($content);
    
    // �������� ������� ����������
    public static final function factory($type)
    {
        $class_name = 'valid_' . $type;
        return new $class_name();
    }
}