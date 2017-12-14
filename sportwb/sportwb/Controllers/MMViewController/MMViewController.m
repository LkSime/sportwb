//
//  MMViewController.m
//
//

#import "MMViewController.h"
//#import "BaiduMobStat.h"
//#import "UMMobClick/MobClick.h"
#import "AppDelegate.h"
#import "PublicFunction.h"

#define MMNavigationRightBtnMaxWidth    70

@implementation MMNavigationBarButtonItem

- (id)initWithItemType:(MMNavigationBarItemType)itemType 
                target:(id)target
        actionSelector:(SEL)actionSel 
           normalImage:(UIImage *)norImage 
        highLightImage:(UIImage *)hgImage
                 title:(NSString *)title
{
    CGRect rect = CGRectMake(0, 0, 41, 25);
    if(title)
    {
        UIFont* font = [UIFont systemFontOfSize:15.f];
        CGSize size = [title sizeWithFont:font];
        if(size.width > CGRectGetWidth(rect))
        {
            if(size.width > MMNavigationRightBtnMaxWidth)
            {
                size.width = MMNavigationRightBtnMaxWidth;
            }
            rect = CGRectMake(0, 0, size.width + 10, 25);
        }
    }
    self = [super initWithFrame:rect];
    if(self)
    {
        if(title)
        {
            [self setTitleColor:ColorFromHex(0x4d4d4d) forState:UIControlStateNormal];
            [self setBackgroundImage:[norImage stretchableImageWithLeftCapWidth:27 topCapHeight:12] forState:UIControlStateNormal];
            [self setBackgroundImage:[hgImage stretchableImageWithLeftCapWidth:27 topCapHeight:12] forState:UIControlStateHighlighted];
        }
        else 
        {
            [self setImage:norImage forState:UIControlStateNormal];
            [self setImage:hgImage forState:UIControlStateHighlighted];
        }
        
        if(target)
        {
            [self addTarget:target action:actionSel forControlEvents:UIControlEventTouchUpInside];
        }
        
        if(title)
        {
            _titleLable = [[UILabel alloc] initWithFrame:self.bounds];
            _titleLable.backgroundColor = [UIColor clearColor];
            _titleLable.textColor = [UIColor blackColor];
            _titleLable.font = [UIFont systemFontOfSize:15.f];
            _titleLable.textAlignment = NSTextAlignmentCenter;
            _titleLable.text = title;
            
            [self addSubview:_titleLable];
        }
        
        
        self.clipsToBounds = NO;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setTitle:(NSString*)title
{
    _titleLable.text = title;
}

@end

@implementation MMNavigationBar

@synthesize leftBarItem = _leftBarItem;
@synthesize rightBarItem = _rightBarItem;

- (id)initWithFrame:(CGRect)frame backGroundImage:(UIImage*)bgImage
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundView.image = bgImage;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 22)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = FONT_FOR_TEXT_18;
        _titleLabel.textColor = COLOR_FOR_TEXT_4D;
        
        
        self.navLineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
        self.navLineView.backgroundColor = COLOR_FOR_TEXT_E6;
        
        [self addSubview:_backgroundView];
        [self addSubview:_titleLabel];
        [self addSubview:self.navLineView];
    }
    return self;
}

- (void)setTitle:(NSString*)title
{
    _titleLabel.text = title;
//    [_titleLabel sizeToFit];
    _titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + 1 + 10);
//    _titleLabel.
}

- (void)setTitle:(NSString *)title withFont:(UIFont*)font withColor:(UIColor*)color
{
    _titleLabel.text = title;
    _titleLabel.textColor = color;
    _titleLabel.font = font;
    [_titleLabel sizeToFit];
    _titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + 1 + 10);
}

- (NSString*)title
{
    return _titleLabel.text;
}

- (void)setLeftBarItem:(MMNavigationBarButtonItem *)leftBarItem {
    if(_leftBarItem)
    {
        [_leftBarItem removeFromSuperview];
        _leftBarItem = nil;
    }
    
    _leftBarItem = leftBarItem;
    CGRect frame = _leftBarItem.frame;
    _leftBarItem.frame = frame;
    
    [self addSubview:_leftBarItem];
}

