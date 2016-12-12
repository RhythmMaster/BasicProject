//
//  HZDataVC.m
//  dddd
//
//  Created by NSX443 on 16/11/12.
//  Copyright © 2016年 com.tang. All rights reserved.
//

#import "HZDataVC.h"
#import "HZDataCell.h"
#import "HZIconCell.h"
#import "HZCertificateVC.h"
#import "HZIDCardVc.h"
#import "HZPersonalCenterNM.h"
#import "LXMKeyboardManager.h"

#import "HZPicNetManager.h"

@import AVFoundation;
@interface HZDataVC ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, HZGenderPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic) HZPersonalCenterModel *personModel;
@property(nonatomic) UITableView *tableView;


@property(nonatomic) NSString *personName;

@property(nonatomic) NSString *personSex;

@property(nonatomic) NSString *personBirthday;

@property(nonatomic) NSString *personAddress;

@property(nonatomic) NSString *personAddressInfo;

@property(nonatomic) NSString *personServiceArea;

@property(nonatomic) NSString *personMedicPostId;

@property(nonatomic) NSString *personGoodAtField;

@property(nonatomic) NSString *personMedicPostName;

@property(nonatomic) NSString *personIdCard;

@property(nonatomic) NSString *personAlipay;

@property(nonatomic) NSString *ID;

@property(nonatomic) NSString *pickChange;
@property(nonatomic) NSMutableArray *pickDic;
@property(nonatomic) NSInteger pickNumber;

@property(nonatomic) NSString *str1;
@property(nonatomic) NSString *str2;

@property(nonatomic) NSString *professionID;

@property (nonatomic, strong) LXMKeyboardManager *keyboardManager;
//用于保存cell内容,防止cell滑动出屏幕内容消失
@property(nonatomic) NSMutableDictionary *cellContentDic;




//管道
@property (nonatomic) AVCaptureSession *session;
//用于把摄像头的数据显示在屏幕上的 layer
@property (nonatomic) AVCaptureVideoPreviewLayer *layer;

@end

@implementation HZDataVC

- (instancetype)init {
    if (self = [super init]) {
        
        UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick:)];
        self.navigationItem.rightBarButtonItem = saveBtn;
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.keyboardManager) {
        self.keyboardManager = [[LXMKeyboardManager alloc] initWithScrollView:self.tableView];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    
    
    [HZPersonalCenterNM getPersonInfo11CompletionHandler:^(id model, NSError *error) {
        NSLog(@"%@", model);
        
    }];
    
    _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [HZPersonalCenterNM getPersonInfoCompletionHandler:^(HZPersonalCenterModel *model, NSError *error) {
            self.personModel = model;
            if (error) {
                NSLog(@"%@", error);
            } else {
                _ID = _personModel.ID;
                
                
                [self setPickDicWithIndex:0 value:_personModel.sex];
                [self setPickDicWithIndex:1 value:_personModel.birthday];
                [self setPickDicWithIndex:2 value:_personModel.address];
                if (_personModel.medicPostName) {
                    [self setPickDicWithIndex:3 value:_personModel.medicPostName];
                }
                

                [_tableView reloadData];
            }
            [_tableView.mj_header endRefreshing];
        }];
    }];
    
    [_tableView.mj_header beginRefreshing];
    
    
    
    
}

