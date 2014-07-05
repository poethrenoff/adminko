<?php
namespace Adminko\Admin\Table;

use Adminko\System;

class LayoutTable extends BuilderTable
{
	protected function action_copy_save( $redirect = true )
	{
		$primary_field = parent::action_copy_save( false );
		
		$this -> copy_layout_areas( System::id(), $primary_field );
		
		System::build();
		
		if ( $redirect )
			$this -> redirect();
		
		return $primary_field;
	}
}
