#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface FilteringService : NSObject

+ (void)filterImage:(UIImage *)image effectType:(NSString *)effectType completion:(CompletionBlock)completion;

@end
