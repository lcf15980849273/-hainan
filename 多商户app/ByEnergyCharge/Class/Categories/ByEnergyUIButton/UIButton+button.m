//
//  UIButton+button.m
//  iOSApp
//

#import "UIButton+button.h"

@implementation UIButton (button)

/**
 创建品牌和品类button的通用方法
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                        frame:(CGRect)frame
                        image:(NSString *)imageName
                          tag:(NSInteger)tag
                         font:(NSInteger)font
                        color:(UIColor *)titleColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    UIColor *dTitleColor = titleColor ? titleColor : BYENERGYCOLOR(0x181818);
    [button setTitleColor:dTitleColor forState:UIControlStateNormal];
    if (imageName.length) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    button.frame = frame;
    button.tag = tag;
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                        frame:(CGRect)frame
                        image:(NSString *)imageName
                          tag:(NSInteger)tag
                         font:(NSInteger)font {
    return [self buttonWithTitle:title frame:frame image:imageName tag:tag font:font color:nil];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                        frame:(CGRect)frame
                          tag:(NSInteger)tag
                         font:(NSInteger)font {
    return [self buttonWithTitle:title frame:frame image:nil tag:tag font:font];
}

+ (UIButton *)buttonWithImageName:(NSString *)imageName
                            frame:(CGRect)frame
                              tag:(NSInteger)tag {
    return [self buttonWithTitle:nil frame:frame image:imageName tag:tag font:0];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                        frame:(CGRect)frame
                        image:(NSString *)imageName
                        color:(UIColor *)titleColor {
    return [self buttonWithTitle:title frame:frame image:imageName tag:0 font:0 color:titleColor];
}

+ (UIButton *)zm_buttonWithTitle:(NSString *)title
                             frame:(CGRect)frame
                             image:(NSString *)imageName
                             color:(UIColor *)titleColor
                              font:(UIFont *)font {
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    UIColor *dTitleColor = titleColor ? titleColor : BYENERGYCOLOR(0x181818);
    [button setTitleColor:dTitleColor forState:UIControlStateNormal];
    if (imageName.length) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    button.frame = frame;
    return button;
}

+ (UIButton *)zm_buttonWithTitle:(NSString *)title
                      seletTitle:(NSString *)seletTitle
                           frame:(CGRect)frame
                           image:(NSString *)imageName
                           color:(UIColor *)titleColor
                            font:(UIFont *)font {
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:seletTitle forState:UIControlStateSelected];
    button.titleLabel.font = font;
    UIColor *dTitleColor = titleColor ? titleColor : BYENERGYCOLOR(0x181818);
    [button setTitleColor:dTitleColor forState:UIControlStateNormal];
    if (imageName.length) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    button.frame = frame;
    return button;
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title {
    UIButton *btn = [self itemButtonWithTarget:target action:action title:title];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIButton *)itemButtonWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title {
    UIButton *rightItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItemBtn.titleLabel.font = ByEnergyRegularFont(16);
    [rightItemBtn setTitleColor:BYENERGYCOLOR(0xe99400) forState:UIControlStateNormal];
    [rightItemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [rightItemBtn setTitle:title forState:UIControlStateNormal];
    [rightItemBtn sizeToFit];
    return rightItemBtn;
    
}

+(UIBarButtonItem *)ItemWithTaget:(id)taget andAction:(SEL)action andImage:(NSString *)image andSelectImage:(NSString *)selectImage
{
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    //设置两种状态的图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    //设置尺寸
    CGSize size =btn.currentBackgroundImage.size;
    btn.frame=CGRectMake(0,0,size.width, size.height);
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+ (UIBarButtonItem *)ItemWithTaget:(id)taget andAction:(SEL)action andtitle:(NSString *)title andSelecttitle:(NSString *)selecttitle
{
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selecttitle forState:UIControlStateSelected];
    [btn setTitleColor:BYENERGYCOLOR(0x181818) forState:UIControlStateNormal];
    [btn setTitleColor:BYENERGYCOLOR(0x181818) forState:UIControlStateSelected];
    //设置尺寸
    CGSize size =btn.currentBackgroundImage.size;
    btn.frame=CGRectMake(0,0,size.width, size.height);
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}


+ (UIButton *)itemButtonWithTitle:(NSString *)title
                           target:(id)target
                           action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = ByEnergyRegularFont(16);
    [btn setTitleColor:BYENERGYCOLOR(0xe99400) forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return btn;
}


+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                     target:(id)target
                     action:(SEL)action {
    UIButton *btn = [self itemButtonWithTitle:title target:target action:action];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (UIButton *)itemButtonWithImgName:(NSString *)imgName
                             target:(id)target
                             action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:IMAGEWITHNAME(imgName) forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIBarButtonItem *)itemWithImgName:(NSString *)imgName
                              target:(id)target
                              action:(SEL)action {
    UIButton *btn = [self itemButtonWithImgName:imgName target:target action:action];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

- (void)setNormalTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setSelectTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateSelected];
}

- (void)setNormalImage:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)setSelectImage:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
}

- (void)setZmImageName:(NSString *)zmImageName{
    [self setBackgroundImage:[UIImage zm_imageWithName:zmImageName] forState:UIControlStateNormal];    
}

@end
