//
//  XBSelectImageView.m
//  PhotoMutselect
//
//  Created by 聂小波MacPro on 15/11/7.
//  Copyright © 2015年 聂小波. All rights reserved.
//

#import "SelectImageView.h"
#define XBScreenWidth [UIScreen mainScreen].bounds.size.width
#define XBScreenHieght [UIScreen mainScreen].bounds.size.height
@interface SelectImageView ()
@property(nonatomic, strong) UIViewController *fatherVC;
@end

@implementation SelectImageView {
}

- (UIViewController *)fatherVC {
  if (!_fatherVC) {
    _fatherVC = (UIViewController *)self.delegate;
  }
  return _fatherVC;
}

#pragma mark - 根据屏幕宽度设置图片
- (void)imageViewInitMaxImages:(int)maxImages {
  self.backgroundColor = [UIColor whiteColor];

  _photoImgsArray = [[NSMutableArray alloc] init];
  _imageViewsArray = [[NSMutableArray alloc] init];
  _imgFilePathArray = [[NSMutableArray alloc] init];

  int ImgX = 20;
  int ImgY = 10;
  int imgTag = 90;
  int btnTag = 1001;
  float imgWidth = 0;
  //一行显示4张
  imgWidth = (Screen_width - (4 + 1) * ImgX) / 4;

  for (int i = 0; i < maxImages; i++) {

    ImgX = 20 + (i % 4) * (imgWidth + 20);
    ImgY = 10 + (imgWidth + 10) * (int)(i / 4);
    imgTag += i;

    [self addImageAndButtonImgX:ImgX
                           ImgY:ImgY
                         imgTag:imgTag + i
                         btnTag:btnTag + i
                       imgWidth:imgWidth];
  }
  UIImageView *image1 = [self viewWithTag:90];
  image1.image = [UIImage imageNamed:@"Addimages"];

  [self resetImages];
}
#pragma mark - 图片宽度是定值63
- (void)imageViewInitMaxImages2:(int)maxImages imgWidth:(float)imgWidth {
  self.backgroundColor = [UIColor whiteColor];

  _maxImageShowNumber = maxImages;

  _photoImgsArray = [[NSMutableArray alloc] init];
  _imageViewsArray = [[NSMutableArray alloc] init];
  _imgFilePathArray = [[NSMutableArray alloc] init];

  int ImgX = 13;
  int ImgY = 10;
  int imgTag = 90;
  int btnTag = 1001;
//  imgWidth = 63;
  if (Screen_width < 400) { //一行显示4张
    for (int i = 0; i < maxImages; i++) {

      ImgX = 13 + (i % 4) * (imgWidth + 13);
      ImgY = 10 + (imgWidth + 10) * (int)(i / 4);
      imgTag += i;

      [self addImageAndButtonImgX:ImgX
                             ImgY:ImgY
                           imgTag:imgTag + i
                           btnTag:btnTag + i
                         imgWidth:imgWidth];
    }

  } else { //一行显示5张

    for (int i = 0; i < maxImages; i++) {

      ImgX = 13 + (i % 5) * (imgWidth + 13);
      ImgY = 10 + (imgWidth + 10) * (int)(i / 5);
      imgTag += i;

      [self addImageAndButtonImgX:ImgX
                             ImgY:ImgY
                           imgTag:imgTag + i
                           btnTag:btnTag + i
                         imgWidth:imgWidth];
    }
  }
  UIImageView *image1 = [self viewWithTag:90];
  image1.image = [UIImage imageNamed:@"Addimages"];

  [self resetImages];
}

- (void)addImageAndButtonImgX:(int)ImgX
                         ImgY:(int)ImgY
                       imgTag:(int)imgTag
                       btnTag:(int)btnTag
                     imgWidth:(float)imgWidth {

  CGRect imgFrame = CGRectMake(ImgX, ImgY, imgWidth, imgWidth);
  CGRect btn_Frame = CGRectMake(ImgX + imgWidth - 15, ImgY - 10, 30, 30);

  UIImageView *imgV = [[UIImageView alloc] initWithFrame:imgFrame];
  imgV.tag = imgTag;
  [self addSubview:imgV];
  [_imageViewsArray addObject:imgV];

  UIButton *close = [[UIButton alloc] initWithFrame:btn_Frame];
  close.hidden = YES;
  close.tag = btnTag;
  [close setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];

  [close setImage:[UIImage imageNamed:@"close_R"]
         forState:UIControlStateNormal];

  [close addTarget:self
                action:@selector(closeButtonClick:)
      forControlEvents:UIControlEventTouchUpInside];

  [self addSubview:close];
}

