<?php
include_once 'config/config.php';

db::delete('test');

$test = model::factory('test')
    ->set_test_string('Test')
    ->set_test_text('')
    ->set_test_int('1')
    ->set_test_float(-1.5)
    ->set_test_order('2')
    ->set_test_parent('0')
    ->set_test_table('3')
    ->set_test_image('/')
    ->set_test_file()
    ->set_test_boolean('true')
    ->set_test_select('0')
    ->set_test_date('20140101000000')
    ->set_test_datetime('20140101000001')
    ->set_test_password(md5('qwerty'))
    ->save();
