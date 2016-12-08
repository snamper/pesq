<?php
namespace app\mobile\controller;

class Index extends Common
{
    public function index()
    {
        $this->appList();
        return $this->fetch();
    }
    public function appList(){
        $article = cache('index_carticle_cache');
        if (!$article) {
            $article = db('article')
                ->alias('a')
                ->join('__USER__ u', 'a.uid = u.uid', 'LEFT')
                ->join('__USER_AVATAR__ ua', 'a.uid = ua.uid', 'LEFT')
                ->field('a.id,a.openid,a.uid,u.username,u.openid uopenid,ua.avatar,a.subject,a.thumb,a.keywords,a.description,a.reply,a.views,a.dateline')
                ->where(['a.status' => 1])
                ->order('a.id', 'desc')
                ->cache(true, 3600)
                ->paginate(20);
            cache('index_carticle_cache', $article, 3600);
        }
        $this->assign('list',$article);
    }
}
