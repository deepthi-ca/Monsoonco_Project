//
//  Utils.m
//  TeluguBasha
//
//  Created by Deepthi Muthyala on 7/15/13.
//  Copyright (c) 2013 Sahasra. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (id)loadFirstViewFromNibName:(NSString*)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSBundle * bundle = ( nibBundleOrNil ) ? nibBundleOrNil : [NSBundle mainBundle];
	NSArray * nib = [bundle loadNibNamed:nibNameOrNil owner:self options:nil];
	
	for ( NSObject * obj in nib )
	{
		if ( [obj isKindOfClass:[UIView class]] )
		{
			return (id)obj;
		}
	}
	
	return nil;
}


@end
