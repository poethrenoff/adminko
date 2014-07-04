<?php
namespace Adminko\Field;

class IntField extends Field
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
