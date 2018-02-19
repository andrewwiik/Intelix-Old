
@interface NCNotificationListViewController : UICollectionViewController
@property (assign,nonatomic) id userInteractionDelegate;              //@synthesize userInteractionDelegate=_userInteractionDelegate - In the implementation block
@property (assign,nonatomic) id destinationDelegate; 
@end