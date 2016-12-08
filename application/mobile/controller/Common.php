<?php
namespace app\mobile\controller;

use think\Controller;
use app\common\model\Api;

class Common extends Controller
{
    public function _initialize()
    {
        $this->assign('config', Api::config());
        $this->assign('navigation', unlimitedForChild(Api::navigation()));
    }
}
