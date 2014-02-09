<?php
class field_order extends field_int
{
    protected $value = 0;
    
    public function set($content) {
        $this->value = (string) $content !== '' ? $content : 0;
        return $this;
    }
    
    public function check($errors = array()) {
        return valid::factory('require')->check($this->get()) &&
            parent::check($errors);
    }
}
