//
//  CGLoopItemModel.h
//  CGraphicsCollection
//
//  Created by lizitao on 2021/4/13.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, CGJumpType) {
    CGWebType = 1,  //Url类型跳转
    CGAppOutsideType = 2,    //App外跳转
    CGAppInsideType = 3,   //App内跳转
};
NS_ASSUME_NONNULL_BEGIN

@interface CGLoopItemModel : NSObject
@property (nonatomic, assign) CGJumpType jumpType;//跳转类型
@property (nonatomic, copy) NSString *jumpContent;//跳转内容
@property (nonatomic, copy) NSString *icon;//图片
@end

NS_ASSUME_NONNULL_END
