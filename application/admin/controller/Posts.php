<?php
namespace app\admin\controller;

use app\common\model\Channel;

class Posts extends Common
{
    public function index()
    {
        $this->assign('channel', self::category());
        return $this->fetch();
    }

    /**
     * 发布文章
     * @return mixed
     */
    public function article(){
        $data =input('post.');
        $mp = mp();
        if(empty($data['subject'])  || empty($data['catid']) || empty($data['message'])){
            $this->result('403',403,'标题，内容，栏目不能为空');
        }
        if(isset($data['thumb']) && !empty($data['thumb'])){
            $data['thumb']  = $this->get_thumb($data['thumb']);
        }else{
            $data['thumb'] = self::get_first_img_thumb($data['message']);
        }
        $data['dateline'] = !empty($data['dateline']) ? strtotime($data['dateline'] . ' 00:00:00') : time();
        $data['openid'] = guid();
        $data['uid'] = $mp['uid'];
        $data['keywords'] = self::get_keywords($data['subject'],$data['message']);
        $data['description'] = self::get_description($data['message'],$data['subject']);
        $data['message'] = htmlentities($data['message']);
        $status = db('article')->insert($data);
        if($status){
            $this->result('ok',200,'文章发布成功，正在刷新页面，请稍等...');
        }else{
            $this->result('insert is error',500,'文章发布失败，请尝试刷新页面或是缓存，或者联系管理员');
        }
    }

    public static function category($type='article'){
        $data = Channel::datalist();
        $channel = [];
        foreach ($data as $item=>$value){
            if($value['document'] == $type){
                $channel[] = $value;
            }
        }
        return unlimitedForLevel($channel);
    }
    public static function get_thumb($file, $w = '900', $h = '500', $destroy = false)
    {
        $image = \think\Image::open('.'.$file);
        $save = './attach/thumb/'.sha1('thumb_'.$file).'.jpg';
        $image->thumb($w, $h, 1)->save($save);
        return $save;
    }

    private static function get_first_img_thumb($message){
        $message = htmlspecialchars_decode($message);
        preg_match("/(src)=([\"|']?)([^ \"'>]+\.(gif|jpg|jpeg|bmp|png))\\2/i",$message,$match);
        if(!$match) return null; //如果没有找到图片信息，返回null字符串
        if( preg_match("/^(http:\/\/|https:\/\/).*$/",$match['3'])){
            return null;
        }
        $thumb = self::get_thumb($match['3']);
        return $thumb;
    }

    /**
     * discuz api获取内容关键字
     * @param string $subject
     * @param string $message
     * @param string $encode
     * @return array|bool
     */
    private static function get_keywords($subject='',$message='',$encode = 'utf-8')
    {
       return $subject;
    }

    /**
     * 获取主题描述
     * @param string $message
     * @param string $subject
     * @param int $num
     * @return string
     */
    private static function get_description($message = '',$subject = '',$num = 80)
    {
        $message = strip_tags(htmlspecialchars_decode($message));
        $str_message = array(" ","　","\t","\n","\r","&nbsp;");//出去空格和换行
        $nbsp_message = array("","","","","");//替换为出去空格
        $reg_message = str_replace($str_message,$nbsp_message,$message);//替换
        $description = mb_substr($reg_message,0,$num,'utf-8');
        if($description){
            return $description;
        }else{
            return $subject;
        }
    }
}