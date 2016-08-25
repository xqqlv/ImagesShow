//
//  XBSelectImageView.h
//  PhotoMutselect
//
//  Created by 聂小波MacPro on 15/11/7.
//  Copyright © 2015年 聂小波. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NXBShowImageView.h"
#import "TZImagePickerController.h"
#import "ZMView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

//协议定义
@protocol SelectPhotosDelegate <NSObject>

- (void)imgfilePathArray:(NSMutableArray *)filePathArray
                  heights:(float)heights;
@end

@interface SelectImageView
    : UIView <UIActionSheetDelegate, UIImagePickerControllerDelegate,
              UINavigationControllerDelegate, UIScrollViewDelegate,
              TZImagePickerControllerDelegate>
//下拉菜单
@property(nonatomic, strong) UIActionSheet *myActionSheet;
@property(nonatomic, strong) NSString *filePath;
@property(nonatomic, strong) NSMutableArray *photoImgsArray;
@property(nonatomic, strong) NSMutableArray *imgFilePathArray;
@property(nonatomic, strong) NSMutableArray *imageViewsArray;

//最多可显示最大图片数
@property(nonatomic, assign) int maxImageShowNumber;
//当前可选最大图片数
@property(nonatomic, assign) int maximumImage;
@property(nonatomic, strong) UIView *BlankImgV;
//遵循协议的一个代理变量定义
@property(nonatomic, weak) id<SelectPhotosDelegate> delegate;
@property(nonatomic, assign) CGRect defaultFrame;

#pragma mark - 图片宽度是定值63
- (void)imageViewInitMaxImages2:(int)max_imgs imgWidth:(float)imgWidth;
#pragma mark - 更新显示页面
- (void)resetImages;
#pragma mark 显示本地图片
- (void)resetImagesWithFilePath;
#pragma mark 显示网络图片
- (void)resetImagesWithNetUrlFilePathArray:(NSArray *)FilePathArray;
#pragma mark - 设置当前编辑状态
- (void)resetEditState:(BOOL)isEdit;

@end