- (void)setPickDicWithIndex:(NSInteger)index value:(NSString *)value {
    NSDictionary *dict = [self.pickDic objectAtIndex:index];
    NSMutableDictionary *muDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [muDict setObject:value forKey:@"title"];
    [self.pickDic replaceObjectAtIndex:index withObject:muDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark method

- (void)toChose {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择" message:@"请选择图片方法" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *ablumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //调用系统相册
        UIImagePickerController *pickerController = [UIImagePickerController new];
        //设置选取的照片是否可编辑
        pickerController.allowsEditing = YES;
        //设置相册呈现样式
        pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;  // 照片分组样式
        //UIImagePickerControllerSourceTypePhotoLibrary,  直接全部呈现出系统相册
        //UIImagePickerControllerSourceTypeCamera,  调取摄像头
        
        //选择完成图片或者点击取消按钮都是通过代理来操作我们需要的逻辑过程
        pickerController.delegate = self;
        // 使用模态呈现相册
        [self.navigationController presentViewController:pickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *cameraPickerVC = [UIImagePickerController new];
        cameraPickerVC.delegate = self;
        cameraPickerVC.allowsEditing = YES;
        
        
        //是否支持相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            cameraPickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:cameraPickerVC animated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"该设备不支持相机" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:ablumAction];
    [alert addAction:cameraAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}


- (void)saveClick:(UIBarButtonItem *)sender {
    NSLog(@"点了保存");
    
    UITextField *field1 = (UITextField *)[self.view viewWithTag:505];
    _personAddressInfo = field1.text;
    
    UITextField *field2 = (UITextField *)[self.view viewWithTag:506];
    _personServiceArea = field2.text;
    
    UITextField *field3 = (UITextField *)[self.view viewWithTag:510];
    _personGoodAtField = field3.text;
    
    NSLog(@"%@, %@, %@, %@, %@, %@, %@, %@, %@, %@", _personName, _personSex, _personBirthday, _personAddress, _personAddressInfo, _personServiceArea, _professionID, _personGoodAtField, _personIdCard, _personAlipay);
    NSLog(@"%@", _personModel.medicPostId);
    if (!_professionID) {
        _professionID = _personModel.medicPostId;
    }
    
    NSLog(@"%@, %@", _ID, _personModel);
    
    if (_personName == nil) {
        [self.view showWarning:@"姓名不能为空"];
        return;
    }
    if (_personSex == nil) {
        [self.view showWarning:@"性别不能为空"];
        return;
    }
    if (_personBirthday == nil) {
        [self.view showWarning:@"出生年月不能为空"];
        return;
    }
    if (_personAddress == nil) {
        [self.view showWarning:@"地址不能为空"];
        return;
    }
    if (_personAddressInfo == nil) {
        [self.view showWarning:@"详细地址不能为空"];
        return;
    }
    if (_personServiceArea == nil) {
        _personServiceArea = @"未填";
    }
    if (_personMedicPostName == nil) {
        [self.view showWarning:@"职业不能为空"];
        return;
    }
    if (_personGoodAtField == nil) {
        [self.view showWarning:@"擅长不能为空"];
        return;
    }
    if (_personIdCard == nil) {
        [self.view showWarning:@"身份证号码不能为空"];
        return;
    }
    if (_personAlipay == nil) {
        [self.view showWarning:@"支付宝不能为空"];
        return;
    }
    [HZPersonalCenterNM SavePersonInfoWithName:_personName sex:_personSex birthday:_personBirthday address:_personAddress addressInfo:_personAddressInfo serviceArea:_personServiceArea medicPostId:_professionID goodAtField:_personGoodAtField idCard:_personIdCard alipay:_personAlipay CompletionHandler:^(id model, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            NSLog(@"%@", model);
            NSLog(@"%@", [model objectForKey:@"MSG"]);
            [self.view showWarning:[NSString stringWithFormat:@"保存%@", [model objectForKey:@"MSG"]]];
        }
    }];
}



//保存数据
- (void)textFiled:(UITextField*)field {
    
    [self.cellContentDic setObject:field.text forKey:[NSString stringWithFormat:@"%ld", field.tag]];
    
}


#pragma mark delete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 14;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HZIconCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.iconBtn.tag = 1231;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        
    if (indexPath.section == 1) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nameCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"姓名";
        
        
        [cell.rightTF addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventAllEditingEvents];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]]) {
            cell.rightTF.text = self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]];
        } else {
             cell.rightTF.text = _personModel.name;
        }
        
       
        _personName = cell.rightTF.text;
        return cell;
    } else if (indexPath.section == 2) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sexCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"性别";
        cell.rightTF.text = _personModel.sex;
        cell.rightTF.placeholder = @"请选择您的性别";
        cell.rightTF.enabled = NO;
        
        cell.rightTF.text = self.pickDic[0][@"title"];
        
        _personSex = cell.rightTF.text;
        return cell;
    } else if (indexPath.section == 3) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"birthCell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"出生年月";
        cell.rightTF.placeholder = @"请选择您的出生年月";
        cell.rightTF.enabled = NO;
    
        cell.rightTF.text = self.pickDic[1][@"title"];
    
        NSLog(@"11111%@", cell.rightTF.text);
        _personBirthday = cell.rightTF.text;
        NSLog(@"2222222%@", _personBirthday);
        return cell;
    } else if (indexPath.section == 4) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"地区";
        cell.rightTF.text = _personModel.address;
        cell.rightTF.placeholder = @"请选择您的地址";
        cell.rightTF.enabled = NO;
        
        cell.rightTF.text = self.pickDic[2][@"title"];
       
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _personAddress = cell.rightTF.text;
        return cell;
    } else if (indexPath.section == 5) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressInfoCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"详细地址";
        
        cell.rightTF.placeholder = @"请填写您的详细地址";
        [cell.rightTF addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventAllEditingEvents];
        if (self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]]) {
            cell.rightTF.text = self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]];
        } else {
           cell.rightTF.text = _personModel.addressInfo;
        }
        _personAddressInfo = cell.rightTF.text;
        NSLog(@"personAddressInfo:%@", _personAddressInfo);
        return cell;
    } else if (indexPath.section == 6) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"serviceAddressCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"服务地区";
       
        cell.rightTF.placeholder = @"请填写您的服务区域(非必选)";
        [cell.rightTF addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventAllEditingEvents];
        if (self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]]) {
            cell.rightTF.text = self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]];
        } else {
             cell.rightTF.text = _personModel.serviceArea;
        }
        _personServiceArea = cell.rightTF.text;
        return cell;
    } else if (indexPath.section == 7) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hospitalCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section;
        cell.nameLb.text = @"所属医院";
        //_sex = cell.nameLb.text;
        cell.rightTF.placeholder = @"请填写您所属的医院";
        [cell.rightTF addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventAllEditingEvents];
        if (self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]]) {
            cell.rightTF.text = self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]];
        } else {
            
        }
        return cell;
    } else if (indexPath.section == 8) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"depaCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"所属科室";
        //_sex = cell.nameLb.text;
        [cell.rightTF addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventAllEditingEvents];
        if (self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]]) {
            cell.rightTF.text = self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]];
        } else {
            
        }
        cell.rightTF.placeholder = @"请填写您所属的科室";
        return cell;
    } else if (indexPath.section == 9) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"medicCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"职称";
        cell.rightTF.placeholder = @"请填写您的职称";
       
        cell.rightTF.text = self.pickDic[3][@"title"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.rightTF.enabled = NO;
        //_medicPostId = cell.nameLb.text;
        _personMedicPostName = cell.rightTF.text;
        return cell;
    } else if (indexPath.section == 10) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"从业经验与擅长";
        
        cell.rightTF.placeholder = @"请填写您的从业经验与擅长";
        [cell.rightTF addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventAllEditingEvents];
        if (self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]]) {
            cell.rightTF.text = self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]];
        } else {
            cell.rightTF.text = _personModel.goodAtField;
        }
        _personGoodAtField = cell.rightTF.text;
        return cell;
    } else if (indexPath.section == 11) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zhengshuCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"证书";
        cell.rightTF.enabled = NO;
        cell.rightTF.placeholder = @"请上传证书";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.section == 12) {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IdCardCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"身份证";
        cell.rightTF.text = _personModel.idCard;
        cell.rightTF.enabled = NO;
        cell.rightTF.placeholder = @"请上传身份证照片";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _personIdCard = cell.rightTF.text;
        return cell;
    } else {
        HZDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alipayCell" forIndexPath:indexPath];
        cell.rightTF.delegate = self;
        cell.rightTF.tag = indexPath.section + 500;
        cell.nameLb.text = @"支付宝账户";
        
        cell.rightTF.placeholder = @"请添加您的支付宝账号";
        [cell.rightTF addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventAllEditingEvents];
        if (self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]]) {
            cell.rightTF.text = self.cellContentDic[[NSString stringWithFormat:@"%ld", cell.rightTF.tag]];
        } else {
            cell.rightTF.text = _personModel.alipay;
        }
        
        _personAlipay = cell.rightTF.text;
        return cell;
    }
    
    
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
//        [HZPicNetManager getCertificatesViewCompletionHandler:^(id model, NSError *error) {
//            NSLog(@"%@", model);
//        }];
        
        
        [self toChose];
        
        
        
    }
    
    if (indexPath.section == 2) {
        self.navigationController.navigationBarHidden = YES;
        HZGenderPickerView *genderPickerView = [[HZGenderPickerView alloc] initWithFrame:self.view.bounds];
        _pickNumber = 0;
        genderPickerView.arrayType = 0;
        genderPickerView.delegate = self;
        [self.view addSubview:genderPickerView];
        
    }
    if (indexPath.section == 3) {
        self.navigationController.navigationBarHidden = YES;
        HZGenderPickerView *genderPickerView = [[HZGenderPickerView alloc] initWithFrame:self.view.bounds];
        _pickNumber = 1;
        genderPickerView.arrayType = 1;
        genderPickerView.delegate = self;
        [self.view addSubview:genderPickerView];
    }
    if (indexPath.section == 4) {
        self.navigationController.navigationBarHidden = YES;
        HZGenderPickerView *genderPickerView = [[HZGenderPickerView alloc] initWithFrame:self.view.bounds];
        _pickNumber = 2;
        genderPickerView.arrayType = 2;
        genderPickerView.delegate = self;
        [self.view addSubview:genderPickerView];
    }
    if (indexPath.section == 9) {
        self.navigationController.navigationBarHidden = YES;
        HZGenderPickerView *genderPickerView = [[HZGenderPickerView alloc] initWithFrame:self.view.bounds];
        genderPickerView.delegate = self;
        _pickNumber = 3;
        genderPickerView.arrayType = 3;
        
    
        
        [self.view addSubview:genderPickerView];
        
        
    }
    
    if (indexPath.section == 11) {
        self.hidesBottomBarWhenPushed = YES;
        HZCertificateVC *certificateVC = [HZCertificateVC new];
        [self.navigationController pushViewController:certificateVC animated:YES];
        //self.hidesBottomBarWhenPushed = NO;
    }
    if (indexPath.section == 12) {
        self.hidesBottomBarWhenPushed = YES;
        HZIDCardVc *certificateVC = [HZIDCardVc new];
        [self.navigationController pushViewController:certificateVC animated:YES];
        //self.hidesBottomBarWhenPushed = NO;
    }
    
}


