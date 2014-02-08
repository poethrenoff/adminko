<?php
class field_password extends field_string
{
    public function parse($content) {
        $result = valid::factory('alpha')->parse_check($content);
        if ($result) {
            $this->set(md5($content));
        }
        return $result;
    }
    
    public function form() {
        return '';
    }
    
    public function view() {
        return str_repeat('*', rand(5, 8));
    }
}
