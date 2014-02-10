<?php
class ModelTest extends PHPUnit_Framework_TestCase
{
	public function testCreate()
	{
		$model = model::factory('text');
		$this->assertInstanceOf('model', $model);
		$this->assertInstanceOf('model_text', $model);
	}
}