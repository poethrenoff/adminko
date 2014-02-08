<?php
class field_order extends field_int
{
    protected $value = 0;
    
    public function check($errors = array()) {
        return valid::factory('require')->check($this->get()) &&
            parent::check($errors);
    }
}
