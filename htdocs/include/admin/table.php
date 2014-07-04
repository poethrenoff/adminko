<?php
use Adminko\Db\Db;

class admin_table extends admin
{
    protected $primary_field = '';
    protected $main_field = '';
    protected $parent_field = '';
    protected $active_field = '';
    protected $order_field = '';
    
    protected $fields = array();
    protected $show_fields = array();
    protected $filter_fields = array();
    
    protected $links = array();
    protected $relations = array();
    
    protected $sort_field = '';
    protected $sort_order = '';
    
    protected $limit_clause = '';
    
    protected $filter_clause = '';
    protected $filter_binds = array();
    
    protected $records_per_page = 20;
    
    protected $lang_list = array();
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    public function __construct($object)
    {
        parent::__construct($object);
        
        $this->primary_field = $this->object_desc['primary_field'];
        $this->main_field = $this->object_desc['main_field'];
        
        if (isset($this->object_desc['parent_field']))
            $this->parent_field = $this->object_desc['parent_field'];
        if (isset($this->object_desc['active_field']))
            $this->active_field = $this->object_desc['active_field'];
        if (isset($this->object_desc['order_field']))
            $this->order_field = $this->object_desc['order_field'];
        
        $this->fields = $this->object_desc['fields'];
        $this->show_fields = $this->object_desc['show_fields'];
        if (isset($this->object_desc['filter_fields']))
            $this->filter_fields = $this->object_desc['filter_fields'];
        
        if (isset($this->object_desc['links']))
            $this->links = $this->object_desc['links'];
        if (isset($this->object_desc['relations']))
            $this->relations = $this->object_desc['relations'];
        
        $this->sort_field = $this->object_desc['sort_field'];
        $this->sort_order = $this->object_desc['sort_order'];
        
        if (isset(metadata::$objects['lang']))
            $this->lang_list = Db::selectAll('select * from lang order by lang_default desc');
    }
    
    //////////////////////////////////////////////////////////////////////////
    
    protected function action_index()
    {
        $records_header = $this->get_table_headers();
        
        if (!$this->parent_field)
            $this->set_filter_condition();
        
        $records_count = $this->get_records_count();
        
        $pages = paginator::construct($records_count, array('by_page' => $this->records_per_page));
        if (!$this->parent_field)
            $this->set_limit_condition($pages['by_page'], $pages['offset']);
        
        $records = $this->get_records();
        
        if ($this->parent_field)
            $records = $this->get_tree($records);
        
        foreach ($records as $record_id => $record)
        {
            foreach ($this->show_fields as $show_field)
                $records[$record_id][$show_field] = field::factory($this->fields[$show_field]['type'])
                    ->set($records[$record_id][$show_field])->view();
            
            $records[$record_id] += $this->get_record_links($record);
            $records[$record_id] += $this->get_record_relations($record);
            
            $records[$record_id]['_action'] = $this->get_record_actions($record);
            
            $records[$record_id]['_hidden'] = $this->active_field && !$records[$record_id][$this->active_field];
        }
        
        if (!$this->parent_field)
            $this->view->assign('filter', $this->get_filter());
        $this->view->assign('actions', $this->get_table_actions());
        
        $this->view->assign('title', $this->object_desc['title']);
        $this->view->assign('records', $records);
        $this->view->assign('header', $records_header);
        $this->view->assign('counter', $records_count);
        
        if (!$this->parent_field)
            $this->view->assign('pages', paginator::fetch($pages, 'admin/pages'));
        
        $this->content = $this->view->fetch('admin/table');
        
        $this->store_state();
    }
    
    protected function action_add()
    {
        $this->is_action_allow('add', true);
        
        $this->record_card('add');
    }
    
    protected function action_copy()
    {
        $this->is_action_allow('add', true);
        
        $this->record_card('copy');
    }
    
    protected function action_edit()
    {
        $this->is_action_allow('edit', true);
        
        $this->record_card('edit');
    }
    
