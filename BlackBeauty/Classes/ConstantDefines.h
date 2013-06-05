//
//  ConstantDefines.h
//  BlackBeauty
//
//  Created by Mahi on 4/30/13.
//  Copyright (c) 2013 Mahi. All rights reserved.
//


//Yes, it is PMS 165.C: 0M: 59Y: 96K: 0R:245G: 132B: 38Web/hex color: #f58426

#import <Foundation/Foundation.h>

#define LOCATIONSDB @"location.db"
#define DEG2RAD(degrees) (degrees * 0.01745327) // degrees * pi over 180
#define RELEASE_TO_NIL(x) { if (x!=nil) { [x release]; x = nil; } }

#define DEFAULT_EMAIL @"reedcs@harsco.com" 
#define FAQNUMBER 6;
#define BBORIGINALPRODUCTIMAGE @"black beauty product photo"
#define BBGLASSPRODUCTIMAGE @"black beauty glass product photo"
#define BBIRONPRODUCTIMAGE @"black beauty iron product photo"


#define BBORIGINALURL @"http://www.blackbeautyabrasives.com/admin/resources/cph-msds-na-black-beautyr-.pdf.pdf"
#define BBGLASSURL @"http://www.blackbeautyabrasives.com/admin/resources/cph-msds-na-black-beautyr-glass.pdf.pdf"
#define BBIRONURL @"http://www.blackbeautyabrasives.com/admin/resources/cph-msds-na-black-beautyr-iron.pdf.pdf"

#define BBORIGINAL @"BBOriginal.pdf"
#define BBGLASS    @"BBGlass.pdf"
#define BBIRON     @"BBIron.pdf"

typedef enum  {
    
    MyLocation,
    OtherLocation
}USERPREFERENCE;

typedef enum  {
    
    BBOriginal,
    BBGlass,
    BBIron
}PRODUCTTYPE;


@interface ConstantDefines : NSObject

@end
