//
//  QPMainViewController.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/8.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPMainViewController.h"
#import "QPMainTopView.h"

@interface QPMainViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *contenScrollView;

@property (nonatomic, strong) NSArray * datalist;

@property (nonatomic, strong) QPMainTopView * topView;

@end

@implementation QPMainViewController

- (QPMainTopView *)topView {
    
    if (!_topView) {
        _topView = [[QPMainTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.datalist];
        
        @weakify(self);
        _topView.block = ^(NSInteger tag) {
            @strongify(self);
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contenScrollView.contentOffset.y);
            [self.contenScrollView setContentOffset:point animated:YES];
            
        };
    }
    return _topView;
    
}

- (NSArray *)datalist {
    
    if (!_datalist) {
        _datalist = @[@"关注",@"热门",@"附近"];
    }
    return _datalist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}

- (void)initUI {
    
    //添加左右按钮
    [self setupNav];
    
    //添加子视图控制器
    [self setupChildViewControllers];
    
}

- (void)setupChildViewControllers {
    
    NSArray * vcNames = @[@"QPFocusViewController",@"QPHotViewController",@"QPNearViewController"];
    
    for (NSInteger i = 0; i < vcNames.count; i ++) {
        
        NSString * vcName = vcNames[i];
        
        UIViewController * vc = [[NSClassFromString(vcName) alloc] init];
        vc.title = self.datalist[i];
        //执行 addChildViewController 时，不会执行 viewdidload
        [self addChildViewController:vc];
    }
    
    //将子控制器的 view 加到 mainVC 的 scrollview 上
    
    
    //设置 scrollview 的 contentsize
    self.contenScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.datalist.count, 0);
    
    //默认先展示第二个页面
    self.contenScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    //进入主控制器加载第一个页面
    [self scrollViewDidEndScrollingAnimation:self.contenScrollView];
    
}

- (void)setupNav {
    
    self.navigationItem.titleView = self.topView;
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
}

//动画结束调用代理
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width  = SCREEN_WIDTH;//scrollView.frame.size.width;
    CGFloat height = SCREEN_HEIGHT;
    
    CGFloat offset = scrollView.contentOffset.x;
    //获取索引值
    NSInteger idx = offset / width;
    
    //索引值联动 topview
    [self.topView scrolling:idx];
    
    //根据索引值返回 vc 的引用
    UIViewController * vc = self.childViewControllers[idx];
    
    //判断当前 vc 是否执行过 viewDidLoad
    if ([vc isViewLoaded]) return;
    
    //设置子控制器 view 的大小
    vc.view.frame = CGRectMake(offset, 0, width, height);
    
    //将子控制器的 view 加入 scrollview 上
    [scrollView addSubview:vc.view];
    
}


//减速结束时调用加载子控制器 view 的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

@end
