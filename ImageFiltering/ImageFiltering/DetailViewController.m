#import "DetailViewController.h"
#import "UIImage+Scale.h"

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

static NSString * const FilteringTypesArray[] = {
    [CIPhotoEffectNone] = @"",
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

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = [UIImage imageWithImage:self.originalImage scaledToSize:self.imageView.bounds.size];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
