#include <opencv2/opencv.hpp>
#include <opencv2/imgcodecs/ios.h>

#include "TestOpenCV.h"

// https://stackoverflow.com/a/44728074/385127
// After <opencv2/opencv.hpp>
#include <UIKit/UIKit.h>

OBJC_EXTERN UIImage *_UICreateScreenUIImage(void) NS_RETURNS_RETAINED;

void testMatchTemplate()
{
    NSString *dir = @"/var/jb/var/mobile/Library/";

    // Create the directory if it doesn't exist
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Failed to create directory at %@. Error: %@", dir, error.localizedDescription);
        return;
    }

    NSString *filePath = [dir stringByAppendingPathComponent:@"DebugOpenCVWithDopamine.png"];

    UIImage *screenImage = _UICreateScreenUIImage();

    // Save screenImage to filePath
    NSData *imageData = UIImagePNGRepresentation(screenImage);
    if (imageData) {
        BOOL success = [imageData writeToFile:filePath atomically:YES];
        if (!success) {
            NSLog(@"Failed to save image to %@", filePath);
        }
    } else {
        NSLog(@"Failed to convert UIImage to PNG data");
    }

    // TODO: cv::imread leads to crash in Dopamine env.
    cv::Mat sceneImage = cv::imread([filePath UTF8String]);

    // Cut out a region from the source image to make a "template" image for matching template testing
    cv::Rect region(100, 200, 180, 120);
    cv::Mat templateImage = sceneImage(region);

    LOG_IMAGE(@"template image", MatToUIImage(templateImage));
    LOG_IMAGE(@"scene image", MatToUIImage(sceneImage));

    // Result matrix
    cv::Mat result;

    // Perform template matching
    // TODO: cv::matchTemplate also leads to crash in Dopamine env.
    cv::matchTemplate(sceneImage, templateImage, result, cv::TM_CCOEFF_NORMED);

    // // Normalize the result matrix to display it as an image
    // cv::normalize(result, result, 0, 255, cv::NORM_MINMAX, CV_8UC1);
    // // Convert the result matrix to a UIImage
    // UIImage *resultImage = MatToUIImage(result);
    // // Log the result image data to NSLogger and display it in the viewer
    // LOG_IMAGE(@"TestOpenCV result image", resultImage);
}