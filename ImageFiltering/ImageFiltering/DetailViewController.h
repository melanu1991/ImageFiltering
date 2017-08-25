#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef void(^CompletionBlock)(UIImage *newImage);

@interface DetailViewController : UIViewController

@property (strong, nonatomic) UIImage *originalImage;

@end
