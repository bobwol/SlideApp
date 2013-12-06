//
//  PlayerView.m
//  SlideApp
//
//  Created by koba on 2013/12/06.
//  Copyright (c) 2013年 hogelab.net. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "PlayerView.h"

@implementation PlayerView

+ (Class)layerClass
{
	return [AVPlayerLayer class];
}

@end
