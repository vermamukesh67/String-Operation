//
//  ViewController.m
//  ExampleTesting
//
//  Created by Verma Mukesh on 23/05/18.
//  Copyright © 2018 Verma Mukesh. All rights reserved.
//

#import "ViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([self CheckForanagrams:@"this is my scooter" SecondString:@"scooter this my is"]) {
        NSLog(@"yeah both are anagram string");
    }
    else
    {
        NSLog(@"No both are anagram string");
    }
    [self isPalindrome:@"(Salas#^^^^&&^@@!...,,,,????+=*67)"];
    [self CheckForPangram:@"The quick brown fox jumps over Lazy Dog"];
    
    if ([self CheckForSingleEditDiff:@"sve" SecondString:@"saVe"]) {
        
        NSLog(@"Yes Single Edit Diff");
    }
    
    NSLog(@"count = %d", [self PrepareForanagrams:@"this is my scooter" SecondString:@"scooter this y is"]);
    
    NSString *logString = @"user logged (3 attempts)";
    NSString *digits = [logString stringByTrimmingCharactersInSet:
                        [[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    NSLog(@"Attempts: %i", [digits intValue]);
    
    NSString *numberString;
    NSScanner *scanner = [NSScanner scannerWithString:logString];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&numberString];
    [scanner scanCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:&numberString];
    NSLog(@"Attempts: %i", [numberString intValue]);

    
}

-(int)PrepareForanagrams:(NSString *)a SecondString:(NSString *)b
{
    NSMutableSet *aSet = [[NSMutableSet alloc] init];
    NSMutableSet *bSet = [[NSMutableSet alloc] init];
    NSMutableSet *CSet = [[NSMutableSet alloc] init];
    
    for (int i = 0; i < a.length; i++)
        {
        [aSet addObject:@([a characterAtIndex:i])];
       
        [CSet addObject:@([a characterAtIndex:i])];
    }
    
    for (int i = 0; i < b.length; i++)
    {
        [bSet addObject:@([b characterAtIndex:i])];
    }
    
     [aSet minusSet:bSet];
     [bSet minusSet:CSet];

    return (int)aSet.count + (int)bSet.count;
}

- (BOOL)isPalindrome:(NSString *)phrase
{
    if (phrase) {
        
        // remove spaces, punctuation
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s\\p{P}\\^\\+-=1234567890]" options:NSRegularExpressionCaseInsensitive error:&error];
        phrase = [regex stringByReplacingMatchesInString:phrase
                                                 options:0
                                                   range:NSMakeRange(0, phrase.length)
                                            withTemplate:@""];
        if (phrase.length > 1) {
            phrase = [phrase lowercaseString];
            
            // go to mid-point while checking for same character on other end
            for (int i = 0; i < phrase.length / 2 + 1; ++i) {
                if ([phrase characterAtIndex:i] != [phrase characterAtIndex:(phrase.length - i - 1)]) {
                    return NO;
                }
            }
            NSLog(@"YES its palindrom");
            return YES;
        }
        else {
            NSLog(@"YES its palindrom");
            return YES;
        }
    }
    return NO;
}

-(BOOL)CheckForPangram:(NSString *)strText
{
    NSString *strAlbhabets = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableSet *aSet = [[NSMutableSet alloc] init];
    NSMutableSet *bSet = [[NSMutableSet alloc] init];
    
    for (int i = 0; i < strText.length; i++)
    {
        [bSet addObject:@([[strText lowercaseString] characterAtIndex:i])];
    }
    for (int i = 0; i < strAlbhabets.length; i++)
    {
        [aSet addObject:@([[strAlbhabets lowercaseString] characterAtIndex:i])];
    }
    
    if ([aSet isSubsetOfSet:bSet])
    {
    NSLog(@"yes its panagram");
    return YES;
    }
    else
    {
    NSLog(@"no its not panagram");
    return NO;
    }
}

-(BOOL)CheckForanagrams:(NSString *)a SecondString:(NSString *)b
{
    if (a.length != b.length)
        return NO;
    
    NSMutableSet *aSet = [[NSMutableSet alloc] init];
    NSMutableSet *bSet = [[NSMutableSet alloc] init];
    
    for (int i = 0; i < a.length; i++)
    {
        [aSet addObject:@([a characterAtIndex:i])];
        [bSet addObject:@([b characterAtIndex:i])];
    }
    
    return [aSet isEqual:bSet];
}

-(BOOL)CheckForSingleEditDiff:(NSString *)text1 SecondString:(NSString *)text2
{
    // length diff must be < 1
    // lenght = 0 is acceptable
    if (text1.length >= text2.length - 1 && text1.length <= text2.length + 1 )
        {
        // the obvious case
        //if text1 == text2 { return true}
        
        NSMutableArray *char1Arr = [[NSMutableArray alloc] init];
        NSMutableArray *char2Arr = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < text1.length; i++)
        {
            [char1Arr addObject:@([text1 characterAtIndex:i])];
        }
        for (int i = 0; i < text2.length; i++)
        {
            [char2Arr addObject:@([text2 characterAtIndex:i])];
        }
        
        int diffCount = 0;
        int idx1 = 0;
        int idx2 = 0;
        
        while (idx1 < char1Arr.count && idx2 < char2Arr.count)
            {
            if (char1Arr[idx1] == char2Arr[idx2]) {
                idx1 += 1;
                idx2 += 1;
            }
            else {
                diffCount += 1;
                if (diffCount > 1) {
                    return FALSE;
                }
                if (char1Arr.count > char2Arr.count) {
                    idx1 += 1;
                }
                else if (char2Arr.count > char1Arr.count) {
                    idx2 += 1;
                }
                else {
                    idx1 += 1;
                    idx2 += 1;
                }
            }
        }
        return TRUE;
        }
    return FALSE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
