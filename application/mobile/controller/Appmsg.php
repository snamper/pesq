<?php
namespace app\mobile\controller;
use app\common\model\Api;
use app\common\model\Channel;
class Appmsg extends Common
{
    public function index()
    {
        $openid = input('param.openid');
        Api::openidValidator($openid);

        //查询文章
        $article = db('article')->where(['openid' => $openid, 'status' => 1])->cache(true, 3600)->find();
        if (!$article) {
            abort('404', '访问内容不存在，已经删除或是被禁用');
        }
        //文章详情
        $author = db('user')->where('uid', $article['uid'])->cache(true, 3600)->find();
        $author['avatar'] = db('user_avatar')->where('uid', $author['uid'])->cache(true, 3600)->column('avatar');
        $this->assign('author', $author);
        $this->assign('article', $article);

        $channel = self::chnanel($article['catid']);
        $this->assign('channel', $channel);

        return $this->fetch();
    }
    private static function chnanel($id)
    {
        $channel = Channel::search_channel('id', $id);
        return $channel;
    }

    /**
     * 文章浏览数+1 延迟更新60s
     * @param $id
     */
    private static function views_plus($id)
    {
        db('article')->where('id', $id)->setInc('views', 1, 60);
    }

    /**
     * 获取文章评论
     * @return mixed
     */
    public function reples()
    {
        $aid = input('get.aid');
        $order = input('get.order');
        if (isset($order)) {
            $order = 'r' . $order . 'desc';
        } else {
            $order = 'r.id desc';
        }
        $datalist = db('reples')
            ->alias('r')
            ->join('__USER__ u', 'r.uid = u.uid', 'LEFT')
            ->join('__USER_AVATAR__ ua', 'r.uid = ua.uid', 'LEFT')
            ->where(['r.status' => 1, 'r.aid' => $aid])->order($order)->cache(true, 60)->paginate(12);
        $this->assign('reples', $datalist);
        return $this->fetch();
    }
}
