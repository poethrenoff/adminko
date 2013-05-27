<?php
class field_order extends field
{
    public function get($content)
    {
        ///
    }
    
    public function form($content)
    {
        ///
    }
    
    public function set($content)
    {
        return strval(intval($content));
    }
}