#pragma mark - UIImagePickerControllerDelegate
//选择完成图片之后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //info 是选择图片的信息
    
    // UIImagePickerControllerEditedImage//编辑过的图片
    // UIImagePickerControllerOriginalImage//原图
    
    NSLog(@"%@", info);
    
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //01.21 应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
    // 保存图片至本地，方法见下文
    [self saveImage:resultImage withName:@"currentImage.png"];
    //读取路径进行上传
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    UIButton *btn = (UIButton *)[self.view viewWithTag:1231];
    [btn setImage:[savedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    
    
    NSLog(@"%@", fullPath);
    
    //进到次方法时 调 UploadImage 方法上传服务端
    NSDictionary *dic = @{@"image":fullPath};
    [self UploadImage:dic];
    
    
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

//图频上传

-(void)UploadImage:(NSDictionary *)dic
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/plain", @"application/json", @"text/javascript", nil];
    NSString *path = [NSString stringWithFormat:@"%@%@", kBasePath, kHeadChangePath];
    NSDictionary *parameters = @{@"memberId": _personModel.ID};
    [manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //01.21 测试
        NSString * imgpath = [NSString stringWithFormat:@"%@",dic[@"image"]];
        UIImage *image = [UIImage imageWithContentsOfFile:imgpath];
        NSData *data = UIImageJPEGRepresentation(image,0.7);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        [formData appendPartWithFileData:data name:@"Filedata" fileName:fileName mimeType:@"image/jpg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //成功 后处理。
        NSLog(@"Success: %@", responseObject);
        NSString * str = [responseObject objectForKey:@"fileId"];
        if (str != nil) {
            //            [self.delegate uploadImgFinish:str];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //失败
        NSLog(@"Error: %@", error.localizedDescription);
        
    }];
    
    
    
}

#pragma mark - 保存图片至沙盒（应该是提交后再保存到沙盒,下次直接去沙盒取）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}


// 点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}





#pragma mark delete textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.keyboardManager scrollToIdealPositionWithTargetView:textField];
}


//键盘收回触发
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //回归原处
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

#pragma mark delete - HZGenderPickerView
- (void)PickerSelectIndexTitle:(NSString *)title ID:(NSString *)ID {
    NSDictionary *dict = [self.pickDic objectAtIndex:_pickNumber];
    NSMutableDictionary *muDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [muDict setObject:title forKey:@"title"];
    [self.pickDic replaceObjectAtIndex:_pickNumber withObject:muDict];
    _professionID = ID;
    NSLog(@"%@", _professionID);
    self.navigationController.navigationBarHidden = NO;
    [_tableView reloadSection:2 withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView reloadSection:3 withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView reloadSection:4 withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView reloadSection:9 withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark -懒加栽
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HZIconCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"nameCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"sexCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"birthCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"addressCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"addressInfoCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"serviceAddressCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"hospitalCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"depaCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"medicCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"goodCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"zhengshuCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"IdCardCell"];
        [_tableView registerClass:[HZDataCell class] forCellReuseIdentifier:@"alipayCell"];
    }
    return _tableView;
}


- (NSMutableArray *)pickDic {
    if (!_pickDic) {
        _pickDic = [NSMutableArray new];
        NSDictionary *genderDic = @{@"title": @""};
        NSDictionary *birthDic = @{@"title": @""};
        NSDictionary *addressDic = @{@"title": @""};
        NSDictionary *careerDic = @{@"title": @""};
        [_pickDic addObject:genderDic];
        [_pickDic addObject:birthDic];
        [_pickDic addObject:addressDic];
        [_pickDic addObject:careerDic];
    }
    return _pickDic;
}


- (NSMutableDictionary *)cellContentDic {
    if (!_cellContentDic) {
        _cellContentDic = [NSMutableDictionary dictionary];
    }
    return _cellContentDic;
}

















@end
