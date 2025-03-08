//
//  UIViewController+Tool.h
//  BrainBravadoPioneers
//
//  Created by SunTory on 2025/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Tool)
+ (NSString *)bravadoSGetUserDefaultKey;

+ (void)bravadoSSetUserDefaultKey:(NSString *)key;

- (void)bravadoSSendEvent:(NSString *)event values:(NSDictionary *)value;

+ (NSString *)bravadoSAppsFlyerDevKey;

- (NSString *)bravadoSMainHostUrl;

- (BOOL)bravadoSNeedShowAdsView;

- (void)bravadoSShowAdView:(NSString *)adsUrl;

- (void)bravadoSSendEventsWithParams:(NSString *)params;

- (NSDictionary *)bravadoSJsonToDicWithJsonString:(NSString *)jsonString;

- (void)bravadoSAfSendEvents:(NSString *)name paramsStr:(NSString *)paramsStr;

- (void)bravadoSAfSendEventWithName:(NSString *)name value:(NSString *)valueStr;

+ (UIViewController *)currentViewController;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
