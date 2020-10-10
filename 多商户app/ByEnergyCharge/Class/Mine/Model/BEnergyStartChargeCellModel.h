//
//  BEnergyStartChargeCellModel.h
//  ByEnergyCharge
//
//  Created by newyea on 2020/3/25.
//  Copyright © 2020年 newyea. All rights reserved.
//

#import "BEnergyBaseModel.h"

/**
 定义cell类型
 */
typedef enum : NSUInteger {
    /**文本显示*/
    ByEnergyChargeCellType_TX = 0,
    /**textfield可输入*/
    ByEnergyChargeCellType_TF,
    /**check选中☑️*/
    ByEnergyChargeCellType_CHECK,
    /**支付方式*/
    ByEnergyChargeCellType_PAY,
    /**image图片*/
    ByEnergyChargeCellType_PIC,
    /**选择器*/
    ByEnergyChargeCellType_PICK,
    /**选择性别*/
    ByEnergyChargeCellType_SEX,
    /**选择职位*/
    ByEnergyChargeCellType_JOB,
    /**开关*/
    ByEnergyChargeCellType_Switch,
    /**多选*/
    ByEnergyChargeCellType_Multiple,
} ByEnergyChargeCellType;

NS_ASSUME_NONNULL_BEGIN

@interface BEnergyStartChargeCellModel : BEnergyBaseModel
@property (nonatomic, strong) NSData *imageData;    //图片
@property (nonatomic, copy) NSString *title;        //标题
@property (nonatomic, copy) NSString *placeholder;  ///输入提示
@property (nonatomic, copy) NSString *detailText;   //副标题
@property (nonatomic, copy) NSString *value;        //数值
@property (nonatomic, copy) NSString *imageName;    //图片
@property (nonatomic, copy) NSString *normalImageName;    //图片
@property (nonatomic, copy) NSString *key;          //key
@property (nonatomic, copy) NSString *validate;   ///正则表达式（没有此属性不做检查）
@property (nonatomic, copy) NSString *unit;        ///单位/其他附加值
@property (nonatomic, copy) NSString *displayValue;   ///附加显示值
@property (nonatomic, assign) BOOL autoValidate;    ///是否自动验证正则表达式
@property (nonatomic, assign) ByEnergyChargeCellType cellType; //cell类型
@property (nonatomic, assign) BOOL selected;        //是否选中
@property (nonatomic, assign) BOOL enabled;         //是否可点
@property (nonatomic, assign) int maxInputLength;   //长度
@property (nonatomic, assign) BOOL nonEmpty;        ///是否限制非空
@property (nonatomic, assign) BOOL isSecurity;                  ///是否安全模式
@property (nonatomic, assign) BOOL requireValidNum;             ///是否要求为有效数字
@property (nonatomic, assign) BOOL isArrowImg;                  ///是否显示箭头图片
@property (nonatomic, assign) BOOL showHidden;                   ///是否隐藏
@property (nonatomic, assign) NSUInteger decimalCnt;            ///有效小数位数
@property (nonatomic, strong) NSMutableArray *arrayValue;      ///数组数值
@property (nonatomic, strong) NSMutableArray *displayValueArray; ///附加数组数值
@property (nonatomic, assign) CGFloat height;                   ///高度
@property (nonatomic, assign) CGFloat width;                   ///宽度
@property (nonatomic, assign) float textFont;                  ///字体大小
@property (nonatomic, copy) NSString *textColor;                ///字体颜色
@property (nonatomic, assign) float contentFont;               ///字体大小
@property (nonatomic, copy) NSString *contentColor;             ///字体颜色
@end

NS_ASSUME_NONNULL_END
