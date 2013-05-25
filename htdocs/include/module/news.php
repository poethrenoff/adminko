<?php
class module_news extends module
{
	// Вывод полного списка новостей
	protected function action_index()
	{
		$total = $this -> get_count();
		$count = max( 1, intval( $this -> get_param( 'count' ) ) );
		
		$pages = paginator::construct( $total, array( 'by_page' => $count ) );
		
		$item_list = $this -> get_list( $pages['by_page'], $pages['offset'] );
		
		$this -> view -> assign( 'item_list', $item_list );
		$this -> view -> assign( 'pages', paginator::fetch( $pages ) );
		
		$this -> content = $this -> view -> fetch( 'module/news/list' );
	}
	
	// Вывод краткого списка новостей
	protected function action_preview()
	{
		$count = max( 1, intval( $this -> get_param( 'count' ) ) );
		
		$item_list = $this -> get_list( $count );
		
		$this -> view -> assign( 'item_list', $item_list );
		
		$this -> content = $this -> view -> fetch( 'module/news/short' );
	}
	
	// Вывод конкретной новости
	protected function action_item()
	{
		$item = $this -> get_item( id() );
		
		$this -> view -> assign( $item );
		
		$this -> output['meta_title'] = $item['news_title'];
		$this -> content = $this -> view -> fetch( 'module/news/item' );
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	// Получение количества новостей
	protected function get_count()
	{
		return db::select_cell( 'select count(*) from news' );
	}
	
	// Получение списка новостей
	protected function get_list( $limit = null, $offset = null )
	{
		$limit_cond = '';
		if ( isset( $limit ) )
		{
			$limit_cond .= 'limit ' . $limit;
			if ( isset( $offset ) )
				$limit_cond .= ' offset ' . $offset;
		}
		
		return db::select_all( 'select * from news order by news_date desc ' . $limit_cond );
	}
	
	// Получение конкретной новости
	protected function get_item( $id )
	{
		$item = db::select_row( 'select * from news where news_id = :news_id',
			array( 'news_id' => $id ) );
		
		if ( !$item )
			not_found();
		
		return $item;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	// Дополнительные параметры хэша модуля
	protected function ext_cache_key()
	{
		return parent::ext_cache_key() +
			( $this -> action == 'item' ? array( '_id' => id() ) : array() );
	}
}