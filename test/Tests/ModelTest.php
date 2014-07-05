<?php
use Adminko\Model\Model;

class ModelTest extends PHPUnit_Framework_TestCase
{
	public function testCreate()
	{
		$model = Model::factory('text');
		$this->assertInstanceOf('Adminko\Model\Model', $model);
		$this->assertInstanceOf('Adminko\Model\TextModel', $model);
	}
}