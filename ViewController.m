//
//  ViewController.m
//  ImagesShow
//
//  Created by 博彦科技-聂小波 on 16/6/12.
//  Copyright © 2016年 bobo. All rights reserved.
//

#import "SelectImageView.h"
#import "ViewController.h"

@interface ViewController () <SelectPhotosDelegate>
@property(nonatomic, strong) SelectImageView *imageSelectView;
@property(nonatomic, strong) NSMutableArray *getFilePathArray;
@property(nonatomic, strong) UIButton *editEnableButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图片选择器";
    [self imageSelectViewInit];
    [self.view addSubview:self.editEnableButton];
}

- (void)imageSelectViewInit {
    self.imageSelectView.frame = CGRectMake(0, 150,Screen_width, 75);
    self.imageSelectView.hidden = NO;
    
    _filePathArray = @[
                       @"http://www.xiufa.com/BJUI/plugins/kindeditor_4.1.10/attached/image/"
                       @"20160427/20160427020344_22714.png",
                       @"http://www.xiufa.com/BJUI/plugins/kindeditor_4.1.10/attached/image/"
                       @"20160427/20160427020327_69298.png"
                       ];
    BOOL isLocalPics = NO;
    if (isLocalPics) {
        //_filePathArray存储的是本地图片
        if (_filePathArray.count > 0) {
            self.imageSelectView.imgFilePathArray = [_filePathArray mutableCopy];
            [self.imageSelectView resetImagesWithFilePath];
        }
    } else {
        //_filePathArray存储的是网络图片
        if (_filePathArray.count > 0) {
            [self.imageSelectView resetImagesWithNetUrlFilePathArray:_filePathArray];
        }
    }
}

- (UIButton *)editEnableButton {
    if (!_editEnableButton) {
        _editEnableButton =
        [[UIButton alloc] initWithFrame:CGRectMake(15, 80, 200, 40)];
        [_editEnableButton setTitle:@"点击选择：编辑模式" forState:UIControlStateSelected];
        [_editEnableButton setTitle:@"点击选择：预览模式" forState:UIControlStateNormal];
        [_editEnableButton setTitleColor:[UIColor blueColor]
                                forState:UIControlStateSelected];
        [_editEnableButton addTarget:self
                              action:@selector(editEnableButtonClick)
                    forControlEvents:UIControlEventTouchUpInside];
        [_editEnableButton setTitleColor:[UIColor redColor]
                                forState:UIControlStateNormal];
        [_editEnableButton setBackgroundColor:[UIColor yellowColor]];
        self.editEnableButton.selected = YES;
    }
    return _editEnableButton;
}

#pragma mark - 点击按钮
- (void)editEnableButtonClick {
    self.editEnableButton.selected = !self.editEnableButton.selected;
    [self.imageSelectView resetEditState:self.editEnableButton.selected];
}

#pragma mark - imageSelectView
- (SelectImageView *)imageSelectView {
    if (!_imageSelectView) {
        _imageSelectView = [[SelectImageView alloc] init];
        //第一步 注意：delegate 类型必须是UIViewController
        _imageSelectView.delegate = self;
        //第二步 初始化并设置最大图片数4
        [_imageSelectView imageViewInitMaxImages2:30 imgWidth:63.0];
        [self.view addSubview:_imageSelectView];
    }
    return _imageSelectView;
}

#pragma mark - SelectPhotos Delegate  返回选择的图片地址数组
- (void)imgfilePathArray:(NSMutableArray *)filePathArray
                 heights:(float)heights {
    //更新高度
    CGRect imgViewFrame = self.imageSelectView.frame;
    imgViewFrame.size.height = heights;
    self.imageSelectView.frame = imgViewFrame;
    
    //返回选择的图片地址数组
    self.getFilePathArray = [filePathArray mutableCopy];
    
    //发送请求
}



@end
