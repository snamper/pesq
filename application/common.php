<?php
// 应用公共文件
/**
 * spm参数
 * @return string
 */
function spm(){
    $requst =mb_substr( str_replace('.html','',str_replace('/','.',request()->baseUrl())),1);
    $timestmap = time();
    $random = rand(1000,9999);
    return strtolower($requst.'.'.$random.'.'.$timestmap);
}

/**
 * 版本号缓存
 * @return string
 */
function vcs($model=false){
    $vcs = cache('vcs');
    if(!$vcs){
        $vcs = mb_substr(sha1(spm()),0,12);
        cache('vcs',$vcs,600);
    }
    if($model){
        return $vcs;
    }
    return '?v='.$vcs;
}
/**
 * 面包屑导航定位
 * @param $arr /数组
 * @param $id /当前id
 * @return array
 */
function breadcrumb($arr, $id)
{
    static $list = array();
    foreach ($arr as $v) {
        if ($v['id'] == $id) {
            breadcrumb($arr, $v['pid']);
            $list[] = $v;
        }
    }
    return $list;
}

/**
 * 获取子分类id
 * @param $data
 * @param $id
 * @return array
 */
function getChildId($data, $id)
{
    static $result = [];
    $result[] = $id;
    foreach ($data as $item => $value) {
        if ($value['pid'] == $id) {
            getChildId($data, $value['id']);
            $result[] = $value['id'];
        }
    }
    return $result;
}
/**
 * 无限极分类
 * @param $category
 * @param int $pid
 * @return array
 */
function unlimitedForChild($category, $pid = 0)
{
    $arr = array();
    foreach ($category as $v) {
        if ($v['pid'] == $pid) {
            $v['child'] = unlimitedForChild($category, $v['id']);
            $arr[] = $v;
        }
    }
    return $arr;
}
/**
 * 无限极分类
 * @param $list
 * @param int $pid
 * @param int $level
 * @return array
 */
function unlimitedForLevel($list, $pid = 0, $level = 0)
{
    $arr = array();
    foreach ($list as $k => $v) {
        if ($v['pid'] == $pid) {
            $v['level'] = $level + 1;
            $arr[] = $v;
            $arr = array_merge($arr, unlimitedForLevel($list, $v['id'], $level + 1));
        }
    }
    return $arr;
}
/**
 * 清除缓存数据
 * @param string $cacheName 缓存名称
 */
function cacheNull($cacheName){
    cache($cacheName,null);
}

function guid(){
    if (function_exists('com_create_guid')){
        return com_create_guid();
    }else{
        mt_srand((double)microtime()*10000);//optional for php 4.2.0 and up.
        $charid = strtoupper(md5(uniqid(rand(), true)));
        $uuid = substr($charid, 0, 8) .substr($charid, 8, 4) .substr($charid,12, 4) .substr($charid,16, 4) .substr($charid,20,12);
        return strtolower( $uuid );
    }
}

function mbs($string,$length='40'){
    return mb_substr($string,0,$length,'UTF-8');
}
/**
 * php版本
 * @return string
 */
function phpv()
{
    return 'php' . phpversion();
}

/**
 * 检测mysql版本
 * @return mixed
 */
function sqlv()
{
    $system_info_mysql = \think\Db::query("select version() as v;");
    return $system_info_mysql['0']['v'];
}

function editorJS(){
    $script = '<script src="/static/editor/js/wangEditor.min.js?'.vcs().'"></script>';
    $script .= '<script src="/static/editor/js/wangEditor.config.js'.vcs().'"></script>';
    return $script;
}
function editorCSS(){
    return '<link rel="stylesheet" href="/static/editor/css/wangEditor.min.css?spm='.vcs().'">';
}
function editorTextarea($name,$height='300'){
    return '<textarea name="'.$name.'" id="'.$name.'" style="height:'.$height.'px;max-height:600px;"></textarea>
    <script> var editorTarget="'.$name.'";</script>';
}
function puploader($many=true){
    $script = '<script src="/static/pupload/plupload.full.min.js"></script>';
    if($many){
        $script .= '<script src="/static/pupload/inc.many.js"></script>';
    }else{
        $script .= '<script src="/static/pupload/inc.one.js"></script>';
    }
    return $script;
}
function puploader_template($height="60"){
    return '<link rel="stylesheet" href="/static/pupload/style.css?spm='.vcs().'">'.
    '<div class="am-widget-pupload" id="am-widget-pupload" style="height:'.$height.'px">
        <a id="pickfiles" class="am-pickfiles am-icon-plus" href="javascript:;" style="line-height:'.$height.'px"> 选择图片</a>
    </div>';
}

function reurl(&$param,$model,$spm=false){
    if($spm)
        $path = '?spm=' . spm();
    else
        $path ='';
    return 'http://' . request()->host() . '/' . $model . '/' . $param . '.html' . $path;
}

function uid($tpye = 'mp')
{
    $user = session($tpye);
    if ($user) {
        return $user['uid'];
    }
    return null;
}

function weixin_menus($data, $pid = 0)
{
    $arr = array();
    foreach ($data as $v) {
        if ($v['pid'] == $pid) {
            $v['sub_button'] = weixin_menus($data, $v['id']);
            $arr[] = $v;
        }
    }
    return $arr;
}

function default_img($var=''){
    if ($var && is_file($var)) {
        return str_replace('./','/',$var);
    }else{
        return '/static/i/default_thumb.jpg';
    }
}

function get_friendly_time($time)
{
    $now = time();
    $timec = $now - intval($time);
    //
    if ($timec > 86400) {
        $days = intval($timec / (24 * 60 * 60));
        if ($days == 1) {
            return '昨天' . date('H:i', $time);
        } else if ($days < 30) {
            return $days . '天前' . date('H:i', $time);
        } else if ($days < 365) {
            $moths = intval($days / 30);
            return $moths . '个月前';
        } else {
            $years = intval($days / 365);
            return $years . '年前';
        };
    } else if ($timec > 3600) {
        $hours = intval($timec / (60 * 60));
        return $hours . '小时前';
    } else if ($timec > 60) {
        $mins = intval($timec / 60);
        return $mins . '分钟前';
    } else if ($timec > 5) {
        return $timec . "秒前";
    } else {
        return '刚刚';
    }
}

function tags($str = '')
{
    if (empty($str)) {
        return null;
    }
    $str = explode(',', $str);
    $html = '';
    foreach ($str as $v) {
        $tag = base64_encode($v);
        $html .= '<a href="' . reurl($tag, 'tags') . '" class="am-badge"> ' . $v . '</a>';
    }
    return $html;
}

function removeImgDot($str)
{
    return 'http://' . request()->host() . mb_substr($str, 1);
}

/**
 * 订单编号
 * @return string
 */
function orderNo(){
    return 'E'. date('YmdHis') . substr(time(),4);
}

function exploThumbFirst($str){
    $row = explode(',',$str);
    return $row['0'];
}

/**
 * 规格数组组合递归
 * @param $arr
 */
function specArray($arr){
    $items=[];
    foreach ($arr as $item=>$value){
        $items[] = $value['item'];
    }
    $items = array_unique($items);
    $result = [];
    foreach ($arr as $item=>$value){
        foreach ($items as $v){
            if($v == $value['item']){
                $result[$v][] = $value;
            }
        }
    }
    return $result;
}
function goodsUrl($openid){
    return 'http://' . request()->host() . '/goods/'.$openid.'.html';
}