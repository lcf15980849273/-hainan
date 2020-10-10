//
//  UIButton+button.h
//  iOSApp
//

#import <UIKit/UIKit.h>

@interface UIButton (button)
+ (UIButton *)buttonWithTitle:(NSString *)title
                        frame:(CGRect)frame
                        image:(NSString *)imageName
                          tag:(NSInteger)tag
                         font:(NSInteger)font
                        color:(UIColor *)titleColor;

+ (UIButton *)buttonWithTitle:(NSString *)title
                        frame:(CGRect)frame
                        image:(NSString *)imageName
                          tag:(NSInteger)tag
                         font:(NSInteger)font;

+ (UIButton *)buttonWithTitle:(NSString *)title
                        frame:(CGRect)frame
                          tag:(NSInteger)tag
                         font:(NSInteger)font;

+ (UIButton *)buttonWithImageName:(NSString *)imageName
                            frame:(CGRect)frame
                              tag:(NSInteger)tag;

+ (UIButton *)buttonWithTitle:(NSString *)title
                        frame:(CGRect)frame
                        image:(NSString *)imageName
                        color:(UIColor *)titleColor;
+ (UIButton *)zm_buttonWithTitle:(NSString *)title
                             frame:(CGRect)frame
                             image:(NSString *)imageName
                             color:(UIColor *)titleColor
                              font:(UIFont *)font;
+ (UIBarButtonItem *)ItemWithTaget:(id)taget
                        andAction:(SEL)action
                         andImage:(NSString *)image
                   andSelectImage:(NSString *)selectImage;

+ (UIBarButtonItem *)ItemWithTaget:(id)taget
                        andAction:(SEL)action
                         andtitle:(NSString *)title
                   andSelecttitle:(NSString *)selecttitle;

/*
 自己用
 **/
+ (UIButton *)itemButtonWithTitle:(NSString *)title
                           target:(id)target
                           action:(SEL)action;
/*
 自己用
 **/
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                     target:(id)target
                     action:(SEL)action;


/*
 自己用
 **/
+ (UIButton *)itemButtonWithImgName:(NSString *)imgName
                             target:(id)target
                             action:(SEL)action;

/*
 自己用
 **/
+ (UIBarButtonItem *)itemWithImgName:(NSString *)imgName
                              target:(id)target
                              action:(SEL)action;

/*
 自己用
 **/
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title;

+ (UIButton *)itemButtonWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title;

+ (UIButton *)zm_buttonWithTitle:(NSString *)title
                      seletTitle:(NSString *)seletTitle
                           frame:(CGRect)frame
                           image:(NSString *)imageName
                           color:(UIColor *)titleColor
                            font:(UIFont *)font;
- (void)setNormalTitle:(NSString *)title;
- (void)setSelectTitle:(NSString *)title;

- (void)setNormalImage:(NSString *)imageName;
- (void)setSelectImage:(NSString *)imageName;

@property (strong, nonatomic) IBInspectable NSString *zmImageName;


@end
