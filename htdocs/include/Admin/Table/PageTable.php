<?php
namespace Adminko\Admin\Table;

use Adminko\System;
use Adminko\Db\Db;

class PageTable extends Table
{
    protected function action_add_save($redirect = true)
    {
        $this->check_page_parent();
        
        $primary_field = parent::action_add_save(false);
        
        if ($redirect)
            System::build();
        
        if ($redirect)
            $this->redirect();
        
        return $primary_field;
    }
    
    protected function action_copy_save($redirect = true)
    {
        $primary_field = parent::action_copy_save(false);
        
        $this->copy_blocks(System::id(), $primary_field);
        
        System::build();
        
        if ($redirect)
            $this->redirect();
        
        return $primary_field;
    }
    
    protected function action_edit_save($redirect = true)
    {
        $this->check_page_parent();
        
        parent::action_edit_save(false);
        
        System::build();
        
        if ($redirect)
            $this->redirect();
    }
    
    protected function action_delete($redirect = true)
    {
        $blocks = Db::selectAll('
                select * from block where block_page = :block_page',
            array('block_page' => System::id()));
        
        parent::action_delete(false);
        
        foreach ($blocks as $block)
            Db::delete('block_param', array('block' => $block['block_id']));
        
        System::build();
        
        if ($redirect)
            $this->redirect();
    }
    
    protected function check_page_parent()
    {
        if (init_string('page_parent'))
            $this->fields['page_name']['errors'][] = 'require';
        else if (init_string('page_name') !== '')
            throw new \AlarmException('Ошибочное значение поля "' . $this->fields['page_name']['title'] . '".');
    }
}
