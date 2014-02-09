<?php
class field_int extends field
{
    public function set($content) {
        $this->value = (string) $content !== '' ? $content : null;
        return $this;
    }
    
    public function check($errors = array()) {
        return valid::factory('int')->check($this->get()) &&
            parent::check($errors);
    }
}
