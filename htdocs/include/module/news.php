<?php
namespace Adminko\Module;

use Adminko\System;
use Adminko\Model\Model;

class News extends Module
{
    // Вывод полного списка новостей
    protected function action_index()
    {
        $model_news = Model::factory('news');
        
        $total = $model_news->get_count();
        $count = max(1, intval($this->get_param('count')));
        
        $pages = \Adminko\Paginator::construct($total, array('by_page' => $count));
        
        $item_list = $model_news->get_list(array(), array('news_date' => 'desc'), $pages['by_page'], $pages['offset']);
        
        $this->view->assign('item_list', $item_list);
        $this->view->assign('pages', \Adminko\Paginator::fetch($pages));
        
        $this->content = $this->view->fetch('module/news/list');
    }
    
    // Вывод краткого списка новостей
    protected function action_preview()
    {
        $model_news = Model::factory('news');
        
        $count = max(1, intval($this->get_param('count')));
        
        $item_list = $model_news->get_list(array(), array(), $count);
        
        $this->view->assign('item_list', $item_list);
        
        $this->content = $this->view->fetch('module/news/short');
    }
    
    // Вывод конкретной новости
    protected function action_item()
    {
        try {
            $item = Model::factory('news')->get(System::id());
        } catch (\AlarmException $e) {
            not_found();
        }
        
        $this->view->assign($item);
        $this->output['meta_title'] = $item->get_news_title();
        $this->content = $this->view->fetch('module/news/item');
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Дополнительные параметры хэша модуля
    protected function ext_cache_key()
    {
        return parent::ext_cache_key() +
            ($this->action == 'item' ? array('_id' => System::id()) : array());
    }
}