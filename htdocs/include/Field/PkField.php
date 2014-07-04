<?php
namespace Adminko\Field;

class PkField extends IntField
{
    public function check($errors = array()) {
        return valid::factory('require')->check($this->get()) &&
            parent::check($errors) && ($this->get() > 0);
    }
}
