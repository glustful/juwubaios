

#import "AdPageView.h"
#import "UIImageView+WebCache.h"
#import <Masonry.h>
#import "AdInfo.h"
#define mainWidth           [[UIScreen mainScreen] bounds].size.width
#define defaultInterval     3
#define addBeyond           2

@interface AdPageView()<UIScrollViewDelegate>
{
    __weak  id<AdPageViewDelegate> delegate;
    NSTimer       *autoTimer;
    UIPageControl *pcView;
    UIScrollView  *scView;
    int           adCount;
}

@property (nonatomic,assign)NSTimeInterval autoInterval;
@end

@implementation AdPageView
@synthesize delegate;

- (void)dealloc
{
    if (autoTimer)
    {
        [autoTimer invalidate];
        autoTimer = nil;
    }
}

- (instancetype)initWithAds:(NSArray*)imgNameArr

{
    self = [super init];
    if (self)
    {
        self.imgNameArr = imgNameArr;
    }
    return self;
}

-(void)setImgNameArr:(NSArray *)imgNameArr{
    
    _imgNameArr = imgNameArr;
    
    [self setAds:imgNameArr];

}


- (instancetype)init
{
    self = [super init];
    if (self) {
       self.imgNameArr = [NSMutableArray array];
        
        
    }
    return self;
}



- (void)setAds:(NSArray*)imgNameArr{
    
    adCount = (int)_imgNameArr.count;
    if(autoTimer)
        [autoTimer invalidate];
    {
        if (pcView) {
            pcView.currentPage = 0;
            [pcView updateCurrentPageDisplay];
        }
        
        scView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scView.backgroundColor = [UIColor whiteColor];
        scView.pagingEnabled = YES;
        scView.showsHorizontalScrollIndicator = NO;
        scView.showsVerticalScrollIndicator = NO;
        scView.bounces  = NO;
    
        scView.delegate = self;
        [self addSubview:scView];
    }
    
    for (UIView* v in scView.subviews) {
        [v removeFromSuperview];
    }
   
    NSMutableArray* tmp = [NSMutableArray array];
   
    
   scView.contentSize = CGSizeMake((self.imgNameArr.count + ((adCount>1)?addBeyond*2:0)) * mainWidth, self.bounds.size.height);
    for (int i = 0; i < self.imgNameArr.count+ ((adCount>1)?addBeyond*2:0); i++)
    {
        NSString* name = nil;
        if (adCount == 1)
        {
            name = [self.imgNameArr objectAtIndex:i];
        }
        else
        {
            if(i<addBeyond)
            {
                name = [self.imgNameArr objectAtIndex:self.imgNameArr.count+i-addBeyond];
            }
            else if(i>=self.imgNameArr.count+addBeyond)
            {
                name = [self.imgNameArr objectAtIndex:i-self.imgNameArr.count-addBeyond];
            }
            else name = [self.imgNameArr objectAtIndex:i-addBeyond];
        }
        [tmp addObject:name];
        UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(i * mainWidth, 0, mainWidth, self.bounds.size.height)];
        img.userInteractionEnabled = YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Actiondo)];
        [img addGestureRecognizer:tap];

        
       
        img.image = [UIImage imageNamed:name];
        [img sd_setImageWithURL:[NSURL URLWithString:name] placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
        [scView addSubview:img];
    }
    scView.contentOffset = CGPointMake(((adCount>1)?mainWidth*addBeyond:0), 0);
    
    if(!pcView)
    {
        pcView = [UIPageControl new];
        pcView.userInteractionEnabled = NO;
        pcView.currentPage = 0;
        pcView.pageIndicatorTintColor = [UIColor whiteColor];
        pcView.currentPageIndicatorTintColor = [UIColor redColor];
        
    }
    [self addSubview:pcView];
    [pcView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self);
        make.height.equalTo(@30);
        make.centerX.equalTo(self);
//        make.width.equalTo(@110);
    }];
    
    pcView.numberOfPages = self.imgNameArr.count;
    
    if (_autoInterval == 0)
        _autoInterval = defaultInterval;
    if (autoTimer)
    {
        [autoTimer invalidate];
        autoTimer = nil;
    }
    if(adCount > 1)
    {
        autoTimer = [NSTimer scheduledTimerWithTimeInterval:_autoInterval target:self selector:@selector(handleScrollTimer) userInfo:nil repeats:YES];
        //[[NSRunLoop currentRunLoop] addTimer:autoTimer forMode:NSRunLoopCommonModes];
    }
}

#pragma mark - auto scroll timer
- (void)handleScrollTimer
{
    CGFloat x = scView.contentOffset.x;
    int page = x / mainWidth;
    if ((x - page * mainWidth) > mainWidth / 2)
        page++;
    int next = page+1;
    [scView scrollRectToVisible:CGRectMake(next * mainWidth, 0, mainWidth, self.bounds.size.height) animated:YES];
    [self setAdViews:next bFromTimer:YES];
    
}

#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    int page = x / mainWidth;
    if ((x - page * mainWidth) > mainWidth / 2)
        page++;

    [self setAdViews:page bFromTimer:NO];
}

- (void)setAdViews:(int)page bFromTimer:(BOOL)bFromTimer
{
    if(page>=adCount+addBeyond)
    {
        if(!bFromTimer)
            scView.contentOffset = CGPointMake(mainWidth*addBeyond, 0);
        else
            [self performSelector:@selector(setConttentOffset:) withObject:[NSNumber numberWithFloat:mainWidth*addBeyond] afterDelay:0.5];
        page = 0;
    }
    else if(page < addBeyond)
    {
        scView.contentOffset = CGPointMake(mainWidth*(adCount+addBeyond-1), 0);
        page = adCount+addBeyond;
    }
    pcView.currentPage = page - addBeyond;
    [pcView updateCurrentPageDisplay];
    
    if (autoTimer)
    {
        [autoTimer invalidate];
        autoTimer = nil;
    }
    if(adCount > 1)
    {
        autoTimer = [NSTimer scheduledTimerWithTimeInterval:_autoInterval target:self selector:@selector(handleScrollTimer) userInfo:nil repeats:YES];
    }
}

- (void)setConttentOffset:(NSNumber*)x
{
    scView.contentOffset = CGPointMake([x floatValue], 0);
}

- (void)Actiondo
{
    if(delegate)
    {
        [delegate click:(int)pcView.currentPage];
    }
}
@end
