<?php
namespace Adminko\Module;

use Adminko\System;
use Adminko\Model\Model;

class MenuModule extends Module
{
    protected function action_index()
    {
        $menu_id = $this->get_param('id');
        $menu_template = $this->get_param('template');
        
        $menu_list = Model::factory('menu')->get_list(
            array('menu_active' => 1), array('menu_order' => 'asc')
        );
        
        $site = System::site(); $current_page = System::page();
        $page_list = array_reindex($site['page'], 'page_id');
        foreach ($menu_list as $menu_index => $menu_item) {
            if (isset($page_list[$menu_item->get_menu_page()])) {
                $menu_url = $page_list[$menu_item->get_menu_page()]['page_path'];
                $menu_list[$menu_index]->set_menu_url($menu_url);
            }
            if ($menu_list[$menu_index]->get_menu_url() == $current_page['page_path']) {
                $menu_list[$menu_index]->is_selected = true;
            }
        }
        
        $menu_tree = Model::factory('menu')->get_tree($menu_list, $menu_id);
        
        $this->view->assign($menu_tree);
        $this->content = $this->view->fetch('module/menu/' . $menu_template);
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Дополнительные параметры хэша модуля
    protected function ext_cache_key()
    {
        $current_page = System::page();
        
        return parent::ext_cache_key() +
            array('_page' => $current_page['page_id']);
    }
}