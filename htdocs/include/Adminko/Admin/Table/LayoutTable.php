<?php
namespace Adminko\Admin\Table;

use Adminko\System;

class LayoutTable extends BuilderTable
{
    protected function actionCopySave($redirect = true)
    {
        $primary_field = parent::actionCopySave(false);
        
        $this->copyLayoutAreas(System::id(), $primary_field);
        
        System::build();
        
        if ($redirect)
            $this->redirect();
        
        return $primary_field;
    }
}
