@interface NCLookHeaderContentView : UIView
@property (nonatomic,readonly) UIButton* iconButton;  
@property (nonatomic,retain) UIImage* icon;
-(id)initWithStyle:(NSInteger)style;
-(void)setIcon:(UIImage *)icon;
-(void)setTitle:(NSString *)title;
- (CGSize)sizeThatFits:(CGSize)size;
- (UILabel *)_titleLabel;
@end

@interface NCLookHeaderContentView (Intelix)
@property (nonatomic, assign) BOOL isITXView; 
@end