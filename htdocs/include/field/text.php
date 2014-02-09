<?php
class field_text extends field_string
{
    public function view() {
        $content = strip_tags($this->get());
        $content = (mb_strlen($content, 'utf-8') > 80) ? mb_substr($content, 0, 80, 'utf-8') . '...' : $content;
        return htmlspecialchars($content, ENT_QUOTES, 'UTF-8');
    }
}
