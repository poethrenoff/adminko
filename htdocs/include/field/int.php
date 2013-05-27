<?php
class field_int extends field
{
    public function get($content)
    {
        return field_string::get($content);
    }
    
    public function form($content)
    {
        return field_string::form($content);
    }
    
    public function set($content)
    {
        return $content !== '' ? strval(intval($content)) : null;
    }
}
