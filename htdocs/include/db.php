<?php
abstract class db
{
	protected static $db_driver = null;
	
	protected static function get_driver()
	{
		if ( self::$db_driver == null )
			self::$db_driver = db_driver::factory( DB_TYPE, DB_HOST, '', DB_NAME, DB_USER, DB_PASSWORD );
		
		return self::$db_driver;
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////
	
	public static function query( $query, $fields = array() )
	{
		return static::get_driver() -> query( $query, $fields );
	}
	
	public static function select_cell( $query, $fields = array() )
	{
		return static::get_driver() -> select_cell( $query, $fields );
	}
	
	public static function select_row( $query, $fields = array() )
	{
		return static::get_driver() -> select_row( $query, $fields );
	}
	
	public static function select_all( $query, $fields = array() )
	{
		return static::get_driver() -> select_all( $query, $fields );
	}
	
	public static function insert( $table, $fields = array() )
	{
		return static::get_driver() -> insert( $table, $fields );
	}
	
	public static function update( $table, $fields = array(), $where = array() )
	{
		return static::get_driver() -> update( $table, $fields, $where );
	}
	
	public static function delete( $table, $where = array() )
	{
		return static::get_driver() -> delete( $table, $where );
	}
	
	public static function last_insert_id( $sequence = null )
	{
		return static::get_driver() -> last_insert_id( $sequence );
	}
	
	public static function beginTransaction()
	{
		return static::get_driver() -> beginTransaction();
	}
	
	public static function commit()
	{
		return static::get_driver() -> commit();
	}
	
	public static function rollBack()
	{
		return static::get_driver() -> rollBack();
	}
	
	public static function create()
	{
		return static::get_driver() -> create();
	}
}
