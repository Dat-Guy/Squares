//
//  SquaresView.h
//  Squares
//
//  Created by Aidan Smith on 12/27/19.
//  Copyright © 2019 Aidan Smith. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

@interface SquaresView : ScreenSaverView

@property double **sizePhase;
@property double **colorPhase;
@property double **alphaTime;
@property double time;
@property double baseSize;

@end
