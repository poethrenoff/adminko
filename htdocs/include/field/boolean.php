<?php
class field_boolean extends field
{
    public function set($content) {
        $this->value = (string) $content !== '' ? (boolean) $content : null;
        return $this;
    }
    
    public function get() {
        return (boolean) $this->value;
    }
    
    public function form() {
        return is_null($this->value) ? null : $this->get();
    }
    
    public function view() {
        return $this->get() ? 'да' : 'нет';
    }
    
    public function check($errors = array()) {
        return parent::check($errors) &&
            (in_array('require', $errors) ? $this->get() : true);
    }
}
