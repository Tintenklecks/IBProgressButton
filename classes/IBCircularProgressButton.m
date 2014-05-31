//
//  MRCircularProgressView.m
//  MRCircularProgressView
//
//  Created by Jose Luis Martinez de la Riva on 30/01/14.
//  Modified and enhanced to be a button by Ingo Böhme 2014-05-30
//
//  Copyright (c) 2014 http://martinezdelariva.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE
//

#import "IBCircularProgressButton.h"

@interface IBCircularProgressButton ()
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (assign, nonatomic) CGFloat currentProgress;
@property (assign, nonatomic) CGFloat lastProgress;
@property (assign, nonatomic) BOOL animated;
@property (assign, nonatomic) CFTimeInterval duration;

@property (nonatomic, strong) id target;
@property (nonatomic) SEL selector;
@property (nonatomic) UIControlEvents controlEvent;



@end

@implementation IBCircularProgressButton

- (CGRect)adjustFrame:(CGRect)frame {
	float diffX = 0, diffY = 0;
	if (frame.size.width > frame.size.height) {
		diffX = frame.size.width - frame.size.height;
	}
	else {
		diffY = frame.size.height - frame.size.width;
	}
	frame.origin.x += diffX / 2;
	frame.origin.y += diffY / 2;
	frame.size.width -= diffX;
	frame.size.height -= diffY;
	return frame;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		NSLog(@"frame %@", NSStringFromCGRect(self.frame));
		[self setUp];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:[self adjustFrame:frame]];
    
	NSLog(@"frame %@", NSStringFromCGRect(self.frame));
	if (self) {
		[self setUp];
	}
	return self;
}

- (void)setUp {
	// Init variables
	_imageView = [[UIImageView alloc] init];
	_imageView.backgroundColor = self.tintColor;
	_imageView.clipsToBounds = YES;
	_imageView.userInteractionEnabled = NO;
    
	_buttonPressOffset = CGSizeMake(2, 1);
    
	NSLog(@"frame %@", NSStringFromCGRect(self.frame));
    
	self.frame = [self adjustFrame:self.frame];
    
	NSLog(@"frame %@", NSStringFromCGRect(self.frame));
    
    
	self.delegate = nil;
	self.clipsToBounds = YES;
    
    
	self.currentProgress = 0.0f;
	self.lastProgress = 0.0f;
	self.duration = 0.5;
	self.animated = YES;
    
    
	// Colors
	self.progressColor = self.tintColor;
	self.wrapperColor = self.tintColor;
	self.backgroundColor = [UIColor whiteColor];
	self.buttonBorderColor = [UIColor grayColor];
	self.borderColor = [UIColor darkGrayColor];
    
    
    
    
	// Control size
    
    
    
	self.borderWidth = 1;
	self.buttonBorderWidth = 0;
    
	self.wrapperArcWidth = 2.f;
	self.progressArcWidth = self.frame.size.width / 10;
	self.spaceWidth = 2.f;
    
    
	self.enableButton = YES;
    
	[self addSubview:_imageView];
	[self setNeedsLayout];
	[self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	self.alpha = 0.5;
	self.center = CGPointMake(self.center.x + _buttonPressOffset.width, self.center.y + _buttonPressOffset.height);
	NSLog(@"DOWN");
	if (_controlEvent == UIControlEventTouchDown) {
		[self execSelector];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in touches) {
		CGPoint touchPoint = [touch locationInView:self];
		if ([self pointInside:touchPoint withEvent:nil]) {
			self.alpha = 0.5;
		}
		else {
			self.alpha = 0.8;
		}
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in touches) {
		CGPoint touchPoint = [touch locationInView:self];
		if ([self pointInside:touchPoint withEvent:nil]) {
			NSLog(@"Click");
			if (_controlEvent == UIControlEventTouchUpInside) {
				[self execSelector];
			}
		}
		else {
			NSLog(@"Cancel");
			if (_controlEvent == UIControlEventTouchUpOutside) {
				[self execSelector];
			}
		}
		self.alpha = 1.0;
	}
	self.center = CGPointMake(self.center.x - _buttonPressOffset.width, self.center.y - _buttonPressOffset.height);
}

- (void)addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)controlEvent {
	_target = target;
	_selector = selector;
	_controlEvent = controlEvent;
}

- (void)execSelector {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
	[_target performSelector:_selector withObject:self];
#pragma clang diagnostic pop
}

