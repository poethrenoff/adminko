<?php
class field_datetime extends field
{
    public function get($content)
    {
        return preg_replace('/\s+/', '&nbsp;', date::get($content, 'long'));
    }
    
    public function form($content)
    {
        return date::get($content, 'long');
    }
    
    public function set($content)
    {
        return date::set($content, 'long');
    }
}
