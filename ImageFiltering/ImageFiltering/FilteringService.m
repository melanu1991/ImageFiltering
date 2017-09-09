#import "FilteringService.h"
#import <UIKit/UIKit.h>

@interface FilteringService ()

@end

@implementation FilteringService

static NSOperationQueue *_operationQueue;

+ (NSOperationQueue *)operationQueue {
    return _operationQueue;
}

+ (void)setOperationQueue:(NSOperationQueue *)operationQueue {
    if (_operationQueue != operationQueue) {
        _operationQueue = operationQueue;
    }
}

+ (void)filterImage:(UIImage *)image effectType:(NSString *)effectType completion:(void(^)(UIImage *image))completion {
    
    FilteringService.operationQueue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
    __weak NSBlockOperation *weakBlockOperation = blockOperation;
    [blockOperation addExecutionBlock:^{
        UIImage *newImage = image;
        if (![effectType isEqualToString:@"CIPhotoEffectNone"]) {
            if ([weakBlockOperation isCancelled]) {
                return;
            }
            CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
            CIContext *context = [CIContext contextWithOptions:nil];
            CIFilter *filter = [CIFilter filterWithName:effectType];
            [filter setValue:inputImage forKey:kCIInputImageKey];
            CIImage *outputImage = [filter outputImage];
            CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
            newImage = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            if ([weakBlockOperation isCancelled]) {
                return;
            }
        }
        NSOperationQueue *mainOperationQueue = [NSOperationQueue mainQueue];
        [mainOperationQueue addOperationWithBlock:^{
            if (completion && ![weakBlockOperation isCancelled]) {
                completion(newImage);
            }
        }];
    }];
    
    [FilteringService.operationQueue addOperation:blockOperation];
    
}

@end
