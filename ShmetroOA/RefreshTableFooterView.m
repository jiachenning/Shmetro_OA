//
// DemoTableFooterView.m
//
// @author Shiki
//

#import "RefreshTableFooterView.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation RefreshTableFooterView

@synthesize activityIndicator;
@synthesize infoLabel;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) awakeFromNib
{
  self.backgroundColor = [UIColor clearColor];
  [super awakeFromNib];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
  [activityIndicator release];
  [infoLabel release];
  [super dealloc];
}

@end
