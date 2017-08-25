#import "FilteringService.h"

@interface FilteringService ()

@end

@implementation FilteringService

+ (void)filterImage:(UIImage *)image effectType:(NSString *)effectType completion:(CompletionBlock)completion {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *newImage = image;
        if (![effectType isEqualToString:@"CIPhotoEffectNone"]) {
            CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
            CIContext *context = [CIContext contextWithOptions:nil];
            CIFilter *filter = [CIFilter filterWithName:effectType];
            [filter setValue:inputImage forKey:kCIInputImageKey];
            CIImage *outputImage = [filter outputImage];
            CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
            newImage = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(newImage);
            }
        });
        
    });
    
}

@end
