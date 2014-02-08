<?php
class field_int extends field
{
    public function parse($content) {
        $result = valid::factory('int')->parse_check($content);
        if ($result) {
            $this->set($content);
        }
        return $result;
    }
    
    public function set($content) {
        $this->value = $content !== '' ? $content : null;
        return $this;
    }
    
    public function check($errors = array()) {
        return valid::factory('int')->check($this->get()) &&
            parent::check($errors);
    }
}
