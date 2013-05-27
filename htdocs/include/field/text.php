<?php
class field_text extends field
{
    public function get($content)
    {
        $content = strip_tags($content);
        $content = (mb_strlen($content, 'utf-8') > 80) ? mb_substr($content, 0, 80, 'utf-8') . '...' : $content;
        return self::get_string($content);
    }
    
    public function form($content)
    {
        return field_string::form($content);
    }
    
    public function set($content)
    {
        return field_string::set($content);
    }
}
