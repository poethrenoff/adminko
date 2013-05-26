<?php
class module_text extends module
{
    protected function action_index()
    {
        try {
            $item = model::factory('text')->get($this->get_param('id'));
        } catch (Exception $e) {
            not_found();
        }
        
        $this->view->assign($item);
        $this->content = $this->view->fetch('module/text/item');
    }
}