//
//  UIView+Gesture.h
//  WKDK_Project
//
//  Created by 刘辰峰 on 2020/5/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BDGestureElement;
typedef void(^BDGestureActionBlock)(__kindof UIView *view);

@interface UIView (Gesture)

/**< 存储手势相关属性元素 */
@property (nonatomic, strong) BDGestureElement *zm_tapGestureElement;

/**< 在view被点击时执行动作 */
- (void)zm_performActionOnTap:(BDGestureActionBlock)action;
/**< 在view被点击时执行动作，若view有subview，点击发生在subview上时不执行动作 */
- (void)zm_performActionOnTap:(BDGestureActionBlock)action backgroundOnly:(BOOL)isBackgroundOnly;
/**< 在view被点击时执行动作 */
- (void)zm_performSelectorOnTapWithTarget:(id)target selector:(SEL)selector;
/**< 在view被点击时执行动作，若view有subview，点击发生在subview上时不执行动作 */
- (void)zm_performSelectorOnTapWithTarget:(id)target selector:(SEL)selector backgroundOnly:(BOOL)isBackgroundOnly;

@end

@interface BDGestureElement : NSObject <UIGestureRecognizerDelegate>

/**< 绑定的view */
@property (nonatomic, weak) UIView *target;
@property (nonatomic, strong, readonly) UIGestureRecognizer *gestureRecognizer;

/**< 是否只响应view上的点击，不响应subview上的点击 */
@property (nonatomic, assign, getter=isBackgroundOnly) BOOL backgroundOnly;

@property (nonatomic, copy) BDGestureActionBlock action;

@property (nonatomic, weak) id actionTarget;
@property (nonatomic, assign) SEL actionSelector;
@end

NS_ASSUME_NONNULL_END
