#include <opencv2/core.hpp>

#import <UIKit/UIKit.h>

#import <NSLogger/NSLogger.h>

#import "TestOpenCV.h"

// For making NSLog be able to print OpenCV logs, but it's not working as expected.
// int myErrorHandler(int status, const char* func_name, const char* err_msg,
//                    const char* file_name, int line, void* userdata)
// {
//     NSString *logMessage = [NSString stringWithFormat:@"[OpenCV Error] (%s:%d) in %s: %s (Status: %d)",
//                             file_name, line, func_name, err_msg, status];
//     NSLog(@"%@", logMessage);
//     // Return 0 to continue execution or a non-zero value to abort
//     return 0;
// }

// void setupOpenCVErrorHandling()
// {
//     cv::redirectError(myErrorHandler);
// }

%hook SpringBoard

// Handle volume up button event to trigger testMatchTemplate procedure
- (BOOL)_handlePhysicalButtonEvent:(UIPressesEvent *)pressesEvent
{
    NSLog(@"[DebugOpenCVWithDopamine] _handlePhysicalButtonEvent");
    NSSet *presses = [pressesEvent allPresses];
    if (presses.count == 1) {
        UIPress * press = [presses anyObject];
        if (press) {
            if ((int)(press.type) == 102) {
                if (press.force <= 0.99) {
                    NSLog(@"[DebugOpenCVWithDopamine] Volume up button up");
                    testMatchTemplate();
                }
            }
        }
    }

    return %orig;
}

%end

%ctor {
    // Call this function during your tweak's initialization
    // setupOpenCVErrorHandling();
}