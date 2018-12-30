//
//  TOSegmentedTabBarController.h
//  TOSegmentedTabBarControllerExample
//
//  Created by Tim Oliver on 30/12/18.
//  Copyright © 2018 Tim Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSegmentedTabBarController : UIViewController

/** The view controllers to be displayed by this controller, in order of display. There may only be 2. */
@property (nonatomic, copy) NSArray<UIViewController *> *controllers;

/** The toolbar containing the segmented view */
@property (nonatomic, strong, readonly) UIToolbar *toolbar;

/** The segemented view control placed at the top of the control. */
@property (nonatomic, readonly) UISegmentedControl *segmentedControl;

/** A set of items that will appear on the left side of the segmented bar in the toolbar */
@property (nonatomic, copy) NSArray *leftBarButtonItems;

/** A set of items that will appear on the right side of the segmented bar in the toolbar */
@property (nonatomic, copy) NSArray *rightBarButtonItems;

/** The index of the currently visible view controller */
@property (nonatomic, assign) NSInteger visibleControllerIndex;

/**
 Creates a new instance of this view controller, populated by the content
 view controllers provided in the arguments.
 
 @param controllers The child view controllers to present in this controller. There must be 2.
 @return A new instance of `TOSegmentedTabBarController`
 */
- (instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers;

@end

NS_ASSUME_NONNULL_END
