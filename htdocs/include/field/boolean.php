<?php
class field_boolean extends field
{
    protected $value = 0;
    
    public function get() {
        return (boolean) $this->value;
    }
    
    public function view() {
        return $this->get() ? 'да' : 'нет';
    }
    
    public function check($errors = array()) {
        return parent::check($errors) &&
            (in_array('require', $errors) ? $this->get() > 0 : true);
    }
}
