<?php
include_once 'config/config.php';

$test = model::factory('test')
    ->set_test_string('Test')
    ->set_test_text('Text')
    ->set_test_int(-1)
    ->set_test_float(-1.5)
    ->set_test_order(0)
    ->set_test_parent(1)
    ->set_test_table(2)
    ->set_test_image('')
    ->set_test_file('/path')
    ->set_test_boolean(true)
    ->set_test_active('Да')
    ->set_test_default(0)
    ->set_test_select('x')
    ->set_test_date('20140101000000')
    ->set_test_datetime('20140101000001')
    ->set_test_password('qwerty')
    ->save();