- (void)setRightBarItem:(MMNavigationBarButtonItem *)rightBarItem
{
    if(_rightBarItem)
    {
        [_rightBarItem removeFromSuperview];
        _rightBarItem = nil;
    }
    
    _rightBarItem = rightBarItem;
    CGRect frame = _rightBarItem.frame;
    frame.origin.x = self.frame.size.width - frame.size.width - 6;
    frame.origin.y = _titleLabel.frame.origin.y + (_titleLabel.frame.size.height - rightBarItem.frame.size.height) / 2;
    _rightBarItem.frame = frame;
    
    [self addSubview:_rightBarItem];
}

@end



@interface MMViewController () <UIGestureRecognizerDelegate>

- (void)initContentView;

@end

@implementation MMViewController
@synthesize mmNavigationBar = _mmNavigationBar;
@synthesize mmContentView = _mmContentView;
@synthesize mmContentBounds = _mmContentBounds;

- (id)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

- (BOOL)isNeedNavigationBar
{
    return YES;
}

-(BOOL)isNeedSwipeBack{
    return YES;
}

-(BOOL)isPresentedViewController{
    return NO;
}

- (BOOL)isNeedLeftBarItem
{
    return YES;
}

- (void)createNavigationBar
{
    if ([self isNeedNavigationBar]) {
        UIImage* navigationBarBgImage = [UIImage imageNamed:@"navbar_bg"];
        UIInterfaceOrientation intOrt = [[UIApplication sharedApplication] statusBarOrientation];
        
        if (UIInterfaceOrientationLandscapeLeft == intOrt || UIInterfaceOrientationLandscapeRight == intOrt) {
            _mmNavigationBar = [[MMNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 64 ) backGroundImage:navigationBarBgImage];
        }
        else {
            _mmNavigationBar = [[MMNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64 ) backGroundImage:navigationBarBgImage];
        }
        _mmNavigationBar.backgroundColor = [UIColor whiteColor];
        UIViewController* rootViewController = nil;
        NSArray* contorllers = self.navigationController.viewControllers;
        if([contorllers count] > 0){
            rootViewController = [contorllers objectAtIndex:0];
        }
        
        UIImage*   backImage = [UIImage imageNamed:@"Nav_BackBtnNormal.png"];
        UIImage*  backImageHl = [UIImage imageNamed:@"Nav_BackBtnSel.png"];
        
        if([self isNeedLeftBarItem] /*&& self != rootViewController*/)
        {
            _mmNavigationBar.leftBarItem = [[MMNavigationBarButtonItem alloc] initWithItemType:MMNavigationBarItemTypeBack 
                                                                                        target:self 
                                                                                actionSelector:@selector(leftNavigationBarItemAction:)
                                                                                   normalImage:backImage 
                                                                                highLightImage:backImageHl 
                                                                                         title:nil];
            _mmNavigationBar.leftBarItem.frame = CGRectMake(5, 22, 40, 40);
        }
        
        [self.view addSubview:_mmNavigationBar];
    }
    else {
        
    }
}

- (void)initContentView
{
    UIInterfaceOrientation intOrt = [[UIApplication sharedApplication] statusBarOrientation];
    
    _mmContentBounds = RectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    if (UIInterfaceOrientationLandscapeLeft == intOrt || UIInterfaceOrientationLandscapeRight == intOrt) {
        CGFloat fWidth = _mmContentBounds.size.width;
        CGFloat fHeight = _mmContentBounds.size.height;
        _mmContentBounds.size.height = fWidth;
        _mmContentBounds.size.width = fHeight;
    }
    
    CGFloat contentOrigY = 0;
    if(_mmNavigationBar) {
        _mmContentBounds.size.height -= _mmNavigationBar.frame.size.height;
        contentOrigY = _mmNavigationBar.frame.size.height;
    }
    else {

    }
    
    _mmContentView = [[UIView alloc] init];
    if (UIInterfaceOrientationLandscapeLeft == intOrt || UIInterfaceOrientationLandscapeRight == intOrt) {
        _mmContentView.frame = CGRectMake(0, contentOrigY, self.view.frame.size.height, CGRectGetHeight(_mmContentBounds));
    }
    else {
        _mmContentView.frame = CGRectMake(0, contentOrigY, self.view.frame.size.width, CGRectGetHeight(_mmContentBounds));
    }
    _mmContentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mmContentView];
  
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    [self.mmNavigationBar setTitle:title];
}

