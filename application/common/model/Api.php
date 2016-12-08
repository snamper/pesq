<?php
namespace app\common\model;
use think\Model;
use app\common\model\Channel;
class Api extends Model{

    /**
     * 全局文件配置
     * @return array|false|mixed|\PDOStatement|string|Model
     */
    public static function config($id='1'){
        $config = cache('config_'.$id);
        if(!$config){
            $config = db('config')->find();
            cache('config_'.$id,$config,0);
        }
        return $config;
    }

    /**
     * 微信接口配置文件
     * @return array|false|mixed|\PDOStatement|string|Model
     */
    public static function weixin_config()
    {
        $api = cache('weixin_config');
        if (!$api) {
            $api = db('weixin_config')->find();
            cache('weixin_config');
        }
        return $api;
    }

    /**
     * 验证文章或是栏目openid
     * @param $openid
     */
    public static function openidValidator($openid)
    {
        $openidLenth = strlen($openid);
        $isNumber = is_numeric($openid);
        if ($openidLenth != 32 || $isNumber) {
            abort('404', '您访问的内容不存，删除或是已经禁用');
        }
    }

    /**
     * 文章导航缓存读取
     * @return false|mixed|\PDOStatement|string|\think\Collection
     */
    public static function navigation(){
        $navigation = cache('navigation');
        if(!$navigation){
            $navigation = db('navigation')->where('status',1)->order('order','desc')->select();
            cache('navigation',$navigation,0); //缓存导航数据接口，直接从缓存读取
        }
        return $navigation;
    }

    /**
     * 面包屑导航
     * @param $id
     * @return array
     */
    public static function breadcrumb($id)
    {
        $channel = Channel::datalist();
        $breadcrumb = breadcrumb($channel, $id);
        return $breadcrumb;
    }
}