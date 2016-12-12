//
//  NSString+Extension.h
//  Easywork
//
//  Created by Kingxl on 11/4/14.
//  Copyright (c) 2014 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

#pragma mark - Tools

/** Remove spaces and line breaks */
- (NSString *)ew_removeSpacesAndLineBreaks;

/** A string has substring */
- (BOOL)ew_hasSubString:(NSString *)subStr;

/** Replace string with string */
- (NSString *)ew_replaceString:(NSString *)str withString:(NSString *)aStr;

/** According to the font size and line width calculation line high*/
- (CGFloat)ew_heightWithFont:(UIFont *)font lineWidth:(CGFloat)width;

/** According to the font size and line Max width calculation line width*/
- (CGFloat)ew_widthWithFont:(UIFont *)font lineWidth:(CGFloat)width;

/** Focus Substring in string */
- (NSMutableAttributedString *)ew_focusSubstring:(NSString *)subString color:(UIColor *)fontColor font:(UIFont *)font;
- (NSMutableAttributedString *)ew_focufrontstring:(NSString *)frontString backString:(NSString *)backString color:(UIColor *)fontColor font:(UIFont *)font;
/** Seprator string with substring */
- (NSArray *)ew_sepratorwithString:(NSString *)str;

/** number of lines */
- (NSInteger)ew_numberOfLinesWithFont:(UIFont*)font lineWidth:(NSInteger)lineWidth;

/** Check email */
- (BOOL)ew_checkEmail;

/** Check phone number */
- (BOOL)ew_checkPhoneNumber;

/** Check ID number */
- (BOOL)ew_checkIDNumber;


#pragma mark - Encode & Decode

/** MD5 encrypt */
- (NSString *)ew_md5Encrypt;

/** Base64 encode */
- (NSString *)ew_base64Encode;

/** Base64 decode*/
- (NSString *)ew_base64Decode;

/** URL encode*/
- (NSString *)ew_urlEncode;

/** URL decode*/
- (NSString *)ew_urlDecode;


@end