- (void)addCloseButtonFrame:(CGRect)Frame Tag:(int)tag {
  UIButton *close = [[UIButton alloc] initWithFrame:Frame];
  close.hidden = YES;
  close.tag = tag;
  [close setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];

  [close setImage:[UIImage imageNamed:@"close_R"]
         forState:UIControlStateNormal];

  [close addTarget:self
                action:@selector(closeButtonClick:)
      forControlEvents:UIControlEventTouchUpInside];

  [self addSubview:close];
}
- (void)closeButtonClick:(UIButton *)closebnt {
  long ii = closebnt.tag - 1001;
  if (ii >= 0) {

    if (ii < _photoImgsArray.count) {
      [_photoImgsArray removeObjectAtIndex:ii];
    }
    if (ii < _imgFilePathArray.count) {
      [_imgFilePathArray removeObjectAtIndex:ii];
    }
  }
  [self resetImages];
}
- (void)resetCloseButton {
  //默认编辑状态
  [self resetCloseButtonEdit:YES];
}
- (void)resetCloseButtonEdit:(BOOL)isEdit {
  for (UIView *subView in self.subviews) {
    if ([subView isKindOfClass:[UIButton class]]) {
      UIButton *But = (UIButton *)subView;
      But.hidden = YES;
    }
  }
  if (isEdit) {
    for (int i = 1001; i < _photoImgsArray.count + 1001; i++) {
      for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
          UIButton *But = (UIButton *)subView;

          if (But.tag == i) {

            But.hidden = NO;
          }
        }
      }
    }
  }
}

- (void)resetImages {
  //设置图片
  for (int i = 0; i < _maxImageShowNumber; i++) {
    UIImageView *images = [self.imageViewsArray objectAtIndex:i];
    [self clearImageAction:images];
    images.hidden = YES;
  }

  [self resetCloseButton];

  for (int i = 0; i < self.photoImgsArray.count + 1; ++i) {
    if (i >= _maxImageShowNumber) {
      break;
    }
    UIImageView *tempImgView = [self.imageViewsArray objectAtIndex:i];
    tempImgView.userInteractionEnabled = YES;
    tempImgView.contentMode = UIViewContentModeScaleAspectFill;
    tempImgView.clipsToBounds = YES;
    tempImgView.hidden = NO;
    UIImage *img;
    if (i == self.photoImgsArray.count) {
      img = [UIImage imageNamed:@"Addimages"];
      UITapGestureRecognizer *tap =
          [[UITapGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(pickPic:)];
      tap.view.tag = 90 + i;
      [tempImgView addGestureRecognizer:tap];
    } else {

      img = [_photoImgsArray objectAtIndex:i];

      tempImgView.tag = i;
      tempImgView.userInteractionEnabled = YES;
      tempImgView.contentMode = UIViewContentModeScaleAspectFill;
      tempImgView.clipsToBounds = YES;
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
          initWithTarget:self
                  action:@selector(toImageDetail:)];
      [tempImgView addGestureRecognizer:tap];
    }
    [tempImgView setImage:img];

    [self sendfilePath_Array];
  }
}

- (void)resetImagesEdit:(BOOL)isEdit {
  for (int i = 0; i < self.photoImgsArray.count + 1; ++i) {
    if (i >= _maxImageShowNumber) {
      break;
    }
    UIImageView *tempImgView = [self.imageViewsArray objectAtIndex:i];

    if (i == self.photoImgsArray.count) {
      tempImgView.hidden = !isEdit;
    }
  }
}

- (void)sendfilePath_Array {
  //    int ImgX=13;
  int ImgY = 10;
  float imgWidth = 0;
  //一行显示4张
  //    imgWidth=(Screen_width-(4+1)*ImgX)/4;

  imgWidth = 63;

  if (Screen_width < 400) { //一行显示4张
    ImgY += (imgWidth + 10) * ((int)(_imgFilePathArray.count / 4) + 1);

  } else {
    ImgY += (imgWidth + 10) * ((int)(_imgFilePathArray.count / 5) + 1);
  }
  if ([_delegate respondsToSelector:@selector(imgfilePathArray:heights:)]) {
    [_delegate imgfilePathArray:_imgFilePathArray heights:ImgY];
  }
}

