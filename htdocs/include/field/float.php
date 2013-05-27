<?php
class field_float extends field
{
    public function get($content)
    {
        return self::get_string($content);
    }
    
    public function form($content)
    {
        return self::form_string($content);
    }
    
    public function set($content)
    {
        return $content !== '' ? str_replace(',', '.', $content) : null;
    }
}
