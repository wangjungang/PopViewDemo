//
//  YTPopView.m
//  YTPopViewDemo
//
//  Created by 杨通 on 2018/7/27.
//  Copyright © 2018年 TonyAng. All rights reserved.
//
/** 手机屏 比例 */
#define kIphone6Width 375.0
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define kFit(x) (Screen_Width*((x)/kIphone6Width))
#define UIColorFromR_G_B(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#import "YTPopView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIDevice+AIFExtension.h"
@interface YTPopView ()

@property (nonatomic,strong) UIView *alertview;

@property (nonatomic,strong) UIImageView *pictureImageView;//图片
@property (nonatomic,strong) UIButton *cancelbutton;//取消
@end

@implementation YTPopView


-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        // 单击的 Recognizer(_typeBottomView添加手势)
        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sharePicCancelButtonAction)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:singleRecognizer];
        CGFloat top = [[UIDevice currentDevice] safeAreaTop] + [[UIDevice currentDevice] navigationBarHeight];
        self.alertview.frame = CGRectMake(kFit(75/2),  kFit(21) + top, Screen_Width -kFit(75), kFit(460 + 51));
        self.alertview.backgroundColor = [UIColor clearColor];
        [self addSubview:self.alertview];
        [self createYTStsrAlertView];
    }
    return self;
}

- (void)setSharePictureImageUrlStr:(NSString *)sharePictureImageUrlStr {
    _sharePictureImageUrlStr = sharePictureImageUrlStr;
    NSLog(@"----sharePictureImageUrlStr----set方法----");
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:_sharePictureImageUrlStr] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
}

- (void)createYTStsrAlertView {
    NSLog(@"----sharePictureImageUrlStr----create----");
    self.pictureImageView = [UIImageView new];
    [self.alertview addSubview:self.pictureImageView];
    self.pictureImageView.backgroundColor = [UIColor cyanColor];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertview).offset(0);
        make.left.equalTo(self.alertview).offset(0);
        make.right.equalTo(self.alertview).offset(0);
        make.bottom.equalTo(self.alertview).offset(-kFit(51));
    }];

    //取消
    self.cancelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelbutton setImage:[UIImage imageNamed:@"cleseSharePicture"] forState:UIControlStateNormal];
    [self.alertview addSubview:self.cancelbutton];
    [self.cancelbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.offset(25);
        make.left.right.offset(0);
    }];
    [self.cancelbutton addTarget:self action:@selector(sharePicCancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -
#pragma mark -------->取消Action
- (void)sharePicCancelButtonAction {
    NSLog(@"取消了----view");
    [self dismissAlertView];
}

- (UIView *)alertview {
    if (_alertview == nil) {
        _alertview = [[UIView alloc] init];
        _alertview.backgroundColor = [UIColor whiteColor];
        _alertview.layer.cornerRadius = 0;
        _alertview.layer.masksToBounds = YES;
    }
    return _alertview;
}

- (void)show {
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.alertview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertview.alpha = 0;
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        strongSelf.backgroundColor = UIColorFromR_G_B(1, 1, 1, 0.3f);
        strongSelf.alertview.transform = transform;
        strongSelf.alertview.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismissAlertView {
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
