//
//  UIControl+ByEnergyAction.h
//

#import <UIKit/UIKit.h>

@class BDControlActionElement;

typedef void(^BDControlActionBlock)(__kindof UIControl *control);

@interface UIControl (BDAction)

/**< 存储Action相关属性元素 */
@property (nonatomic, strong) BDControlActionElement *zm_tapControlActionElement;

/**< 在UIControl(UIButton etc.)被点击时执行动作 */
- (void)zm_controlTapAction:(BDControlActionBlock)action;
/**< 在UIControl(UIButton etc.)被点击时执行动作 */
- (void)zm_controlTapWithTarget:(id)target selector:(SEL)selector;




@end

@interface BDControlActionElement : NSObject

/**< 绑定的view */
@property (nonatomic, weak) UIControl *target;

@property (nonatomic, copy) BDControlActionBlock action;

@property (nonatomic, weak) id actionTarget;
@property (nonatomic, assign) SEL actionSelector;

@end
