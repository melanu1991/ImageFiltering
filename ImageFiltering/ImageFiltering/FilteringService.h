#import <Foundation/Foundation.h>

@class UIImage;

@interface FilteringService : NSObject

+ (void)filterImage:(UIImage *)image effectType:(NSString *)effectType completion:(void(^)(UIImage *image))completion;

@end
