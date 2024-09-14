#import <NSLogger/NSLogger.h>

// https://lucifer1988.github.io/blog/2014/02/25/qiang-li-de-ri-zhi-fen-xi-gong-ju-nslogger/
#ifdef DEBUG
    #define LOG_IMAGE(name, image)       LogImageData(name, 0, image.size.width, image.size.height, UIImagePNGRepresentation(image))
#else
    #define LOG_IMAGE(name, image)       do { (void)(name); (void)(image); } while(0)
#endif


#if defined __cplusplus
extern "C" {
#endif

void testMatchTemplate();

#if defined __cplusplus
};
#endif