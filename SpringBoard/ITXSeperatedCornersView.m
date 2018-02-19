#import <Intelix/ITXSeperatedCornersView.h>

#import <CoreGraphics/CoreGraphics.h>
#import <Intelix/ITXAnimationView.h>
#import <UIKit/UIView+Private.h>

@implementation ITXSeperatedCornersView {
	UIView *_topCorners;
	ITXAnimationView *_topCornersMaskView;
	UIView *_bottomCorners;
	ITXAnimationView *_bottomCornersMaskView;
	UIView *_maskContainer;
	CGFloat _cornerRadiusToUse;
	CGFloat _topPercent;
	CGFloat _bottomPercent;
	CGFloat _topClipPercent;
	CGFloat _bottomClipPercent;
}

+ (Class)layerClass {
	return NSClassFromString(@"CABackdropLayer");
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		CGFloat halfHeight = self.bounds.size.height/2;
		CGFloat width = self.bounds.size.width;
		_topCorners = [UIView new];
		_topCorners.frame = CGRectMake(0,0,width,halfHeight);
		_topCorners.backgroundColor = [UIColor blackColor];
		_topCorners.clipsToBounds = YES;

		_topCornersMaskView = [ITXAnimationView new];
		_topCornersMaskView.frame = _topCorners.bounds;
		_topCornersMaskView.backgroundColor = [UIColor blackColor];
		_topCorners.maskView = _topCornersMaskView;


		_bottomCorners = [UIView new];
		_bottomCorners.frame = CGRectMake(0,halfHeight,width,halfHeight);
		_bottomCorners.backgroundColor = [UIColor blackColor];
		_bottomCorners.clipsToBounds = YES;

		_bottomCornersMaskView = [ITXAnimationView new];
		_bottomCornersMaskView.frame = _bottomCorners.bounds;
		_bottomCornersMaskView.backgroundColor = [UIColor blackColor];
		_bottomCorners.maskView = _bottomCornersMaskView;
		
		_maskContainer = [UIView new];
		_maskContainer.bounds = self.bounds;
		[_maskContainer addSubview:_topCorners];
		[_maskContainer addSubview:_bottomCorners];

		_cornerRadiusToUse = 0;
		_topPercent = 0.0;
		_bottomPercent = 0.0;
		self.maskView = _maskContainer;
		self.clipValue = 0;
		_topClipPercent = 0.0;
		_bottomClipPercent = 0.0;


	}
	return self;
}

- (void)setTopRadius:(CGFloat)topRadius bottomRadius:(CGFloat)bottomRadius withDelay:(int)delay {
	//[UIView animateWithDuration:10 delay:delay options:UIViewAnimationOptionCurveLinear  animations:^{
        //code with animation
        _topCornersMaskView.layer.cornerRadius = _cornerRadiusToUse*topRadius;
        _bottomCornersMaskView.layer.cornerRadius = _cornerRadiusToUse*bottomRadius;
        _topPercent = topRadius;
        _bottomPercent = bottomRadius;
        [self updateCornerFrames];
   // } completion:^(BOOL finished) {
        //code for completion
   // }];
	//CGFloat halfHeight = self.bounds.size.height/2;
	//CGFloat width = self.bounds.size.width;
	// _topCornersMaskView.layer.cornerRadius = topRadius;
	// //_topCornersMaskView.frame = CGRectMake(0,0,width, halfHeight + topRadius);
	// _bottomCornersMaskView.layer.cornerRadius = bottomRadius;
	// [self updateCornerFrames];
	// //_bottomCornersMaskView.frame = CGRectMake(0-bottomRadius,0,width, halfHeight + bottomRadius);
}

- (void)setTopRadius:(CGFloat)topRadius {
	[self setTopRadius:topRadius bottomRadius:_bottomPercent withDelay:0];
}

- (void)setBottomRadius:(CGFloat)bottomRadius {
	[self setTopRadius:_topPercent bottomRadius:bottomRadius withDelay:0];
}

- (void)setTopClipPercent:(CGFloat)topClipPercent {
	_topClipPercent = topClipPercent;
}

- (void)setBottomClipPercent:(CGFloat)bottomClipPercent {
	_bottomClipPercent = bottomClipPercent;
}

- (void)updateCornerFrames {
	CGFloat halfHeight = self.bounds.size.height/2;
	CGFloat width = self.bounds.size.width;
	CGFloat topRadius = _topCornersMaskView.layer.cornerRadius;
	CGFloat bottomRadius = _bottomCornersMaskView.layer.cornerRadius;

	_maskContainer.frame = self.bounds;
	_topCorners.frame = CGRectMake(0,0,width,halfHeight);
	_bottomCorners.frame = CGRectMake(0,halfHeight,width,halfHeight);

	_topCornersMaskView.frame = CGRectMake(0,(self.clipValue * _topClipPercent),width, halfHeight + topRadius);
	_bottomCornersMaskView.frame = CGRectMake(0,0-bottomRadius - (self.clipValue * _bottomClipPercent),width, halfHeight + bottomRadius);
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[self updateCornerFrames];
}

- (void)setContinousCornerRadius:(CGFloat)cornerRadius {
	_bottomCornersMaskView._continuousCornerRadius = cornerRadius;
	_topCornersMaskView._continuousCornerRadius = cornerRadius;
	_cornerRadiusToUse = _topCornersMaskView.layer.cornerRadius;
	[self setTopRadius:_topPercent bottomRadius:_bottomPercent withDelay:0];

}

- (CGFloat)cornerRadiusBeingUsed {
	return _cornerRadiusToUse;
}
@end
