//
//  ViewController.m
//
//  Created by Ingo Böhme on 01.06.14.
//  Copyright (c) 2014 IBMobile. All rights reserved.
//

#import "ViewController.h"
#import "IBCircularProgressButton.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet IBCircularProgressButton *secondButton;

@property (nonatomic, strong)  IBCircularProgressButton *ibProgressView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
	UIImage *icon = [UIImage imageNamed:@"icon"];
    
	_ibProgressView = [[IBCircularProgressButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	_ibProgressView.borderWidth = 1;
	_ibProgressView.buttonBorderWidth = 1;
    
    
	_ibProgressView.wrapperArcWidth = 2;
	_ibProgressView.progressArcWidth = 10;
	_ibProgressView.spaceWidth = 3;
	//
	//
	//
	//
	_ibProgressView.borderColor = [UIColor colorWithRed:228 / 255.0 green:198 / 255.0 blue:85 / 255.0 alpha:1];
	_ibProgressView.buttonBorderColor = _ibProgressView.borderColor;
	_ibProgressView.progressColor = [UIColor colorWithRed:229 / 255.0 green:199 / 255.0 blue:85 / 255.0 alpha:1];
	_ibProgressView.wrapperColor =  [UIColor colorWithRed:128 / 255.0 green:111 / 255.0 blue:48 / 255.0 alpha:1];
	_ibProgressView.backgroundColor = [UIColor whiteColor];
    
	_ibProgressView.image = icon;
    
	_ibProgressView.enableButton = YES;
	_ibProgressView.resizeImageToFit = YES;
    
	[self.view addSubview:_ibProgressView];
	_ibProgressView.center = self.view.center;
	[_ibProgressView setProgress:0.22 animated:YES];
    
	[_ibProgressView addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
	// Now the one built in the IB
    
	[_secondButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
	[_secondButton setImage:[UIImage imageNamed:@"icon2"]];
	[_secondButton setTintColor:[UIColor colorWithRed:114.0 / 255.0 green:177.0 / 255.0 blue:156.0 / 255.0 alpha:1.0]];
	_secondButton.buttonPressOffset = CGSizeMake(18, 5);
}

- (void)viewDidAppear:(BOOL)animated {
	[_ibProgressView setNeedsDisplay];
}

- (void)click:(id)sender {
	[(IBCircularProgressButton *)sender setProgress : ((float)arc4random() / (float)RAND_MAX * 1.0)animated : YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
