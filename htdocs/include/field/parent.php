<?php
class field_parent extends field
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
        return strval(intval($content));
    }
}
