<?php
namespace app\user\controller;

class Index extends Common
{
    public function index()
    {
        return $this->fetch();
    }

    public function home()
    {
        return $this->fetch();
    }
}
