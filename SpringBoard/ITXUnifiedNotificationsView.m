#import <Intelix/ITXUnifiedNotificationsView.h>
#import <Intelix/ITXSeperatedCornersView.h>
#import <QuartzCore/CAFilter+Private.h>
#import <QuartzCore/CALayer+Private.h>

@interface BackdropView : UIView
@end

@interface NCMaterialView : UIView {
	BackdropView *_backdropView;
}
-(id)initWithStyleOptions:(NSUInteger)arg1 ;
@end

@implementation ITXUnifiedNotificationsView {
	ITXSeperatedCornersView *_topView;
	ITXSeperatedCornersView *_middleView;
	ITXSeperatedCornersView *_bottomView;
	UIView *_maskContainer;
	CGFloat _middleTopOrigin;
	CGFloat _middleBottomOrigin;
	CGFloat _separatedSpacing;
	CGFloat _slidePercentage;
	CGFloat _cornerRadius;
	CGFloat _slidingCellHeight;
	CGFloat _prevHeight;
	CGFloat _prevWidth;
	// NCMaterialView *_backdropView;
}

// - (CGRect)bounds {
// 	return CGRectMake(self.frame.size.width/2,0,self.frame.size.width, self.frame.size.height);
// }

+ (Class)layerClass {
	return NSClassFromString(@"CABackdropLayer");
}

- (id)initWithFrame:(CGRect)frame {
	self = [self initWithFrame:frame cornerRadius:15];
	if (self) {

	}
	return self;
}

- (id)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius {
	self = [super initWithFrame:frame];
	if (self) {
		CGFloat height = self.frame.size.height;
		CGFloat halfHeight = self.frame.size.height/2;
		CGFloat width = self.frame.size.width/2;

		_middleTopOrigin = halfHeight;
		_middleBottomOrigin = halfHeight;
		_separatedSpacing = 4.0;
		_slidePercentage = 0.0;
		_cornerRadius = cornerRadius;
		_slidingCellHeight = 65.0;

		_topView = [[ITXSeperatedCornersView alloc] initWithFrame:CGRectMake(0,0,width,height - _middleTopOrigin - (_separatedSpacing * _slidePercentage))];
		_topView.backgroundColor = [UIColor blackColor];
		[_topView setTopRadius:_cornerRadius bottomRadius:0 withDelay:0];

		_middleView = [[ITXSeperatedCornersView alloc] initWithFrame:CGRectMake(0,_middleTopOrigin,width,_middleBottomOrigin - _middleTopOrigin)];
		_middleView.backgroundColor = [UIColor blackColor];
		[_middleView setTopRadius:0 bottomRadius:0 withDelay:0];

		_bottomView = [[ITXSeperatedCornersView alloc] initWithFrame:CGRectMake(0,_middleBottomOrigin + (_separatedSpacing * _slidePercentage) ,width,height - _middleBottomOrigin - (_separatedSpacing * _slidePercentage))];
		_bottomView.backgroundColor = [UIColor blackColor];
		[_bottomView setTopRadius:0 bottomRadius:_cornerRadius withDelay:0];

		_maskContainer = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width,0,self.frame.size.width/2,self.frame.size.height)];
		[_maskContainer addSubview:_topView];
		[_maskContainer addSubview:_middleView];
		[_maskContainer addSubview:_bottomView];

		self.maskView = _maskContainer;
		// [self addSubview:_maskContainer];

		_prevWidth = width;
		_prevHeight = self.frame.size.height;

		NSMutableArray *filters = [NSMutableArray new];
		CAFilter *filter = [NSClassFromString(@"CAFilter") filterWithType:@"gaussianBlur"];
		[filter setValue:[NSNumber numberWithFloat:30] forKey:@"inputRadius"];
		[filter setValue:@YES forKey:@"inputHardEdges"];
		[filters addObject:filter];

		CAFilter *filter1 = [NSClassFromString(@"CAFilter") filterWithType:@"colorSaturate"];
		[filter1 setValue:[NSNumber numberWithFloat:2.4] forKey:@"inputAmount"];
		[filters addObject:filter1];

		[self.layer setFilters:[filters copy]];
		self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];

		//CGAffineTransform transform = CGAffineTransformIdentity;

    	// Move origin from upper left to lower left.
    	//transform = CGAffineTransformTranslate(transform, width/2, 0);
		//_maskContainer.transform = transform;
		self.layer.scale = 0.25;



		// self.layer.groupName = @"ITXTest";

		// _backdropView = [[NSClassFromString(@"NCMaterialView") alloc] initWithStyleOptions:4];
		// [self addSubview:_backdropView];
		// _backdropView.frame = self.frame;
		//self.backgroundColor = [UIColor redColor];

	}
	return self;

}

- (void)layoutSubviews {
	[super layoutSubviews];
	//_backdropView.frame = self.frame;
	_maskContainer.frame = CGRectMake(self.frame.size.width/2,0,self.frame.size.width/2,self.frame.size.height);
	[self setRevealPercentage:_slidePercentage];

}

- (void)setupForDemo {
	CGFloat middleTop = self.frame.size.height/2 - (_slidingCellHeight/2);
	CGFloat middleBottom = self.frame.size.height/2 + (_slidingCellHeight/2);
	[self setMiddleTop:middleTop andMiddleBottom:middleBottom];
}

