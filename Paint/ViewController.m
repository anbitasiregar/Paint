//
//  ViewController.m
//  Paint
//
//  Created by Anbita Siregar on 6/16/15.
//  Copyright (c) 2015 Anbita Siregar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *blackColorButton;
@property (weak, nonatomic) IBOutlet UIButton *greyColorButton;
@property (weak, nonatomic) IBOutlet UIButton *redColorButton;
@property (weak, nonatomic) IBOutlet UIButton *blueColorButton;
@property (weak, nonatomic) IBOutlet UIButton *darkGreenColorButton;
@property (weak, nonatomic) IBOutlet UIButton *lightBlueColorButton;
@property (weak, nonatomic) IBOutlet UIButton *brownColorButton;
@property (weak, nonatomic) IBOutlet UIButton *orangeColorButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowColorButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) UIButton *currentButton;
@property (weak, nonatomic) IBOutlet UISlider *brushSizeSlider;
@property (weak, nonatomic) IBOutlet UILabel *brushSizeValueLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.red = 0.0/255;
    self.green = 0.0/255;
    self.blue = 0.0/255;
    self.brush = 5.0;
    [self.imageView.layer setBorderWidth:5.0];
    [self.imageView.layer setBorderColor:[[UIColor grayColor] CGColor]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.blackColorButton.layer.cornerRadius = self.blackColorButton.frame.size.width / 2;
    self.greyColorButton.layer.cornerRadius = self.greyColorButton.frame.size.width / 2;
    self.redColorButton.layer.cornerRadius = self.redColorButton.frame.size.width / 2;
    self.blueColorButton.layer.cornerRadius = self.blueColorButton.frame.size.width / 2;
    self.darkGreenColorButton.layer.cornerRadius = self.darkGreenColorButton.frame.size.width / 2;
    self.lightBlueColorButton.layer.cornerRadius = self.lightBlueColorButton.frame.size.width / 2;
    self.brownColorButton.layer.cornerRadius = self.brownColorButton.frame.size.width / 2;
    self.orangeColorButton.layer.cornerRadius = self.orangeColorButton.frame.size.width / 2;
    self.yellowColorButton.layer.cornerRadius = self.yellowColorButton.frame.size.width / 2;
}

#pragma mark - Drawing Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    self.mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.imageView.frame.size);
    [self.imageView.image drawInRect:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!self.mouseSwiped) {
        UIGraphicsBeginImageContext(self.imageView.frame.size);
        [self.imageView.image drawInRect:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.imageView.frame.size);
    [self.imageView.image drawInRect:CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

#pragma mark - UIButton delegates

- (IBAction)resetButtonPressed:(UIButton *)sender {
    self.imageView.image = nil;
}


- (IBAction)colorPressed:(UIButton *)sender {
    [self.currentButton.layer setBorderWidth:0.0];
    self.currentButton = sender;
    [self.currentButton.layer setBorderWidth:2.0];
    [self.currentButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    switch(sender.tag) {
        case 0:
            self.red = 0.0/255;
            self.green = 0.0/255;
            self.blue = 0.0/255;
            break;
        case 1:
            self.red = 105.0/255;
            self.green = 105.0/255;
            self.blue = 105.0/255;
            break;
        case 2:
            self.red = 255.0/255;
            self.green = 0.0/255;
            self.blue = 0.0/255;
            break;
        case 3:
            self.red = 0.0/255;
            self.green = 0.0/255;
            self.blue = 255.0/255;
            break;
        case 4:
            self.red = 102.0/255;
            self.green = 204.0/255;
            self.blue = 0.0/255;
            break;
        case 5:
            self.red = 51.0/255;
            self.green = 204.0/255;
            self.blue = 255.0/255;
            break;
        case 6:
            self.red = 160.0/255;
            self.green = 82.0/255;
            self.blue = 45.0/255;
            break;
        case 7:
            self.red = 255.0/255;
            self.green = 102.0/255;
            self.blue = 0.0/255;
            break;
        case 8:
            self.red = 255.0/255;
            self.green = 255.0/255;
            self.blue = 0.0/255;
            break;
        case 9:
            self.red = 255.0/255;
            self.green = 255.0/255;
            self.blue = 255.0/255;
    }
}

#pragma mark - UISlider delegates

- (IBAction)sliderChanged:(UISlider *)sender {
    self.brush = self.brushSizeSlider.value;
    self.brushSizeValueLabel.text = [NSString stringWithFormat:@"%d", (int)rintf(self.brush)];
}


@end
