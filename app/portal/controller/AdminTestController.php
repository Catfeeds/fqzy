<?php
/*
 * 测试用
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/29 9:48
 */
namespace app\portal\controller;

use cmf\controller\AdminBaseController;
use think\captcha\Captcha;

class AdminTestController extends AdminBaseController
{
    public function _initialize()
    {
        require VENDOR_PATH.'/phpoffice/phpexcel/Classes/PHPExcel.php';
    }

    public function index()
    {
        $objPHPExcel = new \PHPExcel();
        $objPHPExcel->setActiveSheetIndex(0);
        $objPHPExcel->getActiveSheet()
            ->setCellValue("A1", '门店名称')
            ->setCellValue("B1", '店长')
            ->setCellValue("A2", '我的门店')
            ->setCellValue("B2", 'www');

        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="store2.xls"');
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        $objWriter->save('php://output');
        $objPHPExcel->disconnectWorksheets();
    }

    public function indexPost()
    {

        $file = $this->request->file('data');
        $info = $file->move(ROOT_PATH . 'public' . DS . 'upload' . DS . 'excel');
        $saveName = 'excel/'.$info->getSaveName();
        $fileName = $info->getPathname();
        $extension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));//判断导入表格后缀格式
        if ($extension == 'xlsx') {
            $objReader = \PHPExcel_IOFactory::createReader('Excel2007');
            $objPHPExcel = $objReader->load($fileName, $encode = 'utf-8');
        } else if ($extension == 'xls'){
            $objReader = \PHPExcel_IOFactory::createReader('Excel5');
            $objPHPExcel = $objReader->load($fileName, $encode = 'utf-8');
        }
        $sheet = $objPHPExcel->getSheet(0);
        $highestRow = $sheet->getHighestRow();//取得总行数
        $highestColumn =$sheet->getHighestColumn(); //取得总列数
        echo "<pre/>";
        print_r($highestRow);
        print_r($highestColumn);
        die;
    }

}
