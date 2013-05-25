<?php
/**
 * Шаблонизатор
 */
class view
{
    public $template_dir = VIEW_DIR;
    
    /**
     * Передача переменной в шаблон
     *
     * @param  $name mix
     * @param  $data mix
     */
    public function assign($name, $data = null)
    {
        if (is_array($name))
            foreach ($name as $key => $val)
                $this->$key = $val;
        else if ($name)
            $this->$name = $data;
    }
    
    /**
     * Получение контента
     *
     * @param  $template string
     * @return string
     */
    public function fetch($template)
    {
        $template_file = $this->template_dir . '/' . $template . '.phtml';
        
        if (!file_exists($template_file))
            throw new Exception('Файл "' . normalize_path($template_file) . '" не найден', true);
        
        $old_error_level = error_reporting();
        error_reporting(error_reporting() & ~(E_NOTICE|E_WARNING));
        
        ob_start();
        
        include($this->template_dir . '/' . $template . '.phtml');
        
        $result = ob_get_contents();
        
        ob_end_clean();
        
        error_reporting($old_error_level);
        
        return $result;
    }
    
    /**
     * Печать контента
     *
     * @param  $template string
     */
    public function display($template)
    {
        print $this->fetch($template);
    }
    
    /**
     * Проверка присутствия данных в запросе
     *
     * Примеры вызова:
     *      $this -> in_request('var', 1);
     *      $this -> in_request('var[step]', 2);
     *      $this -> in_request('var[step][point]');
     *
     * @param  $name string
     * @param  $data string
     * @return bool
     */
    public function in_request($name, $data = null)
    {
        $isset = !is_null($value = $this -> from_request($name));
        
        return (is_null($data) || !$isset) ? $isset : ($value == $data);
    }
    
    /**
     * Извлечение данных из запроса
     *
     * Примеры вызова:
     *      $this -> from_request('var');
     *      $this -> from_request('var[step]');
     *      $this -> from_request('var[step][point]');
     *
     * @param  $name string
     * @param  $data string
     * @return bool
     */
    public function from_request($name, $data = null)
    {
        $path = array();
        if (preg_match('/^(.+)\[(.+)\]$/U', $name, $match)) {
            $name = $match[1]; $path = explode('][', $match[2]);
        }
        
        if ($isset = isset($_REQUEST[$name])) {
            $value = $_REQUEST[$name]; 
            foreach ($path as $piece) { 
                if (isset($value[$piece])) {
                    $value = $value[$piece];
                } else {
                    $isset = false; break;
                }
            }
        }
        
        return $isset ? $value : $data;
    }
}