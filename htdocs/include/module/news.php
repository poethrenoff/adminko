<?php
class module_news extends module
{
    // Вывод полного списка новостей
    protected function action_index()
    {
        $model_news = model::factory('news');
        
        $total = $model_news->get_count();
        $count = max(1, intval($this->get_param('count')));
        
        $pages = paginator::construct($total, array('by_page' => $count));
        
        $item_list = $model_news->get_list(array(), array(), $pages['by_page'], $pages['offset']);
        
        $this->view->assign('item_list', $item_list);
        $this->view->assign('pages', paginator::fetch($pages));
        
        $this->content = $this->view->fetch('module/news/list');
    }
    
    // Вывод краткого списка новостей
    protected function action_preview()
    {
        $model_news = model::factory('news');
        
        $count = max(1, intval($this->get_param('count')));
        
        $item_list = $model_news->get_list(array(), array(), $count);
        
        $this->view->assign('item_list', $item_list);
        
        $this->content = $this->view->fetch('module/news/short');
    }
    
    // Вывод конкретной новости
    protected function action_item()
    {
        try {
            $item = model::factory('news')->get(id());
        } catch (Exception $e) {
            not_found();
        }
        
        $this->view->assign($item);
        $this->output['meta_title'] = $item->get_news_title();
        $this->content = $this->view->fetch('module/news/item');
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Получение списка новостей
    protected function get_list($limit = null, $offset = null)
    {
        $limit_cond = '';
        if (isset($limit))
        {
            $limit_cond .= 'limit ' . $limit;
            if (isset($offset))
                $limit_cond .= ' offset ' . $offset;
        }
        
        return db::select_all('select * from news order by news_date desc ' . $limit_cond);
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Дополнительные параметры хэша модуля
    protected function ext_cache_key()
    {
        return parent::ext_cache_key() +
            ($this->action == 'item' ? array('_id' => id()) : array());
    }
}