//
//  ViewController.m
//
//  Created by Ingo Böhme on 01.06.14.
//  Copyright (c) 2014 IBMobile. All rights reserved.
//

#import "ViewController.h"
#import "IBCircularProgressButton.h"

@interface ViewController ()
@property (nonatomic, strong)  IBCircularProgressButton *ibProgressView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
	UIImage *icon = [UIImage imageNamed:@"icon"];
    
	_ibProgressView = [[IBCircularProgressButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	_ibProgressView.borderWidth = 1;
	_ibProgressView.buttonBorderWidth = 1;
    
    
	_ibProgressView.wrapperArcWidth = 5;
	_ibProgressView.progressArcWidth = 10;
	_ibProgressView.spaceWidth = 3;
	//
	//
	//
	//
	_ibProgressView.borderColor = [UIColor colorWithRed:90 / 255.0 green:80 / 255.0 blue:35 / 255.0 alpha:1];
	_ibProgressView.buttonBorderColor = _ibProgressView.borderColor;
	_ibProgressView.progressColor = [UIColor colorWithRed:229 / 255.0 green:199 / 255.0 blue:85 / 255.0 alpha:1];
	_ibProgressView.wrapperColor =  _ibProgressView.progressColor;
	_ibProgressView.backgroundColor = [UIColor whiteColor];
    
	_ibProgressView.image = icon;
    
	_ibProgressView.enableButton = YES;
	_ibProgressView.resizeImageToFit = YES;
    
	[self.view addSubview:_ibProgressView];
	_ibProgressView.center = self.view.center;
	[_ibProgressView setProgress:0.22 animated:YES];
    
	[_ibProgressView addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    
    
	//	[_ibProgressView addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated {
	[_ibProgressView setNeedsDisplay];
}

- (void)click {
	[_ibProgressView setProgress:((float)arc4random() / (float)RAND_MAX * 1.0) animated:YES];
	NSLog(@"Prog: %2.5f", _ibProgressView.progress);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