- (void)drawRect:(CGRect)rect {
	// Outer circle
    
    
	CGFloat buttonWidth = MIN(self.bounds.size.width, self.bounds.size.height);
	// buttonWidth -= 2 * _wrapperArcWidth;
	buttonWidth -= 2 * _progressArcWidth;
	buttonWidth -= 2 * _borderWidth;
	buttonWidth -= 2 * _spaceWidth;
    
	buttonWidth -= 2 * _imageView.layer.borderWidth;
    
	_imageView.bounds = CGRectMake(0, 0, buttonWidth, buttonWidth);
	_imageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
	_imageView.layer.cornerRadius = buttonWidth / 2;
    
	_imageView.layer.borderColor = _buttonBorderColor.CGColor;
	_imageView.layer.borderWidth = _buttonBorderWidth;
    
    
    
	self.layer.cornerRadius = MIN(rect.size.width, rect.size.height)  / 2;
	CGRect newRect = ({
        CGFloat insetWidth =  self.wrapperArcWidth + self.layer.borderWidth * 2;
        CGRect insetRect = CGRectInset(rect, insetWidth, insetWidth);
        CGRect newRect = insetRect;
        newRect.size.width = MIN(CGRectGetMaxX(insetRect), CGRectGetMaxY(insetRect));
        newRect.size.height = newRect.size.width;
        newRect.origin.x = insetRect.origin.x + (CGRectGetWidth(insetRect) - CGRectGetWidth(newRect)) / 2;
        newRect.origin.y = insetRect.origin.y + (CGRectGetHeight(insetRect) - CGRectGetHeight(newRect)) / 2;
        newRect;
    });
	UIBezierPath *outerCircle = [UIBezierPath bezierPathWithOvalInRect:newRect];
	[self.wrapperColor setStroke];
	outerCircle.lineWidth = self.wrapperArcWidth;
	[outerCircle stroke];
}

- (CGPathRef)progressPath {
	// Offset
	CGFloat offset = -M_PI_2;
    
	// EndAngle
	CGFloat endAngle =  self.currentProgress * 2 * M_PI + offset;
    
	// Center
	CGRect rect = self.bounds;
	rect = CGRectInset(rect, self.layer.borderWidth * 2, self.layer.borderWidth * 2);
	CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
	// Radius
	CGFloat radius = MIN(center.x, center.y) - self.progressArcWidth / 2 - self.layer.borderWidth;
    
	// Inner arc
	UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:center
	                                                       radius:radius
	                                                   startAngle:offset
	                                                     endAngle:endAngle
	                                                    clockwise:1];
    
	return arcPath.CGPath;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[self refreshShapeLayer];
}

#pragma mark - Setters methods

- (void)setTintColor:(UIColor *)tintColor {
	self.borderColor = tintColor;
	self.buttonBorderColor = tintColor;
	self.progressColor = tintColor;
	self.wrapperColor = tintColor;
	[self setNeedsDisplay];
}

- (void)setImage:(UIImage *)image {
	_image = image;
    
	[_imageView setImage:image];
}

- (void)setEnableButton:(BOOL)enableButton {
	_enableButton = enableButton;
	[_imageView setUserInteractionEnabled:enableButton];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
	self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
	self.layer.borderColor = borderColor.CGColor;
}

#pragma mark - Getters methods

- (CAShapeLayer *)shapeLayer {
	if (!_shapeLayer) {
		_shapeLayer = [CAShapeLayer layer];
		_shapeLayer.lineWidth = self.progressArcWidth;
		_shapeLayer.fillColor = nil;
		_shapeLayer.lineJoin = kCALineJoinBevel;
		_shapeLayer.speed = 1.0f;
		[self.layer addSublayer:_shapeLayer];
	}
    
	// This will allow the color to be change in the middle of the duration period
	_shapeLayer.strokeColor = self.progressColor.CGColor;
    
	return _shapeLayer;
}

#pragma mark - Private methods

- (void)refreshShapeLayer {
	// Update path
	self.shapeLayer.path = [self progressPath];
    
	// Animation
	if (self.currentProgress != self.lastProgress && self.animated) {
		// From value
		CGFloat fromValue = (1 * self.lastProgress) / self.currentProgress;
        
		// Animation
		CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
		pathAnimation.delegate = self.delegate;
		pathAnimation.duration = self.duration;
		pathAnimation.fromValue = @(fromValue);
		pathAnimation.toValue = @(1.0f);
		[self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
	}
    
	// Update lastProgress
	self.lastProgress = self.currentProgress;
}

#pragma mark - Public methods

- (void)setProgress:(CGFloat)progress {
	[self setProgress:progress animated:NO];
}

- (CGFloat)getProgress {
	return _currentProgress;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animate {
	self.currentProgress = MAX(MIN(progress, 1.0f), 0.0f);
	self.animated = animate;
	if (progress == 0.0) {
		//means reset been tapped
		self.shapeLayer.speed = 1;
	}
	[self setNeedsLayout];
}

- (void)setProgress:(CGFloat)progress duration:(CFTimeInterval)duration {
	self.duration = duration;
	[self setProgress:progress animated:YES];
}

#pragma mark pause/resume
- (void)pause {
	if (self.currentProgress != 0) {
		CFTimeInterval pausedTime = [self.shapeLayer convertTime:CACurrentMediaTime() fromLayer:nil];
		self.shapeLayer.speed = 0.0;
		self.shapeLayer.timeOffset = pausedTime;
	}
}

- (void)resume {
	if (self.shapeLayer.speed == 0) {
		CFTimeInterval pausedTime = [self.shapeLayer timeOffset];
		self.shapeLayer.speed = 1.0;
		self.shapeLayer.timeOffset = 0.0;
		self.shapeLayer.beginTime = 0.0;
		CFTimeInterval timeSincePause = [self.shapeLayer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
		self.shapeLayer.beginTime = timeSincePause;
	}
}

@end