    protected function action_relation()
    {
        $primary_record = $this->get_record();
        
        $relation_name = init_string('relation');
        if (!isset($this->relations[$relation_name]))
            throw new AlarmException('Ошибка. Связь "' . $relation_name . '" не описана в метаданных.');
        
        $relation = $this->relations[$relation_name];
        
        $secondary_object = admin::factory($relation['secondary_table'], false);
        $secondary_object->show_fields = array($secondary_object->main_field);
        
        $sort_field = init_string('sort_field');
        $sort_order = init_string('sort_order');
        if ($sort_field && in_array($sort_field, array($secondary_object->primary_field, $secondary_object->main_field)))
            $secondary_object->sort_field = $sort_field;
        if ($sort_order && in_array($sort_order, array('asc', 'desc')))
            $secondary_object->sort_order = $sort_order;
        
        foreach (array($secondary_object->primary_field, $secondary_object->main_field) as $show_field)
        {
            $records_header[$show_field] = $secondary_object->fields[$show_field];
            $field_sort_order = $show_field == $secondary_object->sort_field && $secondary_object->sort_order == 'asc' ? 'desc' : 'asc';
            $records_header[$show_field]['sort_url'] =
                request_url(array('sort_field' => $show_field, 'sort_order' => $field_sort_order), array('page'));
            if ($show_field == $secondary_object->sort_field)
                $records_header[$show_field]['sort_sign'] = $field_sort_order == 'asc' ? 'desc' : 'asc';
        }
        
        $records_header[$secondary_object->primary_field]['title'] = 'ID';
        $records_header['_checkbox']['title'] = 'Выбрать';
        
        if (!$secondary_object->parent_field)
        {
            $checked_filter_fields = array(); $checked_filter_binds = array();
            
            $checked_search_value = init_string('_checked');
            
            if ($checked_search_value !== '')
            {
                $checked_filter_fields[] = ($checked_search_value ? '' : 'not ') . 
                    'exists (select * from ' . $relation['relation_table'] .
                        ' where ' . $relation['relation_table'] . '.' . $relation['secondary_field'] . ' = '. $secondary_object->object . '.' . $secondary_object->primary_field . ' and ' .
                            $relation['relation_table'] . '.' . $relation['primary_field'] . ' = :checked_' . $this->primary_field . ')';
                
                $checked_filter_binds['checked_' . $this->primary_field] = $primary_record[$this->primary_field];
            }
            
            $secondary_object->set_filter_condition($checked_filter_fields, $checked_filter_binds);
        }
        
        $records_count = $secondary_object->get_records_count();
        
        $pages = paginator::construct($records_count, array('by_page' => $secondary_object->records_per_page));
        if (!$secondary_object->parent_field)
            $secondary_object->set_limit_condition($pages['by_page'], $pages['offset']);
        
        $records = $secondary_object->get_records();
        if ($secondary_object->parent_field)
            $records = $secondary_object->get_tree($records);
        
        $secondary_list = array();
        foreach ($records as $record_id => $record)
            $secondary_list[] = $record[$secondary_object->primary_field];
        
        $checked_query = 'select ' . $relation['secondary_field'] . ' from ' . $relation['relation_table'] . ' where ' . $relation['primary_field'] . ' = :' . $relation['primary_field'] .
            (count($secondary_list) ? ' and ' . $relation['secondary_field'] . ' in (' . join(', ', $secondary_list) . ')' : '');
        $checked_records = Db::selectAll($checked_query, array($relation['primary_field'] => $primary_record[$this->primary_field]));
        
        $checked_list = array();
        foreach ($checked_records as $record_id => $record)
            $checked_list[] = $record[$relation['secondary_field']];
        
        foreach ($records as $record_id => $record)
        {
            $records[$record_id][$secondary_object->main_field] =
                field::factory($secondary_object->fields[$secondary_object->main_field]['type'])
                    ->set($records[$record_id][$secondary_object->main_field])->view();
            
            $records[$record_id]['_checkbox'] = array('id' => $record[$secondary_object->primary_field],
                'checked' => in_array($record[$secondary_object->primary_field], $checked_list));
        }
        
        if (!$secondary_object->parent_field)
        {
            $secondary_object->filter_fields[] = '_checked';
            $secondary_object->fields['_checked'] = array('title' => 'Показать', 'type' => 'boolean', 'filter' => 1);
            
            $this->view->assign('filter', $secondary_object->get_filter());
        }
        
        $title = field::factory($this->fields[$this->main_field]['type'])
            ->set($primary_record[$this->main_field])->view();
        
        $this->view->assign('title', $this->object_desc['title'] . ' :: ' . $title);
        $this->view->assign('records', $records);
        $this->view->assign('header', $records_header);
        $this->view->assign('counter', $records_count);
        
        $this->view->assign('mode', 'form');
        
        $this->view->assign('back_url', url_for($this->restore_state()));
        
        $form_url = url_for(array('object' => $this->object, 'action' => 'relation_save',
            'relation' => $relation_name, 'id' => $primary_record[$this->primary_field]));
        $this->view->assign('form_url', $form_url);
        
        if (!$secondary_object->parent_field)
            $this->view->assign('pages', paginator::fetch($pages, 'admin/pages'));
        
        $this->content = $this->view->fetch('admin/table');
        $this->output['meta_title'] .= ' :: ' . $title;
        
        $this->store_state('prev_relation_url');
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    protected function action_add_save($redirect = true)
    {
        $this->is_action_allow('add', true);
        
        $insert_fields = array(); $translate_values = array();
        foreach ($this->fields as $field_name => $field_desc)
        {
            if (isset($field_desc['no_add']) && $field_desc['no_add'])
                continue;
            
            if ($field_desc['type'] != 'pk' && $field_desc['type'] != 'order' &&
                    !($field_desc['type'] == 'password' && init_string($field_name) === ''))
            {
                if (isset($field_desc['translate']) && $field_desc['translate'])
                {
                    foreach (init_array($field_name) as $record_lang => $record_value) {
                        $field = field::factory($field_desc['type'])->set($record_value);
                        if (!($field->check($field_desc['errors']))) {
                            throw new AlarmException('Ошибочное значение поля "' . $field_desc['title'] . '".');
                        }
                        $translate_values[$field_name][$record_lang] = $field->get();
                    }
                    $insert_fields[$field_name] = current($translate_values[$field_name]);
                }
                else
                {
                    $field = field::factory($field_desc['type']);
                    $value = ($field_desc['type'] == 'image' || $field_desc['type'] == 'file') ?
                        $this->upload_file($field_name, $field_desc) : init_string($field_name);
                    if (!($field->parse($value))) {
                        throw new AlarmException('Ошибочное значение поля "' . $field_desc['title'] . '".');
                    }
                    if (!($field->check($field_desc['errors']))) {
                        throw new AlarmException('Ошибочное значение поля "' . $field_desc['title'] . '".');
                    }
                    $insert_fields[$field_name] = $field->get();
                }
            }
        }
        
        if ($this->order_field)
        {
            list($group_conds, $group_binds) =
                $this->get_group_conds($insert_fields, $this->order_field);
            $field = field::factory($this->fields[$this->order_field]['type'])
                ->set($this->get_edge_order(true, $group_conds, $group_binds));
            $insert_fields[$this->order_field] = $field->get();
        }
        
        $this->check_group_unique($insert_fields);
        
        $this->clear_default_fields($insert_fields);
        
        Db::insert($this->object, $insert_fields);
        
        $primary_field = Db::lastInsertId();
        
        $this->change_translate_record($this->object, $primary_field, $translate_values);
        
        if ($redirect)
            $this->redirect();
        
        return $primary_field;
    }
    
    protected function action_copy_save($redirect = true)
    {
        $primary_field = $this->action_add_save(false);
        
        if ($redirect)
            $this->redirect();
        
        return $primary_field;
    }
    
    protected function action_edit_save($redirect = true)
    {
        $this->is_action_allow('edit', true);
        
        $record = $this->get_record();
        $primary_field = $record[$this->primary_field];
        
        $update_fields = array(); $translate_values = array();
        foreach ($this->fields as $field_name => $field_desc)
        {
            if (isset($field_desc['no_edit']) && $field_desc['no_edit'])
                continue;
            
            if ($field_desc['type'] != 'pk' && $field_desc['type'] != 'order' &&
                    !($field_desc['type'] == 'password' && init_string($field_name) === ''))
            {
                if (isset($field_desc['translate']) && $field_desc['translate'])
                {
                    foreach (init_array($field_name) as $record_lang => $record_value) {
                        $field = field::factory($field_desc['type'])->set($record_value);
                        if (!($field->check($field_desc['errors']))) {
                            throw new AlarmException('Ошибочное значение поля "' . $field_desc['title'] . '".');
                        }
                        $translate_values[$field_name][$record_lang] = $field->get();
                    }
                    $update_fields[$field_name] = current($translate_values[$field_name]);
                }
                else
                {
                    $field = field::factory($field_desc['type']);
                    $value = ($field_desc['type'] == 'image' || $field_desc['type'] == 'file') ?
                        $this->upload_file($field_name, $field_desc) : init_string($field_name);
                    if (!($field->parse($value))) {
                        throw new AlarmException('Ошибочное значение поля "' . $field_desc['title'] . '".');
                    }
                    if (!($field->check($field_desc['errors']))) {
                        throw new AlarmException('Ошибочное значение поля "' . $field_desc['title'] . '".');
                    }
                    $update_fields[$field_name] = $field->get();
                }
            }
        }
        
        if ($this->order_field)
        {
            list($group_conds, $group_binds) =
                $this->get_group_conds($update_fields, $this->order_field);
            
            $record = $this->get_record();
            
            $group_permanent = true;
            foreach ($group_binds as $field_name => $field_value)
                $group_permanent &= $record[$field_name] == $field_value;
            
            if (!$group_permanent) {
                $field = field::factory($this->fields[$this->order_field]['type'])
                    ->set($this->get_edge_order(true, $group_conds, $group_binds));
                $update_fields[$this->order_field] = $field->get();
            }
        }
        
        $this->check_group_unique($update_fields, $primary_field);
        
        $this->clear_default_fields($update_fields);
        
        Db::update($this->object, $update_fields, array($this->primary_field => $primary_field));
        
        $this->change_translate_record($this->object, $primary_field, $translate_values);
        
        if ($redirect)
            $this->redirect();
    }
    
    protected function action_move($redirect = true)
    {
        $this->is_action_allow('edit', true);
        
        $record = $this->get_record();
        $primary_field = $record[$this->primary_field];
        
        if ($this->order_field)
        {
            $record = $this->get_record();
            
            list($order_conds, $order_binds) =
                $this->get_group_conds($record, $this->order_field);
            
            $direction = (boolean) init_string('dir');
            
            if ($sibling_record = $this->get_sibling_record($direction, $order_conds, $order_binds, $record))
            {
                $field = field::factory($this->fields[$this->order_field]['type'])
                    ->set($sibling_record[$this->order_field]);
                Db::update($this->object, array($this->order_field => $field->get()),
                    array($this->primary_field => $primary_field));
                
                $field = field::factory($this->fields[$this->order_field]['type'])
                    ->set($record[$this->order_field]);
                Db::update($this->object, array($this->order_field => $field->get()),
                    array($this->primary_field => $sibling_record[$this->primary_field]));
            }
            else
            {
                $field = field::factory($this->fields[$this->order_field]['type'])
                    ->set($this->get_edge_order(!$direction, $order_conds, $order_binds));
                Db::update($this->object, array($this->order_field => $field->get()),
                    array($this->primary_field => $record[$this->primary_field]));
            }
        }
        
        if ($redirect)
            $this->redirect();
    }
    
    protected function action_show($redirect = true)
    {
        $this->is_action_allow('edit', true);
        
        $record = $this->get_record();
        $primary_field = $record[$this->primary_field];
        
        if ($this->active_field)
            Db::update($this->object, array($this->active_field => 1),
                array($this->primary_field => $primary_field));
        
        if ($redirect)
            $this->redirect();
    }
    
    protected function action_hide($redirect = true)
    {
        $this->is_action_allow('edit', true);
        
        $record = $this->get_record();
        $primary_field = $record[$this->primary_field];
        
        if ($this->active_field)
            Db::update($this->object, array($this->active_field => 0),
                array($this->primary_field => $primary_field));
        
        if ($redirect)
            $this->redirect();
    }
    
    protected function action_delete($redirect = true)
    {
        $this->is_action_allow('delete', true);
        
        $record = $this->get_record();
        $primary_field = $record[$this->primary_field];
        
        if ($this->parent_field)
        {
            $query = 'select count(*) as _count from ' . $this->object . '
                where ' . $this->parent_field . ' = :primary_field';
            $records_count = Db::selectRow($query, array('primary_field' => $primary_field));
            
            if ($records_count['_count'])
                throw new AlarmException('Ошибка. Невозможно удалить запись, так как у нее есть дочерние записи.');
        }
        
        if (isset($this->links) && is_array($this->links))
        {
            foreach ($this->links as $link_name => $link_desc)
            {
                $ondelete_action = isset($link_desc['ondelete']) ? $link_desc['ondelete'] : '';
                
                if ($ondelete_action == 'set_null' || $ondelete_action == 'cascade')
                {
                    $link_table_desc = metadata::$objects[$link_desc['table']];
                    
                    if (isset($link_table_desc['primary_field']))
                    {
                        $link_query = 'select ' . $link_table_desc['primary_field'] . ' from ' . $link_desc['table'] . '
                            where ' . $link_desc['field'] . ' = :primary_field';
                        $link_records = Db::selectAll($link_query, array('primary_field' => $primary_field));
                        
                        foreach ($link_records as $link_record)
                            $this->delete_translate_record($link_desc['table'], $link_record[$link_table_desc['primary_field']]);
                    }
                    
                    if ($ondelete_action == 'cascade')
                        Db::delete($link_desc['table'], array($link_desc['field'] => $primary_field));
                    else
                        Db::update($link_desc['table'], array($link_desc['field'] => null),
                            array($link_desc['field'] => $primary_field));
                }
                else if ($ondelete_action != 'ignore')
                {
                    $query = 'select count(*) as _count from ' . $link_desc['table'] . '
                        where ' . $link_desc['field'] . ' = :primary_field';
                    $records_count = Db::selectRow($query, array('primary_field' => $primary_field));
                    
                    if ($records_count['_count'])
                        throw new AlarmException('Ошибка. Невозможно удалить запись, так как у нее есть зависимые записи в таблице "' .
                            metadata::$objects[$link_desc['table']]['title'] . '".');
                }
            }
        }
        
        if (isset($this->relations) && is_array($this->relations))
            foreach ($this->relations as $relation_name => $relation_desc)
                Db::delete($relation_desc['relation_table'], array($relation_desc['primary_field'] => $primary_field));
        
        $this->delete_translate_record($this->object, $primary_field);
        
        Db::delete($this->object, array($this->primary_field => $primary_field));
        
        if ($redirect)
            $this->redirect();
    }
    
    protected function action_relation_save($redirect = true)
    {
        $primary_record = $this->get_record();
        
        $relation_name = init_string('relation');
        if (!isset($this->relations[$relation_name]))
            throw new AlarmException('Ошибка. Связь "' . $relation_name . '" не описана в метаданных.');
        
        $relation = $this->relations[$relation_name];
        
        $checked_list = init_array('check');
        foreach ($checked_list as $checked_id => $checked_value)
        {
            $relation_key = array($relation['primary_field'] => $primary_record[$this->primary_field],
                $relation['secondary_field'] => $checked_id);
            
            Db::delete($relation['relation_table'], $relation_key);
            if ($checked_value)
                Db::insert($relation['relation_table'], $relation_key);
        }
        
        if ($redirect)
            $this->redirect('prev_relation_url');
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    protected function set_limit_condition($limit = 0, $offset = 0)
    {
        $this->limit_clause = 'limit ' . $limit . ($offset ? ' offset ' . $offset : '');
    }
    
    protected function set_filter_condition($filter_fields = array(), $filter_binds = array())
    {
        foreach ($this->filter_fields as $filter_field)
        {
            $search_value = init_string($filter_field);
            
            if ($search_value !== '')
            {
                if (in_array($this->fields[$filter_field]['type'], array('string', 'text')) ||
                    $this->fields[$filter_field]['type'] == 'table' && $this->fields[$filter_field]['search'] == 'text')
                {
                    $search_words = preg_split('/\s+/', $search_value);
                    
                    if ($this->fields[$filter_field]['type'] == 'table')
                    {
                        $table_filter_fields = array();
                        foreach ($search_words as $search_index => $search_word)
                        {
                            $table_filter_fields[] = 'lower(' . metadata::$objects[$this->fields[$filter_field]['table']]['main_field'] . ') like :' . $filter_field . '_' . $search_index;
                            $filter_binds[$filter_field . '_' . $search_index] = '%' . mb_strtolower($search_word , 'utf-8') . '%';
                        }
                        
                        if ($table_filter_fields)
                            $filter_fields[] = $this->object . '.' . $filter_field . ' in (select ' . 
                                metadata::$objects[$this->fields[$filter_field]['table']]['primary_field'] . ' from ' .
                                    $this->fields[$filter_field]['table'] . ' where ' . join(' and ', $table_filter_fields) . ')';
                    }
                    else
                    {
                        foreach ($search_words as $search_index => $search_word)
                        {
                            $filter_fields[] = 'lower(' . $this->object . '.' . $filter_field . ') like :' . $filter_field . '_' . $search_index;
                            $filter_binds[$filter_field . '_' . $search_index] = '%' . mb_strtolower($search_word , 'utf-8') . '%';
                        }
                    }
                }
                else
                {
                    $filter_fields[] = $this->object . '.' . $filter_field . ' = :' . $filter_field;
                    $filter_binds[$filter_field] = $search_value;
                }
            }
        }
        
        if (count($filter_fields))
        {
            $this->filter_binds = $filter_binds;
            $this->filter_clause = 'where ' . join(' and ', $filter_fields);
        }
    }
    
    protected function get_records()
    {
        $select_fields = $this->show_fields;
        $select_fields[] = $this->primary_field;
        if ($this->parent_field)
            $select_fields[] = $this->parent_field;
        if ($this->active_field)
            $select_fields[] = $this->active_field;
        if ($this->order_field)
            $select_fields[] = $this->order_field;
        
        $query_fields = array(); $query_joins = array(); $query_binds = array();
        foreach ($select_fields as $select_field)
        {
            if ($this->fields[$select_field]['type'] == 'table')
            {
                $table_alias = $this->fields[$select_field]['table'] . '_' . $select_field;
                
                $query_fields[] = $table_alias .
                    '.' . metadata::$objects[$this->fields[$select_field]['table']]['primary_field'] .
                    ' as _' . $select_field;
                $query_fields[] = $table_alias .
                    '.' . metadata::$objects[$this->fields[$select_field]['table']]['main_field'] .
                    ' as ' . $select_field;
                $query_joins[] = 'left join ' . $this->fields[$select_field]['table'] . ' as ' . $table_alias .
                    ' on ' . $table_alias .
                    '.' . metadata::$objects[$this->fields[$select_field]['table']]['primary_field'] .
                    ' = ' . $this->object . '.' . $select_field;
            }
            else if ($this->fields[$select_field]['type'] == 'select')
            {
                $case_items = array('case ' . $this->object . '.' . $select_field . '');
                for ($i = 0; $i < count($this->fields[$select_field]['values']); $i++)
                {
                    $case_items[] = 'when :' . $select_field . '_value_' . $i . ' then :' . $select_field . '_title_' . $i;
                    $query_binds[$select_field . '_value_' . $i] = $this->fields[$select_field]['values'][$i]['value'];
                    $query_binds[$select_field . '_title_' . $i] = $this->fields[$select_field]['values'][$i]['title'];
                }
                $case_items[] = 'else \'\' end';
                
                $query_fields[] = $this->object . '.' . $select_field . ' as _' . $select_field;
                $query_fields[] = join(' ', $case_items) . ' as ' . $select_field;
            }
            else
            {
                $query_fields[] = $this->object . '.' . $select_field;
            }
        }
        
        $query = 'select ' . join(', ', $query_fields) . ' from ' . $this->object . ' ' .join(' ', $query_joins) . ' ' .
            $this->filter_clause . ' order by ' . $this->sort_field . ' ' . $this->sort_order . ' ' . $this->limit_clause;
        
        return Db::selectAll($query, $this->filter_binds + $query_binds);
    }
    
    public function get_table_records($table, $except = array())
    {
        $table_object = admin::factory($table, false);
        
        $table_object->sort_field = $table_object->main_field;
        $table_object->sort_order = 'asc';
        
        $table_records = $table_object->get_records();
        
        if ($table_object->parent_field)
            $table_records = $table_object->get_tree($table_records, 0, $except);
        
        $result_records = array();
        foreach ($table_records as $table_record)
            $result_records[] = array(
                'value' => (string) $table_record[$table_object->primary_field],
                'title' => field::factory($table_object->fields[$table_object->main_field]['type'])
                    ->set($table_record[$table_object->main_field])->view(),
                '_depth' => isset($table_record['_depth']) ? $table_record['_depth'] : '');
        
        return $result_records;
    }
    
    protected function get_records_count()
    {
        $query = 'select count(*) as _count from ' . $this->object . ' ' . $this->filter_clause;
        $records_count = Db::selectRow($query, $this->filter_binds);
        
        return $records_count['_count'];
    }
    
    protected function get_table_actions()
    {
        $actions = array();
        
        if ($this->is_action_allow('add'))
            $actions['add'] = array('title' => 'Добавить', 'url' =>
                url_for(array('object' => $this->object, 'action' => 'add')));
        
        return $actions;
    }
    
    protected function get_table_headers()
    {
        $sort_field = init_string('sort_field');
        $sort_order = init_string('sort_order');
        if ($sort_field && in_array($sort_field, array_merge(array($this->primary_field), $this->show_fields)))
            $this->sort_field = $sort_field;
        if ($sort_order && in_array($sort_order, array('asc', 'desc')))
            $this->sort_order = $sort_order;
        
        foreach (array_merge(array($this->primary_field), $this->show_fields) as $show_field)
        {
            $records_header[$show_field] = $this->fields[$show_field];
            $field_sort_order = $show_field == $this->sort_field && $this->sort_order == 'asc' ? 'desc' : 'asc';
            $records_header[$show_field]['sort_url'] =
                request_url(array('sort_field' => $show_field, 'sort_order' => $field_sort_order), array('page'));
            if ($show_field == $this->sort_field)
                $records_header[$show_field]['sort_sign'] = $field_sort_order == 'asc' ? 'desc' : 'asc';
        }
        
        $records_header[$this->primary_field]['title'] = 'ID';
        
        foreach ($this->links as $link_name => $link_desc)
            if (!isset($link_desc['hidden']) || !$link_desc['hidden'])
                $records_header[$link_name] = array('title' => isset($link_desc['title']) ? $link_desc['title'] :
                    (isset(metadata::$objects[$link_desc['table']]['title']) ?
                        metadata::$objects[$link_desc['table']]['title'] : ''), 'type' => '_link');
        foreach ($this->relations as $relation_name => $relation_desc)
            if (!isset($relation_desc['hidden']) || !$relation_desc['hidden'])
                $records_header[$relation_name] = array('title' => isset($relation_desc['title']) ? $relation_desc['title'] :
                    (isset(metadata::$objects[$relation_desc['secondary_table']]['title']) ?
                        metadata::$objects[$relation_desc['secondary_table']]['title'] : ''), 'type' => '_link');
        
        $records_header['_action'] = array('title' => 'Действия');
        
        return $records_header;
    }
    
    protected function get_record_actions($record)
    {
        $actions = array();
        
        if ($this->parent_field && $this->is_action_allow('add'))
            $actions['add'] = array('title' => 'Добавить', 'url' =>
                url_for(array('object' => $this->object, 'action' => 'add',
                    'id' => $record[$this->primary_field])));
        if ($this->is_action_allow('edit'))
            $actions['edit'] = array('title' => 'Редактировать', 'url' =>
                url_for(array('object' => $this->object, 'action' => 'edit',
                    'id' => $record[$this->primary_field])));
        if ($this->is_action_allow('add'))
            $actions['copy'] = array('title' => 'Копировать', 'url' =>
                url_for(array('object' => $this->object, 'action' => 'copy',
                    'id' => $record[$this->primary_field])));
        if ($this->order_field && $this->is_action_allow('edit'))
        {
            $actions['move_down'] = array('title' => 'Опустить вниз', 'url' =>
                url_for(array('object' => $this->object, 'action' => 'move', 'dir' => 1, 
                    'id' => $record[$this->primary_field])));
            $actions['move_up'] = array('title' => 'Поднять наверх', 'url' =>
                url_for(array('object' => $this->object, 'action' => 'move', 'dir' => 0,
                    'id' => $record[$this->primary_field])));
        }
        if ($this->active_field && $this->is_action_allow('edit'))
        {
            if (!$record[$this->active_field])
                $actions['show'] = array('title' => 'Показать', 'url' =>
                    url_for(array('object' => $this->object, 'action' => 'show',
                        'id' => $record[$this->primary_field])));
            else
                $actions['hide'] = array('title' => 'Скрыть', 'url' =>
                    url_for(array('object' => $this->object, 'action' => 'hide',
                        'id' => $record[$this->primary_field])));
        }
        if ($this->is_action_allow('delete'))
            $actions['delete'] = array('title' => 'Удалить', 'url' =>
                url_for(array('object' => $this->object, 'action' => 'delete',
                    'id' => $record[$this->primary_field])),
                'event' => array('method' => 'onclick', 'value' => 'return confirm(\'Вы действительно хотите удалить эту запись?\')'));
        
        $actions['separator'] = array();
        
        return $actions;
    }
    
    protected function get_record_links($record)
    {
        if (!count($this->links))
            return array();
        
        $links = array();
        
        foreach ($this->links as $link_name => $link_desc)
        {
            if (isset($link_desc['hidden']) && $link_desc['hidden']) continue;
            
            $show_link = true;
            if (isset($link_desc['show']) && is_array($link_desc['show']))
            {
                foreach ($link_desc['show'] as $show_field_name => $show_field_values)
                {
                    if ($this->fields[$show_field_name]['type'] == 'select' ||
                            $this->fields[$show_field_name]['type'] == 'table')
                        $show_field_name = '_' . $show_field_name;
                    $show_link &= in_array($record[$show_field_name], $show_field_values);
                }
            }
            
            if (!$show_link) continue;
            
            $links[$link_name] = array('title' => 'Перейти',
                'url' => url_for(array('object' => $link_desc['table'], $link_desc['field'] => $record[$this->primary_field])));
        }
        
        return $links;
    }
    
    protected function get_record_relations($record)
    {
        if (!count($this->relations))
            return array();
        
        $relations = array();
        foreach ($this->relations as $relation_name => $relation_desc)
            $relations[$relation_name] = array('title' => 'Перейти',
                'url' => url_for(array('object' => $this->object, 'action' => 'relation', 'relation' => $relation_name,
                    'id' => $record[$this->primary_field])));
        
        return $relations;
    }
    
    protected function get_filter()
    {
        if (!count($this->filter_fields))
            return '';
        
        $search_fields = array();
        
        foreach ($this->filter_fields as $field_name)
        {
            if (isset($this->fields[$field_name]['no_filter']) && $this->fields[$field_name]['no_filter'])
                continue;
            
            $search_fields[$field_name] = $this->fields[$field_name];
            $search_fields[$field_name]['value'] = field::factory($this->fields[$field_name]['type'])
                ->set(init_string($field_name))->form();
            
            if ($this->fields[$field_name]['type'] == 'select')
                $search_fields[$field_name]['values'] = $this->fields[$field_name]['values'];
            if ($this->fields[$field_name]['type'] == 'table' && $this->fields[$field_name]['search'] != 'text')
                $search_fields[$field_name]['values'] = $this->get_table_records($this->fields[$field_name]['table']);
        }
        
        $view = new view();
        
        $view->assign('fields', $search_fields);
        $view->assign('form_url', self_url());
        
        $hidden_fields = prepare_query($_GET, array_merge(array_keys($search_fields), array('page')));
        $view->assign('hidden', $hidden_fields);
        
        return $view->fetch('admin/filter');
    }
    
    protected function get_group_conds($record, $field_name)
    {
        $group_conds = array(); $group_binds = array();
        
        if (isset($this->fields[$field_name]['group']))
        {
            foreach ($this->fields[$field_name]['group'] as $group_field_name)
            {
                $group_conds[] = $group_field_name . ' = :' . $group_field_name;
                $group_binds[$group_field_name] = $record[$group_field_name];
            }
        }
        
        return array($group_conds, $group_binds);
    }
    
    protected function check_group_unique($record, $primary_field = '')
    {
        foreach ($this->fields as $field_name => $field_desc)
        {
            if (!isset($this->fields[$field_name]['group']) ||
                    $field_desc['type'] == 'order' || $field_desc['type'] == 'default')
                continue;
            
            list($group_conds, $group_binds) =
                $this->get_group_conds($record, $field_name);
            
            $group_conds[] = $field_name . ' = :' . $field_name;
            $group_binds[$field_name] = $record[$field_name];
            
            if ($primary_field)
            {
                $group_conds[] = $this->primary_field . ' <> :' . $this->primary_field;
                $group_binds[$this->primary_field] = $primary_field;
            }
            
            $query = 'select count(*) as _count from ' . $this->object . '
                where ' . join(' and ', $group_conds);
            
            $records_count = Db::selectRow($query, $group_binds);
            
            if ($records_count['_count'])
                throw new AlarmException('Ошибка. Запись не удовлетворяет условию группировки.');
        }
    }
    
    protected function clear_default_fields($record)
    {
        foreach ($this->fields as $field_name => $field_desc)
        {
            if ($field_desc['type'] == 'default' && $record[$field_name])
            {
                $group_where = array();
                if (isset($field_desc['group']))
                    foreach ($field_desc['group'] as $group_field_name)
                        $group_where[$group_field_name] = $record[$group_field_name];
                
                Db::update($this->object, array($field_name => 0), $group_where);
            }
        }
    }
    
    protected function get_edge_order($direction, $order_conds, $order_binds)
    {
        $order_clause = count($order_conds) ? 'where ' . join(' and ', $order_conds) : '';
        
        $query = 'select ' . ($direction ? 'max' : 'min') . '(' . $this->order_field . ') as _edge_order
            from ' . $this->object . ' ' . $order_clause;
        $max_record = Db::selectRow($query, $order_binds);
        
        $edge_order = $max_record['_edge_order'];
        
        return $direction ? ++$edge_order : --$edge_order;
    }
    
    protected function get_sibling_record($direction, $order_conds, $order_binds, $record)
    {
        $order_conds[] = $this->order_field . ' ' . ($direction ? '>' : '<') . ' :' . $this->order_field;
        $order_binds[$this->order_field] = $record[$this->order_field];
        
        $order_clause = count($order_conds) ? 'where ' . join(' and ', $order_conds) : '';
        
        $query = 'select * from ' . $this->object . ' ' . $order_clause . '
            order by ' . $this->order_field . ' ' . ($direction ? 'asc' : 'desc') . ' limit 1';
        
        return Db::selectRow($query, $order_binds);
    }
    
    protected function get_record($primary_field = '')
    {
        if ($primary_field === '') $primary_field = id();
        
        $query = 'select * from ' . $this->object . ' where ' . $this->primary_field . ' = :primary_field';
        $record = Db::selectRow($query, array('primary_field' => $primary_field));
        
        if (!$record)
            throw new AlarmException('Ошибка. Запись не найдена.');
        
        foreach ($this->fields as $field_name => $field_desc)
            if (isset($field_desc['translate']) && $field_desc['translate'])
                $record[$field_name] = $this->get_translate_values($this->object, $field_name, $primary_field);
        
        return $record;
    }
    
    protected function record_card($action = 'edit')
    {
        if ($action == 'edit' || $action == 'copy')
            $record = $this->get_record();
        
        $prev_url = $this->restore_state();
        
        $form_fields = array();
        
        foreach ($this->fields as $field_name => $field_desc)
        {
            if ($field_desc['type'] == 'pk' || $field_desc['type'] == 'order' ||
                    ($action == 'add' || $action == 'copy') && isset($field_desc['no_add']) && $field_desc['no_add'] ||
                    $action == 'edit' && isset($field_desc['no_edit']) && $field_desc['no_edit'])
                continue;
            
            $form_fields[$field_name] = $field_desc;
            
            if ($action == 'edit' || $action == 'copy') {
                if (isset($field_desc['translate']) && $field_desc['translate'])
                    foreach ($record[$field_name] as $record_lang => $record_value)
                        $form_fields[$field_name]['value'][$record_lang] =
                            field::factory($field_desc['type'])->set($record_value)->form();
                else
                    $form_fields[$field_name]['value'] =
                        field::factory($field_desc['type'])->set($record[$field_name])->form();
            }
            
            if ($action == 'add')
            {
                if (($field_desc['type'] == 'parent') && ($parent_field = id()))
                    $form_fields[$field_name]['value'] = field::factory($field_desc['type'])
                        ->set($parent_field)->form();
                
                if (($field_desc['type'] == 'table' || $field_desc['type'] == 'select') &&
                        isset($prev_url[$field_name]) && $prev_url[$field_name])
                    $form_fields[$field_name]['value'] = field::factory($field_desc['type'])
                        ->set($prev_url[$field_name])->form();
                
                if (($field_desc['type'] == 'string' || $field_desc['type'] == 'text' ||
                        $field_desc['type'] == 'int' || $field_desc['type'] == 'float') && isset($field_desc['default']))
                    $form_fields[$field_name]['value'] = field::factory($field_desc['type'])
                        ->set($field_desc['default'])->form();
            }
            
            if ($field_desc['type'] == 'select')
                $form_fields[$field_name]['values'] = $field_desc['values'];
            if ($field_desc['type'] == 'table')
                $form_fields[$field_name]['values'] = $this->get_table_records($field_desc['table']);
            if ($field_desc['type'] == 'parent')
            {
                $except = $action == 'edit' ? array($record[$this->primary_field]) : array();
                $form_fields[$field_name]['values'] = $this->get_table_records($this->object, $except);
            }
            
            if ($field_desc['type'] == 'parent' || $field_desc['type'] == 'table')
                $form_fields[$field_name]['errors'] = array_merge($form_fields[$field_name]['errors'], array('int'));
            if ($field_desc['type'] == 'date')
                $form_fields[$field_name]['errors'] = array_merge($form_fields[$field_name]['errors'], array('date'));
            if ($field_desc['type'] == 'datetime')
                $form_fields[$field_name]['errors'] = array_merge($form_fields[$field_name]['errors'], array('datetime'));
            if ($field_desc['type'] == 'int')
                $form_fields[$field_name]['errors'] = array_merge($form_fields[$field_name]['errors'], array('int'));
            if ($field_desc['type'] == 'float')
                $form_fields[$field_name]['errors'] = array_merge($form_fields[$field_name]['errors'], array('float'));
            if ($field_desc['type'] == 'password')
                $form_fields[$field_name]['errors'] = array_merge($form_fields[$field_name]['errors'], array('alpha'));
            
            $form_fields[$field_name]['require'] = in_array('require', $form_fields[$field_name]['errors']);
        }
        
        if (count($form_fields) == 0)
            throw new AlarmException('Ошибка. Нет полей, доступных для изменения.');
        
        $record_title = ($action != 'add') ? field::factory($this->fields[$this->main_field]['type'])
            ->set($record[$this->main_field])->view() : '';
        
        switch ($action)
        {
            case 'edit': $action_title = 'Редактирование записи'; break;
            case 'copy': $action_title = 'Копирование записи'; break;
            default: $action_title = 'Добавление записи';
        }
        
        if ($action == 'copy' && $this->fields[$this->main_field]['type'] == 'string')
        {
            if (isset($this->fields[$this->main_field]['translate']) && $this->fields[$this->main_field]['translate'])
                foreach ($form_fields[$this->main_field]['value'] as $record_lang => $record_value)
                    $form_fields[$this->main_field]['value'][$record_lang] = $record_value . ' (копия)';
            else
                $form_fields[$this->main_field]['value'] = $form_fields[$this->main_field]['value'] . ' (копия)';
        }
        
        $this->view->assign('lang_list', $this->lang_list);
        $this->view->assign('record_title', $this->object_desc['title'] . ($record_title ? ' :: ' . $record_title : ''));
        $this->view->assign('action_title', $action_title);
        $this->view->assign('fields', $form_fields);
        
        $form_url = url_for(array_merge(array('object' => $this->object, 'action' => $action . '_save'),
            $action != 'add' ? array('id' => $record[$this->primary_field]) : array()));
        $this->view->assign('form_url', $form_url);
        
        $this->view->assign('scripts', $this->get_card_scripts($action, $action == 'edit' ? $record : null));
        
        $this->view->assign('back_url', url_for($prev_url));
        
        $this->content = $this->view->fetch('admin/form');
        $this->output['meta_title'] .= ($record_title ? ' :: ' . $record_title : '') . ' :: ' . $action_title;
    }
    
    protected function get_card_scripts($action = 'edit', $record = null)
    {
        return array();
    }
    
    protected function upload_file($field_name, $field_desc)
    {
        if (isset($_FILES[$field_name . '_file']['name']) && $_FILES[$field_name . '_file']['name'])
        {
            $allowed_types = ($field_desc['type'] == 'image') ? 'gif|jpg|jpe|jpeg|png' : '';
            
            $upload = upload::fetch($field_name . '_file', array('upload_path' => $field_desc['upload_dir'], 'allowed_types' => $allowed_types));
            
            if ($upload->is_error())
                throw new AlarmException('Ошибка. Поле "' . $field_desc['title'] . '": ' . $upload->get_error() . '.');
            
            return $upload->get_file_link();
        }
        
        return init_string($field_name);
    }
    
    protected function is_action_allow($action, $throw = false)
    {
        $action_allow = !isset($this->object_desc['no_' . $action]) ||
            !$this->object_desc['no_' . $action];
        
        if (!$action_allow && $throw)
            throw new AlarmException('Ошибка. Данная операция с таблицей "' . $this->object_desc['title'] . '" запрещена.');
        
        return $action_allow;
    }
    
    protected function get_translate_values($table_name, $field_name, $table_record)
    {
        $translate_values = Db::selectAll('
                select lang.lang_id, translate.record_value
                from translate left join lang on lang.lang_id = translate.record_lang
                where table_name = :table_name and field_name = :field_name and table_record = :table_record
                order by lang.lang_default desc',
            array('table_name' => $table_name, 'field_name' => $field_name, 'table_record' => $table_record));
        
        $field_value = array();
        foreach ($translate_values as $translate_value)
            $field_value[$translate_value['lang_id']] = $translate_value['record_value'];
        
        return $field_value;
    }
    
    protected function change_translate_record($table_name, $table_record, $translate_values)
    {
        foreach ($translate_values as $field_name => $field_values)
        {
            $translate_record = array('table_name' => $table_name, 'field_name' => $field_name, 'table_record' => $table_record);
            
            Db::delete('translate', $translate_record);
            
            foreach ($field_values as $record_lang => $record_value)
            {
                $translate_record['record_lang'] = $record_lang;
                $translate_record['record_value'] = $record_value;
                
                Db::insert('translate', $translate_record);
            }
        }
    }
    
    protected function delete_translate_record($table_name, $table_record)
    {
        $translate_values = array();
        foreach (metadata::$objects[$table_name]['fields'] as $field_name => $field_desc)
            if (isset($field_desc['translate']) && $field_desc['translate'])
                $translate_values[$field_name] = array();
        
        $this->change_translate_record($table_name, $table_record, $translate_values);
    }
    
    // Построение дерева записей
    public function get_tree(&$records, $begin = 0, $except = array())
    {
        $this->except = $except;
        $this->records_by_parent = array();
        foreach ($records as $record) {
            $this->records_by_parent[$record[$this->parent_field]][] = $record;
        }
        
        $this->records_as_tree = array();
        $this->build_tree($begin);
        
        return $this->records_as_tree;
    }

    // Рекурсивный метод постройки уровня дерева
    private function build_tree($parent_field_id, $depth = 0)
    {
        if (isset($this->records_by_parent[$parent_field_id])) {
            foreach ($this->records_by_parent[$parent_field_id] as $record) {
                if (!in_array($record[$this->primary_field], $this->except)) {
                    $record['_depth'] = $depth;
                    $record['_has_children'] = isset($this->records_by_parent[$record[$this->primary_field]]);
                    if ($record['_has_children'])
                        $record['_children_count'] = count($this->records_by_parent[$record[$this->primary_field]]);
                    
                    $this->records_as_tree[] = $record;
                    $this->build_tree($record[$this->primary_field], $depth + 1);
                }
            }
        }
    }    
}
