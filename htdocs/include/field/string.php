<?php
class field_string extends field
{
    // Значение поля
    protected $value = '';
    
    public function form() {
        return htmlspecialchars($this->get(), ENT_QUOTES, 'UTF-8');
    }
    
    public function view() {
        return htmlspecialchars($this->get(), ENT_QUOTES, 'UTF-8');
    }
}
