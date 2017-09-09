#import "DetailViewController.h"
#import "UIImage+Scale.h"
#import "FilteringService.h"
#import "CustomCollectionViewCell.h"

typedef NS_ENUM(NSInteger, FilteringType) {
    CIPhotoEffectNone,
    CIPhotoEffectMono,
    CIPhotoEffectFade,
    CIPhotoEffectChrome,
    CIColorInvert,
    CIPhotoEffectInstant,
    CIPhotoEffectNoir,
    CIPhotoEffectTonal,
    CIPhotoEffectProcess
};

static NSInteger const CountFilteringType = 9;

static NSString * const FilteringTypesArray[CountFilteringType] = {
    [CIPhotoEffectNone] = @"CIPhotoEffectNone",
    [CIPhotoEffectMono] = @"CIPhotoEffectMono",
    [CIPhotoEffectFade] = @"CIPhotoEffectFade",
    [CIPhotoEffectChrome] = @"CIPhotoEffectChrome",
    [CIColorInvert] = @"CIColorInvert",
    [CIPhotoEffectInstant] = @"CIPhotoEffectInstant",
    [CIPhotoEffectNoir] = @"CIPhotoEffectNoir",
    [CIPhotoEffectTonal] = @"CIPhotoEffectTonal",
    [CIPhotoEffectProcess] = @"CIPhotoEffectProcess"
};

@interface DetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetailViewController

#pragma mark - life cycle UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.originalImage = [UIImage imageWithImage:self.originalImage scaledToSize:self.imageView.bounds.size];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save image" style:UIBarButtonItemStyleDone target:self action:@selector(saveImageInPhotoLibrary)];
}

#pragma mark - actions

- (void)saveImageInPhotoLibrary {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
    }completionHandler:^(BOOL success, NSError *error) {
        if(success){
            NSLog(@"worked");
        }else{
            NSLog(@"Error: %@", error);
            
        }
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return CountFilteringType;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.hidesWhenStopped = YES;
    activityIndicator.color = [UIColor redColor];
    [cell addSubview:activityIndicator];
    [activityIndicator startAnimating];
    [FilteringService filterImage:self.imageView.image effectType:FilteringTypesArray[indexPath.row] completion:^(UIImage *newImage) {
        cell.imageView.image = newImage;
        [activityIndicator stopAnimating];
    }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.activityIndicator startAnimating];
    [FilteringService filterImage:self.originalImage effectType:FilteringTypesArray[indexPath.row] completion:^(UIImage *newImage) {
        self.imageView.image = newImage;
        [self.activityIndicator stopAnimating];
    }];
}

@end
