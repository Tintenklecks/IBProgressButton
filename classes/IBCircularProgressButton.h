//
//  MRCircularProgressView.h
//  MRCircularProgressView
//
//  Created by Jose Luis Martinez de la Riva on 30/01/14.
//  Modified and enhanced to be a button by Ingo Böhme 2014-05-30
//
//  Copyright (c) 2014 http://martinezdelariva.com
//  and (c) 2014 http://www.IBMobile.de
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

#import <UIKit/UIKit.h>

@interface IBCircularProgressButton : UIView

@property (nonatomic) BOOL enableButton;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic) BOOL resizeImageToFit;

@property (assign, nonatomic) CGFloat borderWidth;
@property (strong, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) CGFloat buttonBorderWidth;
@property (strong, nonatomic) UIColor *buttonBorderColor;

@property (assign, nonatomic) CGSize buttonPressOffset;



@property (assign, nonatomic) CGFloat spaceWidth;
@property (getter = getProgress, setter = setProgress :, nonatomic) CGFloat progress;




// Set delegate to allow callbacks (animataionDidFinish, etc)
@property (strong, nonatomic) id delegate;

// Color of the progress arc
@property (strong, nonatomic) UIColor *progressColor;

// Width of progress arc
@property (assign, nonatomic) CGFloat progressArcWidth;

// Width of wrapper arc
@property (assign, nonatomic) CGFloat wrapperArcWidth;

// Color of wrapper arc
@property (strong, nonatomic) UIColor *wrapperColor;



- (void)addTarget:(id)target action:(SEL)selector forControlEvents:(UIControlEvents)controlEvent;


// Set new progress (0.0f - 1.0f) with animation option
- (void)setProgress:(CGFloat)progress animated:(BOOL)animate;

// Set new progress (0.0f - 1.0f) animated with custom duration
- (void)setProgress:(CGFloat)progress duration:(CFTimeInterval)duration;

- (void)pause;

- (void)resume;
@end
