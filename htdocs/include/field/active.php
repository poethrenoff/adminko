<?php
class field_active extends field
{
    public function get($content)
    {
        ///
    }
    
    public function form($content)
    {
        return field_string::form($content);
    }
    
    public function set($content)
    {
        return field_boolean::set($content);
    }
}
