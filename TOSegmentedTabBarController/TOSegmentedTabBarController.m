//
//  TOSegmentedTabBarController.m
//  TOSegmentedTabBarControllerExample
//
//  Created by Tim Oliver on 30/12/18.
//  Copyright © 2018 Tim Oliver. All rights reserved.
//

#import "TOSegmentedTabBarController.h"

CGFloat const kTOSegmentedControlWidth = 180.0f;

@interface TOSegmentedTabBarController ()

@property (nonatomic, strong, readwrite) UIToolbar *toolbar;
@property (nonatomic, strong, readwrite) UISegmentedControl *segmentedControl;

// Convenience
@property (nonatomic, readonly) BOOL compactHorizontal;
@property (nonatomic, readonly) BOOL compactVertical;
@property (nonatomic, readonly) CGFloat segmentedControlWidth;

@end

@implementation TOSegmentedTabBarController

#pragma mark - Class Creation -

- (instancetype)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers
{
    if (self = [super init]) {
        [self commonInit];
        _controllers = controllers;
    }
    
    return self;
}

- (void)commonInit
{
//    _separatorLineColor = [UIColor colorWithRed:0.556f green:0.556 blue:0.576 alpha:1.0f];
//    _secondaryViewControllerFractionalWidth = 0.3125f;
//    _secondaryViewControllerMinimumWidth = 320.0f;
//    _segmentedControlHeight = 26.0f;
//    _segmentedControlVerticalOffset = 9.0f;
}

#pragma mark - View Management -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Common view config
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Set up the toolbar
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.toolbar];
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:nil];
    self.segmentedControl.frame = CGRectMake(0,0,kTOSegmentedControlWidth, 28.0f);
    self.segmentedControl.selectedSegmentIndex = 0;
    
    // Start adding the child view controllers
    [self addChildViewControllers];
    
    // Configure the items for the toolbar
    [self configureToolBarItems];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGSize boundSize = self.view.bounds.size;
    
    // Work out the height of the toolbar
    CGFloat toolbarHeight = self.compactVertical ? 34.0f : 44.0f;
    
    // Set our safe area to include the tab bar
    self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, toolbarHeight, 0);
    
    // Layout the toolbar
    CGRect frame = CGRectZero;
    frame.size.width = boundSize.width;
    frame.size.height = toolbarHeight;
    frame.origin.y = boundSize.height - (self.view.safeAreaInsets.bottom);
    self.toolbar.frame = frame;
    [self.view bringSubviewToFront:self.toolbar];
    
    // Layout the separator view
    frame = self.segmentedControl.frame;
    frame.size.width = self.segmentedControlWidth;
    self.segmentedControl.frame = frame;
}

- (void)configureToolBarItems
{
    NSMutableArray *items = [NSMutableArray array];
    
    if (self.leftBarButtonItems.count) { [items addObjectsFromArray:self.leftBarButtonItems]; }
    
    UIBarButtonItem *flexibleSpacing = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                     target:nil
                                                                                     action:nil];
    
    [items addObject:flexibleSpacing];
    [items addObject:[[UIBarButtonItem alloc] initWithCustomView:self.segmentedControl]];
    [items addObject:flexibleSpacing];
    
    if (self.rightBarButtonItems.count) { [items addObjectsFromArray:self.rightBarButtonItems]; }
 
    self.toolbar.items = items;
}

- (void)updateVisibleViewController
{
    for (UIViewController *controller in self.controllers) {
        controller.view.hidden = YES;
    }
    
    self.controllers[self.visibleControllerIndex].view.hidden = NO;
}

#pragma mark - Child View Controller -

- (void)addChildViewControllers
{
    if (self.controllers.count == 0) { return; }
    
    [self.segmentedControl removeAllSegments];
    
    for (UIViewController *controller in self.controllers) {
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        
        [self.segmentedControl insertSegmentWithTitle:controller.title
                                              atIndex:self.segmentedControl.numberOfSegments
                                             animated:NO];
    }
    
    // Re-highlight the previous index
    self.segmentedControl.selectedSegmentIndex = self.visibleControllerIndex;
    
    // Update the visible controller
    [self updateVisibleViewController];
    
    // Force an update for the table bar
    [self.view setNeedsLayout];
}

- (void)removeAllChildControllers
{
    for (UIViewController *controller in self.childViewControllers) {
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
    }
}

#pragma mark - Accessor -

- (CGFloat)segmentedControlWidth
{
    CGSize boundsSize = self.view.bounds.size;
    CGFloat controlWidth = MIN(boundsSize.width, boundsSize.height);
    
    if (self.leftBarButtonItems.count == 0 && self.rightBarButtonItems.count == 0) {
        return controlWidth;
    }
    
    return [self.segmentedControl sizeThatFits:boundsSize].width + 20.0f;
}

- (BOOL)compactVertical
{
    return self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact;
}

- (BOOL)compactHorizontal
{
    return self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact;
}

@end
