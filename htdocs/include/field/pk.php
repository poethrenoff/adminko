<?php
class field_pk extends field_int
{
    public function check($errors = array()) {
        return valid::factory('require')->check($this->get()) &&
            parent::check($errors) && ($this->get() > 0);
    }
}
