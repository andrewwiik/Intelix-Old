/*
 *     Generated by class-dump 3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2012 by Steve Nygard.
 */

#import <Foundation/NSObject.h>

// #import "../BulletinBoard/BBObserverDelegate-Protocol.h"
// #import "../FuseUI/MCProfileConnectionObserver-Protocol.h"
#import "SBApplicationRestrictionObserver-Protocol.h"
#import "SBFolderControllerDelegate-Protocol.h"
#import "SBIconModelApplicationDataSource-Protocol.h"
#import "SBIconModelDelegate-Protocol.h"
#import "SBIconViewDelegate-Protocol.h"
#import "SBIconViewMapDelegate-Protocol.h"
#import "SBSearchGestureObserver-Protocol.h"
#import "SBIconViewMap.h"
#import "SBIconContentView.h"
#import "SBRootIconListView.h"

@class BBObserver, NSIndexPath, NSMutableArray, NSMutableSet, NSObject, NSSet, NSTimer, SBFolder, SBIcon, SBIconColorSettings, SBIconContentView, SBIconModel, SBLeafIcon, SBRootFolderController, UITouch, _UILegibilitySettings;

@interface SBIconController : NSObject <SBApplicationRestrictionObserver, SBFolderControllerDelegate, SBSearchGestureObserver, SBIconViewDelegate, SBIconModelDelegate, SBIconViewMapDelegate, SBIconModelApplicationDataSource>
{
    NSSet *_visibleTags;
    NSSet *_hiddenTags;
    SBIconModel *_iconModel;
    SBIconContentView *_contentView;
    BOOL _needsRelayout;
    BOOL _sendITunesNotification;
    BBObserver *_bbObserver;
    NSMutableSet *_displayIDsWithBadgingDisabled;
    SBRootFolderController *_rootFolderController;
    SBFolder *_closingFolder;
    SBFolder *_folderToOpenWhenScrollingEnds;
    BOOL _rotating;
    int _orientation;
    SBIcon *_launchingIcon;
    SBIcon *_highlightedIcon;
    SBLeafIcon *_iconToReveal;
    SBIcon *_grabbedIcon;
    SBIcon *_recipientIcon;
    NSMutableArray *_droppedIconsAnimatingIntoPlace;
    NSMutableArray *_droppedIconsInToOrOutOfFolder;
    unsigned int _numberOfDroppedIconsAnimatingIntoOrOutOfFolder;
    SBIcon *_lastTouchedIcon;
    BOOL _isEditing;
    BOOL _animatingFolder;
    BOOL _grabbedIconIsDraggedOutOfFolderView;
    SBFolder *_grabbedIconSourceFolder;
    BOOL _allowsUninstall;
    float _iconAlpha;
    float _oldScrollOffset;
    UITouch *_lastTouch;
    NSTimer *_folderSpringloadTimer;
    BOOL _keyboardIsRotating;
    BOOL _isAnimatingFolderCreation;
    BOOL _isAnimatingForUnscatter;
    unsigned int _maxIconViewsInHierarchy;
    unsigned int _maxNewsstandItemViewsInHierarchy;
    SBIconColorSettings *_iconColorSettings;
    BOOL _showingSearch;
    _UILegibilitySettings *_legibilitySettings;
    NSIndexPath *_indexPathToResetTo;
}

