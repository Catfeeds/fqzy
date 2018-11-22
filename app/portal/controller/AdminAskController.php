<?php
/*
 * 题目相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/5 13:37
 */
namespace app\portal\controller;

use app\portal\model\AskAnalysisModel;
use app\portal\model\AskOptionModel;
use app\portal\model\PortalCategoryModel;
use cmf\controller\AdminBaseController;
use app\portal\model\AskModel;
use think\Db;

class AdminAskController extends AdminBaseController
{
    public function index(){
        $cate_id = $this->request->param('cate_id', '', 'intval');
        $keyword = $this->request->param('keyword', '');
        $portalCategoryModel = new PortalCategoryModel();
        $ask = new AskModel();
        $where = [];
        if(!empty($cate_id)){
            $if_topcate = $portalCategoryModel->where('id',$cate_id)->value('parent_id');
            if(empty($if_topcate)){
                $arr_cate_id = $portalCategoryModel->where('parent_id',$cate_id)->column('id');
                $where['a.cate_id'] = ['in',$arr_cate_id];
            }else{
                $where['a.cate_id'] = $cate_id;
            }
        }
        if(!empty($keyword)){
            $where['a.title_text'] = ['like',"%$keyword%"];
        }
        $list = $ask
            ->field('a.*,c.name')
            ->alias('a')
            ->join('__PORTAL_CATEGORY__ c','a.cate_id = c.id')
            ->where($where)
            ->order('a.sort ASC')
            ->paginate(50);
        $page = $list->render();
        $categoryTree        = $portalCategoryModel->adminCategoryTree($cate_id);

        $this->assign('page',$page);
        $this->assign('list',$list);
        $this->assign('categoryTree',$categoryTree);
        $this->assign('keyword',empty($keyword)?'':$keyword);
        return $this->fetch();
    }


    //添加文字题目
    public function addtext()
    {
        return $this->fetch();
    }

    //添加图片题目
    public function addpic()
    {
        return $this->fetch();
    }

    //添加题目(文字和图片两种)(批量添加，测试使用)
    public function addPost_test()
    {
        $post = $this->request->param();
        for ($i=0;$i<100;$i++){
            if(empty($post['cate_id'])){
                $this->error('请选择分类！');
            }
            if(empty($post['option_content'][$post['right_option']])){
                $this->error('正确答案不科学！！');
            }
            Db::startTrans();
            $ask = new AskModel();
            $option = new AskOptionModel();
            $analysis = new AskAnalysisModel();
            $res_ask = $ask->insertGetId([
                'cate_id' => $post['cate_id'],
                'sort' => $i + 1,
                'title_text' => '这是签派题库1的纯文字题目？'.($i+1),
                'title_pic' => isset($post['title_pic'])?json_encode($post['title_pic']):'',
                'option_id' => 0,
                'option_type' => $post['option_type'],
                'create_time' => date('Y-m-d H:i:s')
            ]);
            $error_data = false;
            foreach ($post['option_content'] as $k=>$v){
                if(empty($v)){
                    break;
                }
                $res_option = $option->insertGetId([
                    'ask_id' => $res_ask,
                    'option_content' => $v
                ]);
                if(!$res_option){
                    $error_data = true;
                    break;
                }
                if($post['right_option'] == $k){
                    $res_ask_update = $ask->where('id',$res_ask)->setField('option_id',$res_option);
                    if(!$res_ask_update){
                        $error_data = true;
                        break;
                    }
                }
            }
            $res_analysis = $analysis->insert([
                'ask_id' => $res_ask,
                'analysis_content' => $post['analysis_content']
            ]);
            if(!$res_ask or $error_data or !$res_analysis){
                Db::rollback();
            }
            Db::commit();
        }
    }

