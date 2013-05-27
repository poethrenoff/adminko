<?php
class field_default extends field
{
    public function get($content)
    {
        return field_boolean::get($content);
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
