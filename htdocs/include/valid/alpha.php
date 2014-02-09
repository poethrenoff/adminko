<?php
class valid_alpha extends valid
{
    public function parse_check($content)
    {
        return (string) $content === '' || preg_match('/^[a-z0-9_]+$/i', $content);
    }
    
    public function check($content)
    {
        return (string) $content === '' || preg_match('/^[a-z0-9_]+$/i', $content);
    }
}