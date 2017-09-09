#import <Foundation/Foundation.h>

@class UIImage;

@interface FilteringService : NSObject

@property (class, strong, nonatomic) NSOperationQueue *operationQueue;

+ (void)filterImage:(UIImage *)image effectType:(NSString *)effectType completion:(void(^)(UIImage *image))completion;

@end
