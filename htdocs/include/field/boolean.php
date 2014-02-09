<?php
class field_boolean extends field
{
    protected $value = false;
    
    public function set($content) {
        $this->value = (boolean) $content;
        return $this;
    }
    
    public function view() {
        return $this->get() ? 'да' : 'нет';
    }
    
    public function check($errors = array()) {
        return parent::check($errors) &&
            (in_array('require', $errors) ? $this->get() : true);
    }
}