+ (instancetype)sharedInstance;
@property(retain, nonatomic) _UILegibilitySettings *legibilitySettings;
@property(retain, nonatomic) SBIconContentView *view; // @synthesize legibilitySettings=_legibilitySettings;
- (void)searchGesture:(id)arg1 changedPercentComplete:(float)arg2;
- (void)folderControllerDidEndScrolling:(id)arg1;
- (void)folderControllerShouldBeginEditing:(id)arg1;
- (void)folderControllerShouldClose:(id)arg1;
- (void)folderController:(id)arg1 draggedIconShouldDropFromListView:(id)arg2;
- (BOOL)folderController:(id)arg1 draggedIconMightDropFromListView:(id)arg2;
- (BOOL)folderController:(id)arg1 draggedIconDidMoveFromListView:(id)arg2 toListView:(id)arg3;
- (BOOL)folderController:(id)arg1 draggedIconDidPauseAtLocation:(struct CGPoint)arg2 inListView:(id)arg3;
- (id)_debugStringForIconOrder:(int)arg1;
- (void)applicationRestrictionController:(id)arg1 didUpdateVisibleTags:(id)arg2 hiddenTags:(id)arg3;
- (void)profileConnectionDidReceiveEffectiveSettingsChangedNotification:(id)arg1 userInfo:(id)arg2;
- (id)firstPageLeafIdentifiers;
- (BOOL)isNewsstandEnabled;
- (id)defaultIconState;
- (int)appVisibilityOverrideForBundleIdentifier:(id)arg1;
- (BOOL)updateAppIconVisibilityOverridesShowing:(id *)arg1 hiding:(id *)arg2;
- (id)allApplications;
- (void)observer:(id)arg1 noteServerConnectionStateChanged:(BOOL)arg2;
- (void)observer:(id)arg1 updateSectionInfo:(id)arg2;
- (void)_updateDisabledBadgesSetWithSections:(id)arg1;
- (BOOL)_badgesAreDisabledForSectionInfo:(id)arg1;
- (BOOL)iconViewDisplaysCloseBox:(id)arg1;
- (BOOL)iconViewDisplaysBadges:(id)arg1;
- (BOOL)iconAllowsBadging:(id)arg1;
- (void)iconCloseBoxTapped:(id)arg1;
- (BOOL)icon:(id)arg1 canReceiveGrabbedIcon:(id)arg2;
- (void)iconTapped:(id)arg1;
- (BOOL)iconShouldAllowTap:(id)arg1;
- (void)icon:(id)arg1 touchMoved:(id)arg2;
- (void)iconTouchBegan:(id)arg1;
- (void)icon:(id)arg1 touchEnded:(BOOL)arg2;
- (void)iconHandleLongPress:(id)arg1;
- (int)viewMap:(id)arg1 locationForIcon:(id)arg2;
- (unsigned int)viewMap:(id)arg1 maxRecycledIconViewsOfClass:(Class)arg2;
- (unsigned int)viewMap:(id)arg1 numberOfViewsToPrepareOfClass:(Class)arg2;
- (id)viewMapShouldPrepareViewsOfClasses:(id)arg1;
- (void)didDeleteIconState:(id)arg1;
- (void)didSaveIconState:(id)arg1;
- (BOOL)canSaveIconState:(id)arg1;
- (void)noteIconStateChangedExternally;
- (BOOL)importIconState:(id)arg1;
- (void)_selectIconModel:(BOOL)arg1;
- (void)_installedAppsDidChange:(id)arg1;
- (void)_iconModelDidLayout:(id)arg1;
- (void)_iconModelWillLayout:(id)arg1;
- (void)_iconModelDidReloadIcons:(id)arg1;
- (void)_iconModelWillReloadIcons:(id)arg1;
- (BOOL)relayout;
- (BOOL)dismissSpotlightIfNecessary;
- (void)_lockScreenUIWillLock:(id)arg1;
- (void)_noteUserIsInteractingWithIcons;
- (BOOL)isIconVisiblyRepresented:(id)arg1;
- (BOOL)_iconListIndexIsValid:(int)arg1;
- (void)layoutIconLists:(float)arg1 domino:(BOOL)arg2 forceRelayout:(BOOL)arg3;
- (void)compactIconsInIconListsInFolder:(id)arg1 moveNow:(BOOL)arg2 limitToIconList:(id)arg3;
- (void)compactRootIconLists;
- (void)compactFolders:(id)arg1;
- (void)animationDidStop:(id)arg1 finished:(BOOL)arg2;
- (void)folderSpringloadTimerFired;
- (void)noteGrabbedIconLocationChangedWithTouch:(id)arg1;
- (void)_resetFolderSpringloadTimer;
- (void)_cancelFolderSpringloadTimer;
- (id)recipientIcon;
- (void)setLastTouchedIcon:(id)arg1;
- (id)lastTouchedIcon;
- (void)setRecipientIcon:(id)arg1 duration:(double)arg2;
- (id)grabbedIcon;
- (void)_iconDropDidFinish:(id)arg1;
- (void)setGrabbedIcon:(id)arg1;
- (void)_dropIcon:(id)arg1 withInsertionPath:(id)arg2;
- (void)fixupBouncedIconsInFolder:(id)arg1 startingWithIndex:(int)arg2;
- (void)setLastTouch:(id)arg1;
- (void)noteViewCovered;
- (void)restoreScrollingAndRotationAfterUngrab;
- (void)moveIconFromWindow:(id)arg1 toIconList:(id)arg2;
- (void)_moveIconToContentView:(id)arg1;
- (void)_keyboardWillHide:(id)arg1;
- (void)_keyboardWillShow:(id)arg1;
- (BOOL)isEditing;
- (void)setIsEditing:(BOOL)arg1;
- (void)iconWasTapped:(id)arg1;
- (void)clearHighlightedIcon;
- (void)_launchIcon:(id)arg1;
- (void)_precacheFolderImages:(id)arg1 location:(int)arg2;
- (void)removeAllIconAnimations;
- (BOOL)isAnimatingForUnscatter;
- (void)unscatterAnimated:(BOOL)arg1 afterDelay:(double)arg2 withCompletion:(id)arg3;
- (void)scatterAnimated:(BOOL)arg1 withCompletion:(id)arg2;
- (void)setIdleModeText:(id)arg1;
- (void)updateNumberOfRowsWithDuration:(double)arg1;
- (void)uninstallIcon:(id)arg1 animate:(BOOL)arg2;
- (void)uninstallIcon:(id)arg1;
- (BOOL)canUninstallIcon:(id)arg1;
- (BOOL)allowsUninstall;
- (void)uninstallIconAnimationCompletedForIcon:(id)arg1;
- (void)removeIcon:(id)arg1 compactFolder:(BOOL)arg2;
- (void)removeIcon:(id)arg1 andCompactFolder:(BOOL)arg2 folderRef:(id *)arg3;
- (id)insertIcon:(id)arg1 intoListView:(id)arg2 iconIndex:(int)arg3 moveNow:(BOOL)arg4;
- (id)insertIcon:(id)arg1 intoListView:(id)arg2 iconIndex:(int)arg3 moveNow:(BOOL)arg4 pop:(BOOL)arg5;
- (id)insertIcon:(id)arg1 atIndexPath:(id)arg2 moveNow:(BOOL)arg3;
- (id)insertIcon:(id)arg1 atIndexPath:(id)arg2 moveNow:(BOOL)arg3 pop:(BOOL)arg4;
- (id)placeIcon:(id)arg1 atIndexPath:(id)arg2 moveNow:(BOOL)arg3 layoutNow:(BOOL)arg4 pop:(BOOL)arg5;
- (void)scrollToIconToRevealAnimated:(BOOL)arg1;
- (void)finishInstallingIconAnimated:(BOOL)arg1;
- (void)setIconToReveal:(id)arg1 revealingPrevious:(BOOL)arg2;
- (id)iconToReveal;
- (void)replaceIconAtPath:(id)arg1 withIcon:(id)arg2 saveState:(BOOL)arg3;
- (void)addNewIconToDesignatedLocation:(id)arg1 animate:(BOOL)arg2 scrollToList:(BOOL)arg3 saveIconState:(BOOL)arg4;
- (void)addNewIconsToDesignatedLocations:(id)arg1 saveIconState:(BOOL)arg2;
- (void)didRotateFromInterfaceOrientation:(int)arg1;
- (void)willAnimateRotationToInterfaceOrientation:(int)arg1 duration:(double)arg2;
- (void)willRotateToInterfaceOrientation:(int)arg1 duration:(double)arg2;
- (int)orientation;
- (void)handleHomeButtonTap;
- (BOOL)scrollToIconListAtIndex:(int)arg1 animate:(BOOL)arg2;
- (void)scrollToIconListContainingIcon:(id)arg1 animate:(BOOL)arg2;
- (BOOL)_shouldLockItemsInStoreDemoMode;
- (BOOL)_iconCanBeGrabbed:(id)arg1;
- (id)currentFolderIconList;
- (id)dockListView;
- (id)currentRootIconList;
- (void)resetCurrentVisibleIconListImageVisibilityAndJitterState;
- (void)updateCurrentIconListIndexAndVisibility:(BOOL)arg1;
- (void)updateCurrentIconListIndexAndVisibility;
- (BOOL)isFolderScrolling;
- (BOOL)isScrolling;
- (void)showCarrierDebuggingAlertIfNeeded;
- (void)showInfoAlertIfNeeded:(BOOL)arg1;
- (void)showSpotlightAlertIfNecessary;
- (void)_iconVisibilityChanged:(id)arg1;
- (void)_resetRootIconLists;
- (void)_prepareToResetRootIconLists;
- (id)folderIconListAtIndex:(unsigned int)arg1;
- (int)currentFolderIconListIndex;
- (int)currentIconListIndex;
- (id)_currentFolderController;
- (id)_openFolderController;
- (id)_rootFolderController;
- (id)rootFolder;
- (id)contentView;
- (void)dealloc;
- (id)model;
- (id)init;
- (void)_runScrollFolderTest:(int)arg1;
- (void)_runFolderCloseTest;
- (void)_runFolderOpenTest;
- (unsigned int)_folderRowsForFolder:(id)arg1;
- (unsigned int)_folderRowsForFolder:(id)arg1 inOrientation:(int)arg2;
- (struct CGRect)_contentViewRelativeFrameForIcon:(id)arg1;
- (void)shiftFolderViewsForKeyboardAppearing:(BOOL)arg1 keyboardHeight:(float)arg2;
- (id)_proposedFolderNameForGrabbedIcon:(id)arg1 recipientIcon:(id)arg2;
- (void)_snapshotFadeDidStop:(id)arg1 finished:(id)arg2 snapshot:(id)arg3;
- (void)_addToFolderAnimation:(id)arg1 didFinish:(id)arg2 context:(id)arg3;
- (void)_compactRootListsAfterFolderCloseWithAnimation:(BOOL)arg1;
- (void)_cleanupForClosingFolderAnimated:(BOOL)arg1;
- (void)_folderDidFinishOpenClose:(BOOL)arg1 animated:(BOOL)arg2;
- (void)_animateFolder:(id)arg1 open:(BOOL)arg2 animated:(BOOL)arg3;
- (void)replaceFolderIcon:(id)arg1 byContainedIcon:(id)arg2 animated:(BOOL)arg3;
- (void)animateIcons:(id)arg1 intoFolderIcon:(id)arg2 openFolderOnFinish:(BOOL)arg3 complete:(id)arg4;
- (BOOL)isDroppingIcon:(id)arg1;
- (BOOL)isDroppingIconsInOrOutOfFolder;
- (void)_moveDroppedIconsToLocation:(int)arg1;
- (void)_dropIconOutOfClosingFolder:(id)arg1 withInsertionPath:(id)arg2;
- (void)_dropIconIntoOpenFolder:(id)arg1 withInsertionPath:(id)arg2;
- (id)createNewFolderFromRecipientIcon:(id)arg1 grabbedIcon:(id)arg2;
- (void)_closeFolderController:(id)arg1 animated:(BOOL)arg2;
- (void)closeFolderAnimated:(BOOL)arg1;
- (void)openFolder:(id)arg1 animated:(BOOL)arg2;
- (BOOL)isNewsstandOpen;
- (id)openFolder;
- (BOOL)hasOpenFolder;
- (BOOL)hasAnimatingFolder;
- (void)_setAnimatingFolderCreation:(BOOL)arg1;
- (void)_setFolderToOpenAfterScrolling:(id)arg1;
- (void)_setHasAnimatingFolder:(BOOL)arg1;
- (void)_noteFolderAnimationStateDidChange;
- (id)iconListViewAtIndex:(unsigned int)arg1 inFolder:(id)arg2 createIfNecessary:(BOOL)arg3;
- (void)getListView:(id *)arg1 folder:(id *)arg2 relativePath:(id *)arg3 forIndexPath:(id)arg4 createIfNecessary:(BOOL)arg5;
- (SBIconViewMap *)homescreenIconViewMap; // iOS 9.3.3
- (SBRootIconListView *)rootIconListAtIndex:(long long)arg1 ;
@end

