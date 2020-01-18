//
//  SquaresView.m
//  Squares
//
//  Created by Aidan Smith on 12/27/19.
//  Copyright © 2019 Aidan Smith. All rights reserved.
//

#import "SquaresView.h"

@implementation SquaresView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
        
        // Setup program primatives
//        if (isPreview){
//            self.baseSize = 10;
//        } else {
            self.baseSize = 15;
//        }
        self.time = 0;
        double unitsX = [self bounds].size.width / self.baseSize;
        double unitsY = [self bounds].size.height / self.baseSize;
        
        // Initialize color and size arrays
        self.sizePhase = malloc(sizeof(double *) * unitsX);
        self.colorPhase = malloc(sizeof(double *) * unitsX);
        self.alphaTime = malloc(sizeof(double *) * unitsX);
        
        for (int i = 0; i < unitsX; i++){
            self.sizePhase[i] = malloc(sizeof(double) * unitsY);
            self.colorPhase[i] = malloc(sizeof(double) * unitsY);
            self.alphaTime[i] = malloc(sizeof(double) * unitsY);
            for (int j = 0; j < unitsY; j++){
                self.sizePhase[i][j] = SSRandomFloatBetween(0, 2 * M_PI);
                self.colorPhase[i][j] = SSRandomFloatBetween(0, 2 * M_PI);
                self.alphaTime[i][j] = SSRandomFloatBetween(3, 6);
            }
        }
        
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    NSBezierPath *back = [NSBezierPath bezierPathWithRect:[self bounds]];
    [[NSColor colorWithWhite:0.05 alpha:1] set];
    [back fill];
    
    NSBezierPath *path = [NSBezierPath bezierPath];
    
    double fade = 1.0 / (1.0 + pow(M_E, -2.0 * self.time + 5));
    
    for (int i = 0; i < [self bounds].size.width / self.baseSize; i++){
        for (int j = 0; j < [self bounds].size.height / self.baseSize; j++){
            [[NSColor colorWithRed:sin(self.colorPhase[i][j] + self.time)
                             green:cos(self.colorPhase[i][j] + self.time / 2)
                              blue:sin(self.colorPhase[i][j] + self.time * 3)
                             alpha:cos(self.colorPhase[i][j] + self.time * self.alphaTime[i][j]) * fade] set];
            double size = self.baseSize * (1 + sin(self.sizePhase[i][j] + self.time / 5));
            [path appendBezierPathWithRect:NSMakeRect(i * self.baseSize - (size - self.baseSize) / 2, j * self.baseSize - (size - self.baseSize) / 2, size, size)];
            [path fill];
            [path removeAllPoints];
        }
    }
    
    self.time += sin(self.time) * cos(self.time) / 50 + 0.02;
    
    [self setNeedsDisplay:YES];
}

- (void)animateOneFrame
{
    [self setNeedsDisplay:YES];
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
