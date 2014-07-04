<?php
use Adminko\Db\Db;

class model_text extends model
{
    // Получение текста по тегу
    public function get_by_tag($text_tag) {
        $record = Db::selectRow('
            select * from text where text_tag = :text_tag',
                array('text_tag' => $text_tag));
        return $this->get($record['text_id'], $record);
    }
}