<?php
class field_date extends field
{
    public function get($content)
    {
        return preg_replace('/\s+/', '&nbsp;', date::get($content, 'short'));
    }
    
    public function form($content)
    {
        return date::get($content, 'short');
    }
    
    public function set($content)
    {
        return date::set($content, 'short');
    }
}
