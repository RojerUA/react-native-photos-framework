#import "RNPFHelpers.h"
#import <CoreLocation/CLLocation.h>
#import <React/RCTConvert.h>
#import "RCTConvert+RNPhotosFramework.h"

@implementation RNPFHelpers

+(NSDateFormatter *)getISODateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    return dateFormatter;
}

+(NSString *)NSDateToJsonString:(NSDate *)date andDateFormatter:(NSDateFormatter *)dateFormatter {
    if(date == nil) {
        return (NSString *)[NSNull null];
    }
    NSString *iso8601String = [dateFormatter stringFromDate:date];
    return iso8601String;
}

+(NSTimeInterval)getTimeSince1970:(NSDate *)date {
    if(date == nil) {
        return 0;
    }
    return date.timeIntervalSince1970;
}

+(NSDictionary *)CLLocationToJson:(CLLocation *)loc {
    return loc ? @{
                       @"latitude": @(loc.coordinate.latitude),
                       @"longitude": @(loc.coordinate.longitude),
                       @"altitude": @(loc.altitude),
                       @"heading": @(loc.course),
                       @"speed": @(loc.speed),
                       } : @{};
}

+(NSString *)convertEnumToStringValue:(int)type andValues:(NSDictionary *)values {
    return [[values allKeysForObject:[NSNumber numberWithInt:type]] firstObject];
}

+(NSArray*) nsOptionsToArray:(int)option andBitSize:(int)bitSize andReversedEnumDict:(NSDictionary *)dict
{
    if(option == 0){
        NSString *zeroValue = [dict objectForKey:@(0)];
        return zeroValue ? [NSArray arrayWithObject:zeroValue] : (NSMutableArray*)[NSNull null];
    }
    NSMutableArray * nsOptions = [[NSMutableArray alloc] init];
        for (NSUInteger i=0; i < bitSize; i++) {
        NSUInteger enumBitValueToCheck = 1UL << i;
        if ((option & enumBitValueToCheck)) {
            NSObject *option = dict[@(enumBitValueToCheck)];
            if (option) {
                [nsOptions addObject:option];
            }
        }
    }
    
    return nsOptions;
}

+(NSString*) nsOptionsToValue:(int)option andBitSize:(int)bitSize andReversedEnumDict:(NSDictionary *)dict
{
    if(option == 0){
        NSString *zeroValue = [dict objectForKey:@(0)];
        return zeroValue ? zeroValue : (NSString*)[NSNull null];
    }
    for (NSUInteger i=0; i < bitSize; i++) {
        NSUInteger enumBitValueToCheck = 1UL << i;
        if (option & enumBitValueToCheck) {
            return [dict objectForKey:@(enumBitValueToCheck)];
            
        }
    }
    
    return (NSString*)[NSNull null];
}

+(PHVideoRequestOptions *)getVideoRequestOptionsFromParams:(NSDictionary *)params {
    
    PHVideoRequestOptions *videoRequestOptions = [PHVideoRequestOptions new];
    videoRequestOptions.networkAccessAllowed = YES;
    
    PHVideoRequestOptionsVersion version = PHVideoRequestOptionsVersionCurrent;
    PHVideoRequestOptionsDeliveryMODE deliveryMODE = PHVideoRequestOptionsDeliveryMODEAutomatic;

    if(params != nil) {
        NSString *deliveryMODEQuery = [RCTConvert NSString:params[@"deliveryMODE"]];
        NSString *versionQuery = [RCTConvert NSString:params[@"version"]];
        if(versionQuery) {
            if([versionQuery isEqualToString:@"original"]) {
                version = PHVideoRequestOptionsVersionOriginal;
            }
        }
        
        if(deliveryMODEQuery != nil) {
            if([deliveryMODEQuery isEqualToString:@"mediumQuality"]) {
                deliveryMODE = PHVideoRequestOptionsDeliveryMODEMediumQualityFormat;
            }
            else if([deliveryMODEQuery isEqualToString:@"highQuality"]) {
                deliveryMODE = PHVideoRequestOptionsDeliveryMODEHighQualityFormat;
            }
            else if([deliveryMODEQuery isEqualToString:@"fast"]) {
                deliveryMODE = PHVideoRequestOptionsDeliveryMODEFastFormat;
            }
        }
    }

    videoRequestOptions.deliveryMODE = deliveryMODE;
    videoRequestOptions.version = version;
    
    return videoRequestOptions;
}


@end
