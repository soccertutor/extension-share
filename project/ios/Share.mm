#include <Share.h>
#import <UIKit/UIKit.h>

namespace openflShareExtension {
	
	void doShare(const char *text, const char *url, const char *subject, const char *image){
        UIViewController *root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        NSString *sText = [[NSString alloc] initWithUTF8String:text];
        NSArray *itemsToShare;
        if(url != nil){
	        NSURL *sURL = [NSURL URLWithString:[[NSString alloc] initWithUTF8String:url]];
	        itemsToShare = @[sText,sURL];
        }else{
	        itemsToShare = @[sText];        	
        }

        NSString *sImage = [[NSString alloc] initWithUTF8String:image];
        if(![sImage isEqualToString:@""])
        {
            UIImage* sharedImg=[UIImage imageWithContentsOfFile:sImage];
            NSArray *imageArray = @[sharedImg];
            itemsToShare=[itemsToShare arrayByAddingObjectsFromArray:imageArray];
        }

        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        if(subject != nil){
            [activityVC setValue:[[NSString alloc] initWithUTF8String:subject] forKey:@"subject"];
        }

        // Required for iPad on iOS >=8
        if ([activityVC respondsToSelector:@selector(popoverPresentationController)]) {
            if(NULL != [activityVC valueForKey: @"popoverPresentationController"]) {
                [[activityVC valueForKey: @"popoverPresentationController"] setValue:[[UIApplication sharedApplication] keyWindow] forKey:@"sourceView"];
                [[activityVC valueForKey: @"popoverPresentationController"] setPermittedArrowDirections:0]; // Remove arrow from action sheet.
                [[activityVC valueForKey: @"popoverPresentationController"] setValue:[NSValue valueWithCGRect:[[UIApplication sharedApplication] keyWindow].frame] forKey:@"sourceRect"]; // Set action sheet to middle of view.
            }
        }

        activityVC.excludedActivityTypes = @[UIActivityTypeAddToReadingList,
                                             UIActivityTypeCopyToPasteboard,
                                             UIActivityTypePrint,
                                             UIActivityTypeAssignToContact,
                                             UIActivityTypeSaveToCameraRoll,
                                             UIActivityTypeAddToReadingList,
                                             //UIActivityTypeMail,
                                             ];
        [root presentViewController:activityVC animated:YES completion:nil];
    }

	void doImageShare(const char *image) {
        UIViewController *root = [[[UIApplication sharedApplication] keyWindow] rootViewController];

        NSString *sImage = [[NSString alloc] initWithUTF8String:image];
        UIImage* sharedImg=[UIImage imageWithContentsOfFile:sImage];

        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[sharedImg] applicationActivities:nil];
        [activityVC setValue:[[NSString alloc] initWithUTF8String:"Image.png"] forKey:@"subject"];

        // Required for iPad on iOS >=8
        if ([activityVC respondsToSelector:@selector(popoverPresentationController)]) {
            if(NULL != [activityVC valueForKey: @"popoverPresentationController"]) {
                [[activityVC valueForKey: @"popoverPresentationController"] setValue:[[UIApplication sharedApplication] keyWindow] forKey:@"sourceView"];
                [[activityVC valueForKey: @"popoverPresentationController"] setPermittedArrowDirections:0]; // Remove arrow from action sheet.
                [[activityVC valueForKey: @"popoverPresentationController"] setValue:[NSValue valueWithCGRect:[[UIApplication sharedApplication] keyWindow].frame] forKey:@"sourceRect"]; // Set action sheet to middle of view.
            }
        }

        activityVC.excludedActivityTypes = @[UIActivityTypeAddToReadingList,
                                             UIActivityTypeCopyToPasteboard,
                                             UIActivityTypeAssignToContact];
        
        activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
            NSLog(@"%d %@", completed, activityError.localizedDescription);
        };
        
        [root presentViewController:activityVC animated:YES completion:nil];
    }

	void doPDFShare(const char *path) {
        UIViewController *root = [[[UIApplication sharedApplication] keyWindow] rootViewController];

        NSString *sPath = [[NSString alloc] initWithUTF8String:path];
        NSLog(sPath);
        NSData *pdfData = [NSData dataWithContentsOfFile:sPath];

        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[pdfData] applicationActivities:nil];
        [activityVC setValue:[[NSString alloc] initWithUTF8String:"Image.png"] forKey:@"subject"];

        // Required for iPad on iOS >=8
        if ([activityVC respondsToSelector:@selector(popoverPresentationController)]) {
            if(NULL != [activityVC valueForKey: @"popoverPresentationController"]) {
                [[activityVC valueForKey: @"popoverPresentationController"] setValue:[[UIApplication sharedApplication] keyWindow] forKey:@"sourceView"];
                [[activityVC valueForKey: @"popoverPresentationController"] setPermittedArrowDirections:0]; // Remove arrow from action sheet.
                [[activityVC valueForKey: @"popoverPresentationController"] setValue:[NSValue valueWithCGRect:[[UIApplication sharedApplication] keyWindow].frame] forKey:@"sourceRect"]; // Set action sheet to middle of view.
            }
        }

        activityVC.excludedActivityTypes = @[UIActivityTypeAddToReadingList,
                                             UIActivityTypeCopyToPasteboard,
                                             UIActivityTypeAssignToContact];
        activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
            NSLog(@"%d %@", completed, activityError.localizedDescription);
        };

        [root presentViewController:activityVC animated:YES completion:nil];
    }

}