    //添加题目(文字和图片两种)
    public function addPost()
    {
        $post = $this->request->param();
        if(empty($post['cate_id'])){
            $this->error('请选择分类！');
        }
        if(empty($post['option_content'][$post['right_option']])){
            $this->error('正确答案不科学！！');
        }
        Db::startTrans();
        $ask = new AskModel();
        $option = new AskOptionModel();
        $analysis = new AskAnalysisModel();
        $res_ask = $ask->insertGetId([
            'cate_id' => $post['cate_id'],
            'sort' => $post['sort'],
            'title_text' => $post['title_text'],
            'title_pic' => isset($post['title_pic'])?json_encode($post['title_pic']):'',
            'option_id' => 0,
            'option_type' => $post['option_type'],
            'create_time' => date('Y-m-d H:i:s')
        ]);
        $error_data = false;
        foreach ($post['option_content'] as $k=>$v){
            if(empty($v)){
                break;
            }
            $res_option = $option->insertGetId([
                'ask_id' => $res_ask,
                'option_content' => $v
            ]);
            if(!$res_option){
                $error_data = true;
                break;
            }
            if($post['right_option'] == $k){
                $res_ask_update = $ask->where('id',$res_ask)->setField('option_id',$res_option);
                if(!$res_ask_update){
                    $error_data = true;
                    break;
                }
            }
        }
        $res_analysis = $analysis->insert([
            'ask_id' => $res_ask,
            'analysis_content' => $post['analysis_content']
        ]);
        if(!$res_ask or $error_data or !$res_analysis){
            Db::rollback();
            $this->error('添加失败!');
        }
        Db::commit();
        $this->success('添加成功!');
    }

    //删除
    public function delete()
    {
        $id = $this->request->param('id','','intval');//ask表id
        Db::startTrans();
        $ask = new AskModel();
        $option = new AskOptionModel();
        $analysis = new AskAnalysisModel();
        $res_ask = $ask->where('id',$id)->delete();
        $res_option = $option->where('ask_id',$id)->delete();
        $res_analysis = $analysis->where('ask_id',$id)->delete();
        if(!$res_ask or !$res_option or !$res_analysis){
            Db::rollback();
            $this->error('删除失败!');
        }
        Db::commit();
        $this->success('删除成功!');
    }

    //编辑
    public function edit()
    {
        $id = $this->request->param('id','','intval');
        $ask = new AskModel();
        $option = new AskOptionModel();
        $info = $ask
            ->field('a.*,a.id as aid,c.name,aa.*')
            ->alias('a')
            ->join('__PORTAL_CATEGORY__ c','a.cate_id = c.id')
            ->join('__ASK_ANALYSIS__ aa','aa.ask_id = a.id')
            ->where('a.id',$id)
            ->find()
            ->toArray();
        $info['option'] = $option->where('ask_id',$id)->order('id ASC')->select()->toArray();
        $info['title_pic'] = json_decode($info['title_pic']);
        $this->assign('info',$info);
        if($info['option_type'] == 0){
            //文字
            return $this->fetch('edittext');
        }else{
//            echo "<pre/>";
//            print_r($info);
//            die;
            //图片
            return $this->fetch('editpic');
        }
    }

    //编辑
    public function editPost()
    {
        $post = $this->request->param();
        if(empty($post['option_content'][$post['right_option']])){
            $this->error('正确答案不科学！！');
        }
        Db::startTrans();
        $ask = new AskModel();
        $option = new AskOptionModel();
        $analysis = new AskAnalysisModel();
        $res_ask = $ask->update([
            'id' => $post['id'],
            'cate_id' => $post['cate_id'],
            'sort' => $post['sort'],
            'title_text' => $post['title_text'],
            'title_pic' => isset($post['title_pic'])?json_encode($post['title_pic']):'',
            'option_id' => 0,
            'option_type' => $post['option_type'],
            'create_time' => date('Y-m-d H:i:s')
        ]);
        $res_option_del = $option->where('ask_id',$post['id'])->delete();
        $error_data = false;
        foreach ($post['option_content'] as $k=>$v){
            if(empty($v)){
                break;
            }
            $res_option = $option->insertGetId([
                'ask_id' => $post['id'],
                'option_content' => $v
            ]);
            if(!$res_option){
                $error_data = true;
                break;
            }
            if($post['right_option'] == $k){
                $res_ask_update = $ask->where('id',$post['id'])->setField('option_id',$res_option);
                if(!$res_ask_update){
                    $error_data = true;
                    break;
                }
            }
        }
        $res_analysis = $analysis
            ->where('ask_id',$post['id'])
            ->data([
                'analysis_content'=>$post['analysis_content'],
                'update_time' => date('Y-m-d H:i:s')
            ])
            ->update();
        if(!$res_ask or $error_data or !$res_analysis or !$res_option_del){
            Db::rollback();
            $this->error('修改失败!');
        }
        Db::commit();
        $this->success('更新成功!');
    }

    /**
     * 导入题目
     */
    public function input()
    {
        return $this->fetch();
    }

