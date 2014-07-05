<?php
namespace Adminko\Admin\Table;

use Adminko\System;
use Adminko\Db\Db;

class ModuleTable extends BuilderTable
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
        
        $this->copy_module_params(System::id(), $primary_field);
        
        if ($redirect)
            $this->redirect();
        
        return $primary_field;
    }
    
    protected function action_delete($redirect = true)
    {
        $module_params = Db::selectAll('
                select * from module_param where param_module = :param_module',
            array('param_module' => System::id()));
        
        parent::action_delete(false);
        
        foreach ($module_params as $module_param)
            Db::delete('param_value', array('value_param' => $module_param['param_id']));
        
        System::build();
        
        if ($redirect)
            $this->redirect();
    }
}
