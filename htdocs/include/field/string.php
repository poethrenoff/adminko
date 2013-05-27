<?php
class field_string extends field
{
    public function get($content)
    {
        return htmlspecialchars($content, ENT_QUOTES);
    }
    
    public function form($content)
    {
        return htmlspecialchars($content, ENT_QUOTES);
    }
    
    public function set($content)
    {
        return $content;
    }
}
