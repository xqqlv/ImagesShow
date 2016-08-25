//
//  ViewController.m
//  PhotoPicter
//
//  Created by 岳利超 on 16/6/24.
//  Copyright © 2016年 mac003-20130924. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZMView : NSObject
- (NSString *)saveImageToLocalimage:(UIImage *)image
                           filename:(NSString *)filename;
#pragma mark - 把图片保存到本地路径
- (NSString *)saveImageToLocalimage:(UIImage *)image
                           filename:(NSString *)filename
                              index:(int)index;
@end
