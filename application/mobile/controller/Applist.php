<?php
namespace app\mobile\controller;

use app\common\model\Api;
use app\common\model\Channel;
class Applist extends Common
{
    public function index()
    {
        $openid = input('openid', '', 'htmlspecialchars');
        Api::openidValidator($openid); //验证openid有效性

        //查询对应栏目信息
        $channel = Channel::search_channel('openid', $openid);
        $this->assign('channel', $channel);
        $action = $channel['document'];
        $datalist = $this->$action($channel['id']);
        $this->assign('list', $datalist);
        if ($action == 'article') {
            $action = 'index';
        }
        return $this->fetch($action);
    }

    private function article($id)
    {
        $article = db('article')->where(['status' => 1, 'catid' => $id])->paginate(20);
        return $article;
    }
}
