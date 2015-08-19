//
//  ViewController.m
//  FastestRPM
//
//  Created by Yazan Khayyat on 2015-08-13.
//  Copyright (c) 2015 Yazan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *speedMeter;
@property (weak, nonatomic) IBOutlet UIImageView *needle;
@property (weak, nonatomic) IBOutlet UILabel *printSpeed;

@end

CGFloat min = M_PI - M_PI_4; // ~2.355
CGFloat max = M_PI_4; // ~0.785

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 0..2π (6.28)
    //
//    self.needle.transform = CGAffineTransformRotate(self.needle.transform, M_PI/ 180 * -225);
    [self resetNeedle];
}

- (void) resetNeedle;
{
    // !!!: set the transform to identity and use CGAffineTransformRotate, or use CGAffineTransformMakeRotation()
    self.needle.transform = CGAffineTransformMakeRotation(min);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)panViewGesture:(UIPanGestureRecognizer *)recognizer {
    
//    return;
    
   CGPoint velocityPoint = [recognizer velocityInView:self.view];
    float velocity = sqrt( ( pow(velocityPoint.x, 2) + pow(velocityPoint.y,2) ) );
    
    float velocityPercent = velocity/1000;
    if (velocityPercent > 1.0) {
        velocityPercent = 1.0;
    }
    
    // clamp
    velocityPercent = MIN(velocityPercent, 1.0);
    velocityPercent = MAX(velocityPercent, 0.0);
    
    self.printSpeed.text = [NSString stringWithFormat:@"%f",velocityPercent];
    
    NSLog(@"%f", velocity);
    
//    CGFloat angle = min + ((max - min) * velocityPercent);
    CGFloat angle = min + ((max + min) * velocityPercent);
    
    [UIView animateWithDuration:0.2 animations:^{
//        self.needle.transform = CGAffineTransformMakeRotation(M_PI/180 * (velocityPercent *270) -225);
        self.needle.transform = CGAffineTransformMakeRotation(angle);
    
        if (recognizer.state == UIGestureRecognizerStateEnded ) {
            
            [self.needle.layer removeAllAnimations];
            
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(cancelTimer:) userInfo:nil repeats:NO];
        }
    
    
    
    }];
    
    
}

-(void)cancelTimer:(NSTimer *)timer {
    [UIView animateWithDuration:1.5 animations:^{
//        self.needle.transform = CGAffineTransformMakeRotation(M_PI/180 * -225);
 
        [self resetNeedle];
    }];
}

@end
