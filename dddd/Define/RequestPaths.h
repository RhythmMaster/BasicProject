//
//  RequestPaths.h
//  TzlBasicProject
//
//  Created by TangZhengLiang on 16/6/25.
//  Copyright © 2016年 TangZhengLiang. All rights reserved.
//

#ifndef RequestPaths_h
#define RequestPaths_h

//测试
#define kBasePath @"http://192.168.1.98:8686/wisdom_medical/"
#define kBaseDownPath @"http://192.168.1.98:8686/mss_file/"

//正式
//#define kBasePath @"http://114.215.203.199:8686/wisdom_medical/"
//#define kBaseDownPath @"http://114.215.203.199:8585/mss_file/"


//唐伟
//#define kBasePath @"http://192.168.1.139:8080/mss"
//盛成龙
//#define kBasePath @"http://192.168.1.22:8080/mss"





//账号
#define kRandomCode @"/app/common/randomCode"
#define kRegisterPath @"/app/medic/index/register"
#define kLoginPath @"/app/medic/index/login"
#define kForgetPath @"/app/medic/index/retrievePass"
#define kAboutUSPath @"/app/common/aboutUs"
#define kLogOutPath @"/app/common/loginOut"


//首页
#define kOrderMsgPath @"/app/medic/order/index"
#define kMyMsgPath @"/app/common/myMsg"

#define kOrderDetailPath @"/app/medic/order/waitorderView"




//个人中心
#define kPersonalCenterPath @"/app/medic/mycenter/index"
#define kSignPath @"/app/medic/mycenter/signIn"
#define KPersonalInfoPath @"/app/medic/mycenter/myinfo"
#define kPersonalInfoSavePath @"/app/medic/mycenter/myinfosave"

#define kMedicPostPath @"/app/medic/mycenter/medicPost"
#define kSelectMedicPostPath @"/app/medic/mycenter/selectMedicPost"

//意见反馈
#define kAdvicefeedbackPath @"/app/common/advicefeedback"

//评价列表
#define kMyevaluatePath @"/app/medic/mycenter/myevaluate"

//排班表
#define kServiceTimePath @"/app/medic/mycenter/medicServiceTime"
#define kServiceTimeViewPath @"/app/medic/mycenter/medicServiceTimeView"


//余额
#define kmyCashchangePath @"/app/common/mycashchange"




//Order
#define kMyAllOrderPath @"/app/medic/order/myallorder"
#define kMyOnOrderPath @"/app/medic/order/myonorder"
#define kMyOverOrderPath @"/app/medic/order/myoverorder"

//订单状态
//确认
#define kReceiveorderPath @"/app/medic/order/receiveorder"
//待拒绝订单页面
#define kWaitRefusePath @"/app/medic/order/waitrefuseorder"
//拒绝
#define kRefuseorderPath @"/app/medic/order/refuseorder"
//开始服务
#define kStartservicePath @"/app/medic/order/startservice"
//待取消订单
#define kWaitCancelPath @"/app/medic/order/waitcancelorder"
//取消订单
#define kCancelorderPath @"/app/medic/order/cancelorder"
//完成订单
#define kFinishorderPath @"/app/medic/order/finishorder"
//待评价
#define kToEvaluateOrderPath @"/app/medic/order/toEvaluateOrder"
//评价订单
#define kEvaluateOrderPath @"/app/medic/order/evaluateOrder"
//删除订单
#define kDeleteOrderPath @"/app/medic/order/deleteOrder"




//积分
#define kMyintegralPath @"/app/common/myintegral"
#define kMyintegraladdPath @"/app/common/myintegraladd"
#define kMyintegraloutPath @"/app/common/myintegralout"

//积分规则
#define kIntegrationRulePath @"/app/medic/mycenter/integrationRule"



//职称列表
#define kCertificatesViewPath @"/app/medic/mycenter/certificatesView"
//统一附件下载接口
#define kDownloadPath @"/app/mss_file/common/download"
//更换头像
#define kHeadChangePath @"/app/mss_file/medic/headChange"
//上传身份证【正面】图片
#define kIdcardFrontPath @"/app/mss_file/medic/idcardFront"
//上传身份证【反面】图片
#define kIdcardReversePath @"/app/mss_file/medic/idcardReverse"
//上传身份证【手持】图片
#define kIdcardPermitPath @"/app/mss_file/medic/ idcardPermit"
//上传职称证书图片
#define kCertificatePath @"/app/mss_file/medic/certificate"



#endif /* RequestPaths_h */
