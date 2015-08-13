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

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.needle.transform = CGAffineTransformRotate(self.needle.transform, M_PI/ 180 * -225);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)panViewGesture:(UIPanGestureRecognizer *)recognizer {
   CGPoint velocityPoint = [recognizer velocityInView:self.view];
    float velocity = sqrt( ( pow(velocityPoint.x, 2) + pow(velocityPoint.y,2) ) );
    float velocityPercent = velocity/1000;
    if (velocityPercent > 1) {
        velocityPercent = 1;
    }
    
    self.printSpeed.text = [NSString stringWithFormat:@"%f",velocityPercent];
    
    NSLog(@"%f", velocity);
    
    [UIView animateWithDuration:0.2 animations:^{
    self.needle.transform = CGAffineTransformMakeRotation(M_PI/180 * (velocityPercent *270) -225);
    
        if (recognizer.state == UIGestureRecognizerStateEnded ) {
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(cancelTimer:) userInfo:nil repeats:NO];
        }
    
    
    
    }];
    
    
}

-(void)cancelTimer:(NSTimer *)timer {
    [UIView animateWithDuration:1.5 animations:^{
        self.needle.transform = CGAffineTransformMakeRotation(M_PI/180 * -225);
    
    }];
}

@end