- (void)runDemoWithDelay:(int)delay animationDuration:(CGFloat)duration {
	[self setupForDemo];
	CGRect middleFrame = CGRectMake(0-97,_middleTopOrigin,self.frame.size.width/2,_middleBottomOrigin - _middleTopOrigin);
	// middleFrame.origin.x = 0 - 87;
//	[UIView setAnimationRepeatCount:10];
	[UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
		//[UIView setAnimationRepeatCount:3];

		//[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
			// [UIView animateWithDuration:((NSTimeInterval)duration/8) delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
			// 	[self setRevealPercentage:1.0];
			// } completion:^(BOOL finished) {

		 //   	}];
		   	_middleView.frame = middleFrame;
		//} completion:^(BOOL finished) {
	   //	}];
		// [UIView animateWithDuration:duration/4 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
		// 	_middleView.frame = middleFrame;
		// } completion:^(BOOL finished) {

	 //   	}];
  //       [self setRevealPercentage:1.0];
       
   } completion:^(BOOL finished) {
   		CGRect frame = CGRectMake(0,_middleTopOrigin,self.frame.size.width/2,_middleBottomOrigin - _middleTopOrigin);
	   	frame.origin.x = 0;
		[UIView animateWithDuration:duration delay:3 options:UIViewAnimationOptionCurveEaseOut  animations:^{
			// [UIView animateWithDuration:((NSTimeInterval)duration/8) delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
			// 	[self setRevealPercentage:0.0];
			// } completion:^(BOOL finished) {

		 //   	}];
			_middleView.frame = frame;
		} completion:^(BOOL finished) {

	   	}];

	   	[UIView animateWithDuration:((NSTimeInterval)duration/4) delay:3 + ((NSTimeInterval)duration/6) options:UIViewAnimationOptionCurveEaseOut  animations:^{
			[self setRevealPercentage:0.0];
		} completion:^(BOOL finished) {

	   	}];
   }];

	[UIView animateWithDuration:((NSTimeInterval)duration/4) delay:delay + ((NSTimeInterval)duration/6)options:UIViewAnimationOptionCurveEaseOut  animations:^{
		[self setRevealPercentage:1.0];
	} completion:^(BOOL finished) {

   	}];
}

- (void)setRevealPercentage:(CGFloat)percentage {

	CGFloat height = self.frame.size.height;
	CGFloat width = self.frame.size.width/2;

	if (percentage != _slidePercentage || _prevHeight != height || _prevWidth != width) {
		_slidePercentage = percentage;
		_prevWidth = width;
		_prevHeight = height;

		if (_middleTopOrigin < _cornerRadius) {
			_topView.frame = CGRectMake(_topView.frame.origin.x,0,width,_middleBottomOrigin);
			[_topView setTopRadius:_cornerRadius bottomRadius:_cornerRadius*_slidePercentage withDelay:0];

			_bottomView.frame = CGRectMake(_bottomView.frame.origin.x,_middleBottomOrigin + (_separatedSpacing * _slidePercentage) ,width,height - _middleBottomOrigin - (_separatedSpacing * _slidePercentage));
			[_bottomView setTopRadius:_cornerRadius*_slidePercentage bottomRadius:_cornerRadius withDelay:0];

			_middleView.frame = CGRectMake(_middleView.frame.origin.x,0,width,0);
		} else if (_middleBottomOrigin > height - _cornerRadius) {
			_topView.frame = CGRectMake(_topView.frame.origin.x,0,width,height - _middleTopOrigin - (_separatedSpacing * _slidePercentage));
			[_topView setTopRadius:_cornerRadius bottomRadius:_cornerRadius*_slidePercentage withDelay:0];

			_bottomView.frame = CGRectMake(_bottomView.frame.origin.x,height - _middleTopOrigin,width,height - _middleTopOrigin);
			[_bottomView setTopRadius:_cornerRadius*_slidePercentage bottomRadius:_cornerRadius withDelay:0];

			_middleView.frame = CGRectMake(_middleView.frame.origin.x,0,width,0);
		} else {
			_topView.frame = CGRectMake(_topView.frame.origin.x,0,width,_middleTopOrigin - (_separatedSpacing * _slidePercentage));
			[_topView setTopRadius:_cornerRadius bottomRadius:_cornerRadius*_slidePercentage withDelay:0];

			_bottomView.frame = CGRectMake(_bottomView.frame.origin.x,_middleBottomOrigin + (_separatedSpacing * _slidePercentage), width, height -_middleBottomOrigin - (_separatedSpacing * _slidePercentage));
			[_bottomView setTopRadius:_cornerRadius*_slidePercentage bottomRadius:_cornerRadius withDelay:0];


			_middleView.frame = CGRectMake(_middleView.frame.origin.x,_middleTopOrigin,width,_middleBottomOrigin - _middleTopOrigin);
			[_middleView setTopRadius:_cornerRadius*_slidePercentage bottomRadius:_cornerRadius*_slidePercentage withDelay:0];
		}
	}
}

- (void)setMiddleTop:(CGFloat)top andMiddleBottom:(CGFloat)bottom {
	_middleTopOrigin = top;
	_middleBottomOrigin = bottom;
	//CGRect middleFrame = CGRectMake(_middleView.frame.origin.x,_middleTopOrigin,self.frame.size.width,_middleBottomOrigin - _middleTopOrigin);
	//_middleView.frame = middleFrame;
	[self setRevealPercentage:_slidePercentage];
}
@end