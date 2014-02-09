<?php
class field_float extends field
{
    public function parse($content) {
        $result = valid::factory('float')->parse_check($content);
        if ($result) {
            $this->set(str_replace(',', '.', $content));
        }
        return $result;
    }
    
    public function set($content) {
        $this->value = (string) $content !== '' ? $content : null;
        return $this;
    }
    
    public function check($errors = array()) {
        return valid::factory('float')->check($this->get()) &&
            parent::check($errors);
    }
}