- (void)setNavBarButtonItem:(NSString *)title
                  title2or4:(NSInteger)tag
                leftorright:(MMNavigationBarItemType)dir
                     target:(id)target
                 turnAction:(SEL)action;
{
    UIButton *barBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (tag == 2)barBtn.frame = CGRectMake(0,0, 42, 30);
    if (tag == 4)barBtn.frame = CGRectMake(0,0, 60, 30);
    [barBtn setTitleColor:COLOR_FOR_TEXT_80 forState:UIControlStateNormal];
    [barBtn setTitleColor:COLOR_FOR_TEXT_80 forState:UIControlStateHighlighted];
    barBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
    [barBtn setBackgroundImage:[UIImage imageNamed:@"Nav_ButtonBgNormal.png"] forState:UIControlStateNormal];
    [barBtn setBackgroundImage:[UIImage
                                imageNamed:@"Nav_ButtonBgSel.png"] forState:UIControlStateHighlighted];
    [barBtn setTitle:title forState:UIControlStateNormal];
    [barBtn setTitle:title forState:UIControlStateHighlighted];
    if (target)[barBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (dir == MMNavigationBarItemRight){
        UIImage *imgRight;
        UIImage *imgRightHl;
        if (imgRight && imgRightHl) {
            [barBtn setBackgroundImage:imgRight forState:UIControlStateNormal];
            [barBtn setBackgroundImage:imgRightHl forState:UIControlStateHighlighted];
            barBtn.frame = CGRectMake(0, 0, imgRight.size.width, imgRight.size.height);
        }
        barBtn.center = CGPointMake(SCREEN_WIDTH - barBtn.center.x - 8, self.mmNavigationBar.frame.size.height - 22);
        self.mmNavigationBar.rightBarItem = (MMNavigationBarButtonItem*)barBtn;
    }else if(dir == MMNavigationBarItemLeft){
        barBtn.center = CGPointMake(barBtn.center.x + 8, self.mmNavigationBar.frame.size.height - 22);
        self.mmNavigationBar.leftBarItem = (MMNavigationBarButtonItem*)barBtn;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_FOR_WHITE;
    [self createNavigationBar];
    [self initContentView];
    
    if ([self isNeedNavigationBar]) {
        [self.view bringSubviewToFront:_mmNavigationBar];
    }
    // 处理点击空白处隐藏键盘
    {
        UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(doHideKeyBoard)];
        singleTapRecognizer.delegate = self;
        singleTapRecognizer.numberOfTapsRequired = 1;
        singleTapRecognizer.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:singleTapRecognizer];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //滑动返回
    if (![self isPresentedViewController]) {
        AppDelegate *aDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        aDelegate.navRoot.interactivePopGestureRecognizer.enabled = YES;
        if([aDelegate.navRoot respondsToSelector:@selector(interactivePopGestureRecognizer)]){
            aDelegate.navRoot.interactivePopGestureRecognizer.delegate = self;
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *cName = [NSString stringWithFormat:@"%@",self.class];
    
    //禁止滑动返回
    if (![self isPresentedViewController]) {
        AppDelegate *aDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        if (![self isNeedSwipeBack]) {
            aDelegate.navRoot.interactivePopGestureRecognizer.enabled = NO;
            if([aDelegate.navRoot respondsToSelector:@selector(interactivePopGestureRecognizer)]){
                aDelegate.navRoot.interactivePopGestureRecognizer.delegate = nil;
            }
        }else{
            aDelegate.navRoot.interactivePopGestureRecognizer.enabled = YES;
            if([aDelegate.navRoot respondsToSelector:@selector(interactivePopGestureRecognizer)]){
                aDelegate.navRoot.interactivePopGestureRecognizer.delegate = self;
            }
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSString *cName = [NSString stringWithFormat:@"%@",self.class];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    _mmNavigationBar = nil;
    _mmContentView = nil;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)leftNavigationBarItemAction:(id)sender
{
    [PublicFunction popVC:self];
}

- (void)doHideKeyBoardForView:(UIView*)view
{
    if ([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]) {
        [view resignFirstResponder];
    }
    
    NSArray *subViews = [view subviews];
    for (UIView *oneV in subViews) {
        [self doHideKeyBoardForView:oneV];
    }
}

- (void)doHideKeyBoard
{
    
}

#pragma mark--UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }else if([touch.view isKindOfClass:[UITextField class]] || [touch.view isKindOfClass:[UITextView class]]){
        return NO;
    }
    
    NSArray *subViews = [self.view subviews];
    for (UIView *oneV in subViews) {
        [self doHideKeyBoardForView:oneV];
    }
    
    return YES;
}

@end
