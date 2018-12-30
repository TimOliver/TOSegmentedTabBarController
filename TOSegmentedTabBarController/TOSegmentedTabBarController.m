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

@property (nonatomic, strong, readwrite) UIView *separatorView;
@property (nonatomic, strong, readwrite) UIToolbar *toolbar;
@property (nonatomic, strong, readwrite) UISegmentedControl *segmentedControl;

// Convenience
@property (nonatomic, readonly) BOOL compactHorizontal;
@property (nonatomic, readonly) BOOL compactVertical;
@property (nonatomic, readonly) BOOL regularLayout;
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
    _showSplitControllersInRegularPresentation = YES;
    _separatorLineColor = [UIColor colorWithRed:0.556f green:0.556 blue:0.576 alpha:1.0f];
    _secondaryViewControllerFractionalWidth = 0.3125f;
    _secondaryViewControllerMinimumWidth = 320.0f;
}

#pragma mark - View Management -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Common view config
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Set up the toolbar
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.toolbar];
    
    // Set up the separator view
    self.separatorView = [[UIView alloc] initWithFrame:CGRectZero];
    self.separatorView.backgroundColor = self.separatorLineColor;
    [self.view addSubview:self.separatorView];
    
    // Set up the segmented control
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:nil];
    self.segmentedControl.frame = CGRectMake(0,0,kTOSegmentedControlWidth, 28.0f);
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = 0;
    
    // Start adding the child view controllers
    [self addChildViewControllers];
    
    // Configure the items for the toolbar
    [self configureToolBarItems];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (!self.regularLayout) { [self layoutSubviewsForCompactPresentation]; }
    else { [self layoutSubviewsForRegularPresentation]; }
    
    // Make sure the right controller is visible
    [self updateVisibleViewController];
}

- (void)layoutSubviewsForRegularPresentation
{
    // Hide the toolbar
    self.toolbar.hidden = YES;
    
    // Set safe area to default
    self.additionalSafeAreaInsets = UIEdgeInsetsZero;
    
    CGSize boundSize = self.view.bounds.size;
    
    // Display the controllers in split mode
    // Handle the second controller first
    CGRect frame = CGRectZero;
    frame.size.width = floor(boundSize.width * self.secondaryViewControllerFractionalWidth);
    frame.size.width = MAX(frame.size.width, self.secondaryViewControllerMinimumWidth);
    frame.size.height = boundSize.height;
    frame.origin.x = boundSize.width - frame.size.width;
    self.controllers[1].view.frame = frame;
    
    //First Controller
    frame.size.width = boundSize.width - frame.size.width;
    frame.origin.x = 0.0f;
    self.controllers[0].view.frame = frame;

    //Separator
    self.separatorView.hidden = NO;
    
    frame.size.width = 1.0f / UIScreen.mainScreen.nativeScale;
    frame.origin.x = CGRectGetMinX(self.controllers[1].view.frame);
    self.separatorView.frame = frame;
    [self.view bringSubviewToFront:self.separatorView];
}

- (void)layoutSubviewsForCompactPresentation
{
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
    self.toolbar.hidden = NO;
    [self.view bringSubviewToFront:self.toolbar];
    
    // Layout the separator view
    frame = self.segmentedControl.frame;
    frame.size.width = self.segmentedControlWidth;
    self.segmentedControl.frame = frame;
    
    // Size the controllers
    for (UIViewController *controller in self.controllers) {
        controller.view.frame = (CGRect){CGPointZero, boundSize};
    }
    
    // Hide the separator
    self.separatorView.hidden = YES;
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
    BOOL regularLayout = self.regularLayout;
    
    for (UIViewController *controller in self.controllers) {
        controller.view.hidden = regularLayout ? NO : YES;
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

#pragma mark - Interaction -
- (void)segmentedControlChanged:(id)sender
{
    _visibleControllerIndex = self.segmentedControl.selectedSegmentIndex;
    [self updateVisibleViewController];
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

- (BOOL)regularLayout
{
    BOOL compactLayout = self.compactHorizontal;
    if (!compactLayout) {
        compactLayout = (self.controllers.count != 2 && self.showSplitControllersInRegularPresentation);
    }
    
    return !compactLayout;
}

@end
