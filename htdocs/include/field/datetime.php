<?php
class field_datetime extends field_string
{
    public function parse($content) {
        $result = valid::factory('datetime')->parse_check($content);
        if ($result) {
            $this->set(date::set($content, 'long'));
        }
        return $result;
    }
    
    public function form() {
        return date::get($this->get(), 'long');
    }
    
    public function view() {
        return preg_replace('/\s+/', '&nbsp;', date::get($this->get(), 'long'));
    }
    
    public function check($errors = array()) {
        return valid::factory('datetime')->check($this->get()) &&
            parent::check($errors);
    }
}
