<?php
class field_float extends field
{
    public function set($content) {
        $this->value = (string) $content !== '' ? str_replace(',', '.', $content) : null;
        return $this;
    }
    
    public function check($errors = array()) {
        return valid::factory('float')->check($this->get()) &&
            parent::check($errors);
    }
}