- (void)pickPic:(UIGestureRecognizer *)ges {
  [self endEditing:YES];

  [self.fatherVC.view endEditing:YES];
  _maximumImage = _maxImageShowNumber - (int)_photoImgsArray.count;

  if (_maximumImage > 0) {
    [self openMenu];
  }
}
- (void)openMenu {
  //在这里呼出下方菜单按钮项
  _myActionSheet = [[UIActionSheet alloc]
               initWithTitle:nil
                    delegate:self
           cancelButtonTitle:@"取消"
      destructiveButtonTitle:nil
           otherButtonTitles:@"打开照相机", @"从手机相册获取", nil];
  //
  [_myActionSheet showInView:self.window];
}
//下拉菜单的点击响应事件
- (void)actionSheet:(UIActionSheet *)actionSheet
    clickedButtonAtIndex:(NSInteger)buttonIndex {

  if (buttonIndex == _myActionSheet.cancelButtonIndex) {
    NSLog(@"取消");
  }
  switch (buttonIndex) {
  case 0:
    [self takePhoto];
    break;
  case 1:
    [self localPhoto];
    break;
  default:
    break;
  }
}
//开始拍照
- (void)takePhoto {
  UIImagePickerControllerSourceType sourceType =
      UIImagePickerControllerSourceTypeCamera;
  if ([UIImagePickerController
          isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //设置拍照后的图片可被编辑
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    UIViewController *fatherVC = (UIViewController *)self.delegate;
    [fatherVC presentViewController:picker animated:YES completion:nil];

  } else {
    NSLog(@"模拟其中无法打开照相机,请在真机中使用");
  }
}

//打开相册，可以多选
- (void)localPhoto {

  TZImagePickerController *imagePickerVc =
      [[TZImagePickerController alloc] initWithMaxImagesCount:_maximumImage
                                                     delegate:self];
  imagePickerVc.allowPickingOriginalPhoto = NO;
  imagePickerVc.allowPickingVideo = NO;
  NSMutableArray<NSString *> *imagePaths = [[NSMutableArray alloc] init];
  ZMView *zmView = [[ZMView alloc] init];
  [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(
                     NSArray<UIImage *> *photos, NSArray *assets,
                     BOOL isSelectOriginalPhoto,
                     NSArray<NSDictionary *> *infos) {

    int index = 0;
    __block NSInteger totalCount = photos.count;
    __block NSInteger curIndex = 0;
    for (NSDictionary *dic in infos) {
      UIImage *photo = [photos objectAtIndex:index];
      NSURL *url = [dic objectForKey:@"PHImageFileURLKey"];
      __block NSString *path = [url absoluteString];
      PHAsset *asset = assets[index];
      [asset valueForKey:@"filename"];
      __block NSString *filename = [path lastPathComponent];
      if (filename == nil) {
        [asset
            requestContentEditingInputWithOptions:nil
                                completionHandler:^(
                                    PHContentEditingInput *contentEditingInput,
                                    NSDictionary *info) {

                                  // add
                                  NSString *jpgname =
                                      [NSString stringWithFormat:
                                                    @"%d%ld.jpg",
                                                    (int)[[NSDate new]
                                                        timeIntervalSince1970],
                                                    (long)curIndex];
                                  path = [zmView saveImageToLocalimage:photo
                                                              filename:jpgname
                                                                 index:0];
                                  [_imgFilePathArray addObject:path];
                                  [_photoImgsArray addObject:photo];

                                  curIndex++;
                                  if (curIndex == totalCount) {
                                    [self resetImages];
                                  }
                                }];
      } else {
        path = [zmView saveImageToLocalimage:photo filename:filename];
        [imagePaths addObject:path];

        // add
        NSString *jpgname = [NSString
            stringWithFormat:@"%d%ld.jpg",
                             (int)[[NSDate new] timeIntervalSince1970],
                             (long)curIndex];
        path = [zmView saveImageToLocalimage:photo filename:jpgname index:0];
        [_imgFilePathArray addObject:path];
        [_photoImgsArray addObject:photo];

        curIndex++;
        if (curIndex == totalCount) {
          [self resetImages];
        }
      }
      index++;
    }
  }];
  UIViewController *fatherVC = (UIViewController *)self.delegate;
  [fatherVC presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark 显示本地图片
- (void)resetImagesWithFilePath {
  _photoImgsArray = [NSMutableArray new];
  for (int i = 0; i < _imgFilePathArray.count; i++) {

    UIImage *tempImg = [self getImageFileWithName:_imgFilePathArray[i]];
    UIImageView *imgView_temp = _imageViewsArray[i];
    imgView_temp.image = tempImg;

    if (tempImg) {
      [_photoImgsArray addObject:tempImg];
    }
  }

  [self resetImages];
}
- (UIImage *)getImageFileWithName:(NSString *)filePath {
  NSError *err = [[NSError alloc] init];

  NSData *data = [[NSData alloc] initWithContentsOfFile:filePath

                                                options:NSDataReadingMapped

                                                  error:&err];

  UIImage *img = nil;
  if (data != nil) {
    img = [[UIImage alloc] initWithData:data];
  } else {
    NSLog(@"getImageFileWithName error code : %ld", (long)[err code]);
  }
  return img;
}

#pragma mark 显示网络图片
- (void)resetImagesWithNetUrlFilePathArray:(NSArray *)FilePathArray {
  _photoImgsArray = [NSMutableArray new];
  for (int i = 0; i < FilePathArray.count; i++) {

    UIImageView *imgView_temp = _imageViewsArray[i];

    [imgView_temp
        sd_setImageWithURL:[NSURL URLWithString:FilePathArray[i]]
          placeholderImage:[UIImage imageNamed:@"placehold_image"]
                 completed:^(UIImage *image, NSError *error,
                             SDImageCacheType cacheType, NSURL *imageURL) {
                   UIImage *tempImg = image;
                   if (tempImg) {
                     // 保存图片至本地，方法见下文
                     NSString *jpgname =
                         [NSString stringWithFormat:@"%d%d.jpg",
                                                    (int)[[NSDate new]
                                                        timeIntervalSince1970],
                                                    i];
                     [self saveImage:image withName:jpgname];

                     [_photoImgsArray addObject:tempImg];

                     [self resetImages];
                   }
                 }];
  }
}

#pragma mark - 设置当前编辑状态
- (void)resetEditState:(BOOL)isEdit {

  [self resetCloseButtonEdit:isEdit];
  [self resetImagesEdit:isEdit];
}

#pragma mark - 保存图片至沙盒
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName {
  NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
  NSString *fullPath = [NSString
      stringWithFormat:@"%@/%@", ApplicationDelegate.folderPath, imageName];

  // 将图片写入文件
  [imageData writeToFile:fullPath atomically:NO];
  [_imgFilePathArray addObject:fullPath];
}

//打开相机 选择某张照片之后
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [picker
      dismissViewControllerAnimated:YES
                         completion:^{

                           //关闭相册界面
                           //    [picker dismissViewControllerAnimated:YES
                           //    completion:nil];
                           NSString *type = [info
                               objectForKey:UIImagePickerControllerMediaType];
                           //当选择的类型是图片
                           if ([type isEqualToString:@"public.image"]) {

                             UIImage *image =
                                 [info objectForKey:
                                           UIImagePickerControllerEditedImage];
                             // 保存图片至本地，方法见下文
                             NSString *jpgname = [NSString
                                 stringWithFormat:@"%d.jpg",
                                                  (int)[[NSDate new]
                                                      timeIntervalSince1970]];
                             [self saveImage:image withName:jpgname];

                             [_photoImgsArray addObject:image];
                             [self resetImages];
                           }

                         }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  //    NSLog(@"您取消了选择图片");
  [picker dismissViewControllerAnimated:YES
                             completion:^{

                             }];
}

- (void)reloadData {
}

- (void)dealloc {
  self.delegate = nil;
}

- (void)clearImageAction:(UIImageView *)img {
  img.image = nil;
  for (UIGestureRecognizer *ges in img.gestureRecognizers) {
    [img removeGestureRecognizer:ges];
  }
}

#pragma mark - 查看 methods
- (void)toImageDetail:(UIGestureRecognizer *)ges {

  [self.fatherVC.view endEditing:YES];
  NXBShowImageView *tesnt = [[NXBShowImageView alloc] init];

  [tesnt initWithSuperVC:(UIViewController *)_delegate
                imageList:self.imgFilePathArray
            currentIndex:ges.view.tag];
  //显示单张图片
  //    [self showSingleImage:ges];
}

#pragma mark - 显示单张图片
- (void)showSingleImage:(UIGestureRecognizer *)ges {
  UIWindow *window = [UIApplication sharedApplication].keyWindow;
  _BlankImgV = [[UIView alloc] initWithFrame:window.frame];
  _BlankImgV.backgroundColor = [UIColor colorWithRed:1.f / 255.f
                                               green:1.f / 255.f
                                                blue:1.f / 255.f
                                               alpha:1.0];
  UIImageView *tempImgV = (UIImageView *)ges.view;

  UIImageView *tempImgView = [[UIImageView alloc] initWithFrame:window.frame];
  tempImgView.contentMode = UIViewContentModeScaleAspectFit;

  tempImgView.image = tempImgV.image;
  [_BlankImgV addSubview:tempImgView];
  [window addSubview:_BlankImgV];

  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(HideImage)];

  [_BlankImgV addGestureRecognizer:tap];
}

- (void)HideImage {
  _BlankImgV.hidden = YES;
  [_BlankImgV removeFromSuperview];
}

- (void)delImg:(NSInteger)index {
  NSString *fullPath = [self.photoImgsArray objectAtIndex:index];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if ([fileManager fileExistsAtPath:fullPath]) {
    NSError *error;
    [fileManager removeItemAtPath:fullPath error:&error];
  }
  [self.photoImgsArray removeObjectAtIndex:index];
  [self resetImages];
}

@end
