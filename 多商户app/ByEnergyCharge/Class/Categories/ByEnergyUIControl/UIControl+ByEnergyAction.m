//
//  UIControl+ByEnergyAction.m
//

#import "UIControl+ByEnergyAction.h"
#import "NSObject+VDExtraData.h"
@implementation UIControl (BDAction)

#pragma mark - Public Method

- (void)zm_controlTapAction:(BDControlActionBlock)action {
    self.zm_tapControlActionElement.action = action;
}

- (void)zm_controlTapWithTarget:(id)target selector:(SEL)selector {
    self.zm_tapControlActionElement.action = nil;
    self.zm_tapControlActionElement.actionTarget = target;
    self.zm_tapControlActionElement.actionSelector = selector;
}

#pragma mark - Setter Getter

- (void)setZm_tapControlActionElement:(BDControlActionElement *)zm_tapControlActionElement {
    [self vd_extraDataForSelector:@selector(zm_tapControlActionElement)].data = zm_tapControlActionElement;
}

- (BDControlActionElement *)zm_tapControlActionElement {
    BDControlActionElement *element = [self vd_extraDataForSelector:@selector(zm_tapControlActionElement)].data;
    if (!element) {
        element = [BDControlActionElement new];
        element.target = self;
        self.zm_tapControlActionElement = element;
    }
    
    return element;
}






@end

@implementation BDControlActionElement

#pragma mark - Actions

- (void)targetDidTouchUpInside:(UIControl *)sender {
    if (self.action) {
        self.action(self.target);
    }
    else if (self.actionTarget && self.actionSelector) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.actionTarget performSelector:self.actionSelector withObject:self.target];
#pragma clang diagnostic pop
    }
}

#pragma mark - Setter Getter

- (void)setTarget:(UIControl *)target {
    if (_target == target) {
        return;
    }
    
    [_target removeTarget:self action:@selector(targetDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
    _target = target;
    
    [_target addTarget:self action:@selector(targetDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

@end
