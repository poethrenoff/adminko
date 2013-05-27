<?php
class field_boolean extends field
{
    public function get($content)
    {
        return $content ? 'да' : 'нет';
    }
    
    public function form($content)
    {
        return field_string::form($content);
    }
    
    public function set($content)
    {
        return strval($content ? 1 : 0);
    }
}
