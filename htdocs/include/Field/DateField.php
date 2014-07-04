<?php
namespace Adminko\Field;

class DateField extends StringField
{
    public function parse($content) {
        $result = valid::factory('date')->parse_check($content);
        if ($result) {
            $this->set(date::set($content, 'short'));
        }
        return $result;
    }
    
    public function form() {
        return date::get($this->get(), 'short');
    }
    
    public function view() {
        return preg_replace('/\s+/', '&nbsp;', date::get($this->get(), 'short'));
    }
    
    public function check($errors = array()) {
        return valid::factory('date')->check($this->get()) &&
            parent::check($errors);
    }
}
