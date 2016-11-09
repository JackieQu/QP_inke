//
//  QPPlayerViewController.m
//  QP_inke
//
//  Created by 曲鹏 on 2016/11/9.
//  Copyright © 2016年 JackieQu. All rights reserved.
//

#import "QPPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "QPChatViewController.h"

@interface QPPlayerViewController ()

@property (atomic, retain) id<IJKMediaPlayback> player;

@property (nonatomic, strong) UIButton * closeBtn;

@property (nonatomic ,strong) UIImageView * blurImageView;

@property (nonatomic, strong) QPChatViewController * chatVC;

@end

@implementation QPPlayerViewController

- (QPChatViewController *)chatVC {
    
    if (!_chatVC) {
        _chatVC = [[QPChatViewController alloc] init];
    }
    return _chatVC;
}

- (UIButton *)closeBtn {
    
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        [_closeBtn sizeToFit];
        _closeBtn.frame = CGRectMake(SCREEN_WIDTH - _closeBtn.width - 10, SCREEN_HEIGHT - _closeBtn.height - 10, _closeBtn.width, _closeBtn.height);
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
    
}

- (void)closeAction:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    //注册直播需要的通知
    [self installMovieNotificationObservers];
    
    //准备播放
    [self.player prepareToPlay];
    
    UIWindow * w = [[UIApplication sharedApplication].delegate window];
    [w addSubview:self.closeBtn];
}

- (void)viewWillDisappear:(BOOL)animated {  //Did
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    //关闭直播
    [self.player shutdown];
    
    [self removeMovieNotificationObservers];
    
    [self.closeBtn removeFromSuperview];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBarHidden = YES;
    
    [self initPlayer];
    
    [self initUI];

    [self addChildVC];

}

- (void)addChildVC {
    
    [self addChildViewController:self.chatVC];
    
    [self.view addSubview:self.chatVC.view];
    
    [self.chatVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];
    
    self.chatVC.live = self.live;
    
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.blurImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.blurImageView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,self.live.creator.portrait] placeholder:@"default_room"];
    [self.view addSubview:self.blurImageView];
    
    //创建毛玻璃效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //创建毛玻璃视图
    UIVisualEffectView * ve = [[UIVisualEffectView alloc] initWithEffect:blur];
    ve.frame = self.blurImageView.bounds;
    //毛玻璃视图加入图片view上
    [self.blurImageView addSubview:ve];

}

- (void)initPlayer {
    
    IJKFFOptions * options = [IJKFFOptions optionsByDefault];
    
    IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.live.streamAddr withOptions:options];
    self.player = player;
    self.player.view.frame = self.view.bounds;
    self.player.shouldAutoplay = YES;
    [self.view addSubview:self.player.view];
}

- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,
    //    MPMovieLoadStatePlayable       = 1 << 0,
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,
    //    MPMovieFinishReasonPlaybackError,
    //    MPMovieFinishReasonUserExited
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
    
    self.blurImageView.hidden = YES;
    [self.blurImageView removeFromSuperview];
}

#pragma mark Install Movie Notifications

/* Register observers for the various movie object notifications. */
-(void)installMovieNotificationObservers
{
    //监听网络环境，监听缓冲进度
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    
    //监听直播完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    //监听用户操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

#pragma mark Remove Movie Notification Handlers

/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}

@end
