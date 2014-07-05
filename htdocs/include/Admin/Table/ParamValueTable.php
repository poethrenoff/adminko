<?php
namespace Adminko\Admin\Table;

use Adminko\System;
use Adminko\Db\Db;

class ParamValueTable extends BuilderTable
{
    protected function action_add_save($redirect = true)
    {
        $primary_field = parent::action_add_save(false);
        
        if ($redirect)
            $this->redirect();
        
        return $primary_field;
    }
    
    protected function action_copy_save($redirect = true)
    {
        $primary_field = parent::action_copy_save(false);
        
        if ($redirect)
            $this->redirect();
        
        return $primary_field;
    }
    
    protected function action_delete($redirect = true)
    {
        $record = $this->get_record();
        $primary_field = $record[$this->primary_field];
        
        parent::action_delete(false);
        
        $default_value = Db::selectCell('select value_id from param_value
                where value_param = :value_param and value_default = 1',
            array('value_param' => $record['value_param']));
        
        Db::update('block_param', array('value' => $default_value),
            array('param' => $record['value_param'], 'value' => $primary_field));
        
        System::build();
        
        if ($redirect)
            $this->redirect();
    }
}