    /**
     * 导入题目操作
     */
    public function inputPost()
    {
        $file = $this->request->file('filedata');
        $cate_id = $this->request->param('cate_id','','intval');
        $ask = new AskModel();
        $option = new AskOptionModel();
        $analysis = new AskAnalysisModel();
        if(empty($cate_id)){
            $this->error('请选择题库');
        }
        if(empty($file)){
            $this->error('请选择文件');
        }
        $info = $file->move(ROOT_PATH . 'public' . DS . 'upload');
        $fileName = $info->getPathname();
        $data = $this->importExecl($fileName);
        unset($data[1]);
        foreach ($data as $k=>$v){
            Db::startTrans();
            $sort = trim($data[$k]['A']);
            $title_text = trim($data[$k]['B']);
            $abcd = trim($data[$k]['C']);
            $option_content1 = trim($data[$k]['D']);
            $option_content2 = trim($data[$k]['E']);
            $option_content3 = trim($data[$k]['F']);
            $option_content4 = trim($data[$k]['G']);
            $res_ask = $ask->insertGetId([
                'cate_id' => $cate_id,
                'sort' => $sort,
                'title_text' => $title_text,
                'title_pic' => '',
                'option_id' => 0,
                'option_type' => 0, //代表选项是文字
                'create_time' => date('Y-m-d H:i:s')
            ]);
            $res_analysis = $analysis->insert([
                'ask_id' => $res_ask,
                'analysis_content' => '默认题目解析'
            ]);
            $a =  $option->insertGetId([
                'ask_id' => $res_ask,
                'option_content' => $option_content1
            ]);
            $b =  $option->insertGetId([
                'ask_id' => $res_ask,
                'option_content' => $option_content2
            ]);
            $c =  $option->insertGetId([
                'ask_id' => $res_ask,
                'option_content' => $option_content3
            ]);
            if(!empty($option_content4)){
                $d =  $option->insertGetId([
                    'ask_id' => $res_ask,
                    'option_content' => $option_content4
                ]);
            }
            if($abcd == 'A'){
                $res_ask_update = $ask->where('id',$res_ask)->setField('option_id',$a);
            }elseif ($abcd == 'B'){
                $res_ask_update = $ask->where('id',$res_ask)->setField('option_id',$b);
            }elseif ($abcd == 'C'){
                $res_ask_update = $ask->where('id',$res_ask)->setField('option_id',$c);
            }elseif ($abcd == 'D'){
                if(!empty($option_content4)){
                    $res_ask_update = $ask->where('id',$res_ask)->setField('option_id',$d);
                }else{
                    $res_ask_update = false;
                }
            }else{
                $res_ask_update = false;
            }
            if(!$res_ask or !$a or !$b or !$c or !$res_ask_update or !$res_analysis){
                Db::rollback();
            }else{
                Db::commit();
            }
        }
        $this->success('导入成功');
    }


    /**
     *  数据导入
     * @param string $file excel文件
     * @param string $sheet
     * @return string   返回解析数据
     * @throws PHPExcel_Exception
     * @throws PHPExcel_Reader_Exception
     */
    function importExecl($file='', $sheet=0){
        $file = iconv("utf-8", "gb2312", $file);   //转码
        if(empty($file) OR !file_exists($file)) {
            die('file not exists!');
        }
        $objRead = new \PHPExcel_Reader_Excel2007();   //建立reader对象
        if(!$objRead->canRead($file)){
            $objRead = new \PHPExcel_Reader_Excel5();
            if(!$objRead->canRead($file)){
                die('No Excel!');
            }
        }

        $cellName = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AL', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');

        $obj = $objRead->load($file);  //建立excel对象
        $currSheet = $obj->getSheet($sheet);   //获取指定的sheet表
        $columnH = $currSheet->getHighestColumn();   //取得最大的列号
        $columnCnt = array_search($columnH, $cellName);
        $rowCnt = $currSheet->getHighestRow();   //获取总行数

        $data = array();
        for($_row=1; $_row<=$rowCnt; $_row++){  //读取内容
            for($_column=0; $_column<=$columnCnt; $_column++){
                $cellId = $cellName[$_column].$_row;
                $cellValue = $currSheet->getCell($cellId)->getValue();
                //$cellValue = $currSheet->getCell($cellId)->getCalculatedValue();  #获取公式计算的值
                if($cellValue instanceof PHPExcel_RichText){   //富文本转换字符串
                    $cellValue = $cellValue->__toString();
                }

                $data[$_row][$cellName[$_column]] = $cellValue;
            }
        }

        return $data;
    }


}
