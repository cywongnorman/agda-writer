//
//  PreferencesGeneralController.m
//  Agda Writer
//
//  Created by Marko Koležnik on 25. 07. 15.
//  Copyright (c) 2015 koleznik.net. All rights reserved.
//

#import "PreferencesGeneralController.h"
#import "AWCommunitacion.h"
#import "AWNotifications.h"
#import "AWHelper.h"
#import "AWPopoverViewController.h"

@interface PreferencesGeneralController ()

@end

@implementation PreferencesGeneralController {
    NSFont * selectedFont;
    AWPopoverViewController * _popoverViewController;
    NSPopover * _popover;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do view setup here.
    
    [self.agdaPathTextField setStringValue:[AWNotifications agdaLaunchPath]];
    [self setImagesFoundPath:[self isAgdaAvaliableAtPath:[AWNotifications agdaLaunchPath]]];
    
    if ([AWHelper isShowingNotifications]) {
        [self.showsNotifications setState:NSOnState];
    }
    else {
        [self.showsNotifications setState:NSOffState];
    }
    [self.pathToLibraries setStringValue:[AWHelper pathToLibraries]];
    selectedFont = [AWHelper defaultFontInAgda];
    self.pathToLibraries.delegate = self;
    self.delayForAutocompleteTextField.delegate = self;
    
    _popover = [[NSPopover alloc] init];
    _popoverViewController = [[AWPopoverViewController alloc] initWithNibName:@"AWPopoverViewController" bundle:nil];
    [_popover setBehavior:NSPopoverBehaviorTransient];
    [_popover setContentViewController:_popoverViewController];
    [_popover setAnimates:YES];
    
    [self fillFontFamilies];
    [self fillFontSizes];

}

- (void) fillFontSizes
{
    for (int i = 8; i <= 25; i++) {
        [self.fontSizePopupButton addItemWithTitle:[NSString stringWithFormat:@"%i",i]];
    }
    
    [self.fontSizePopupButton selectItemWithTitle:[NSString stringWithFormat:@"%li", (long)[selectedFont pointSize]]];
}

- (void) fillFontFamilies
{
    NSArray *fontFamilies = [[NSFontManager sharedFontManager] availableFontFamilies];
    
    for (NSString * fontFamily in fontFamilies) {
        [self.fontFamilyPopupButton addItemWithTitle:fontFamily];
    }
    [self.fontFamilyPopupButton selectItemWithTitle:selectedFont.familyName];
}

- (void) setImagesFoundPath:(BOOL)found
{
    [self.okImage setHidden:NO];
    [self.closeImage setHidden:NO];
    [self.okImage setWantsLayer:YES];
    [self.closeImage setWantsLayer:YES];
    [self.okImage setAlphaValue:0.0];
    [self.closeImage setAlphaValue:1.0];
    if (found) {
        [self.okImage setAlphaValue:1.0];
        [self.closeImage setAlphaValue:0.0];
    }
}


-(BOOL)isAgdaAvaliableAtPath:(NSString *)path
{
    AWCommunitacion * agdaComm = [[AWCommunitacion alloc] init];
    return [agdaComm isAgdaAvaliableAtPath:path];
    
}

- (IBAction)pathSelected:(id)sender {
    if ([sender isKindOfClass:[NSTextField class]]) {
        NSTextField * tf = (NSTextField *)sender;
        if ([self isAgdaAvaliableAtPath:tf.stringValue]) {
            [self.agdaPathTextField setStringValue:tf.stringValue];
            [AWNotifications setAgdaLaunchPath:tf.stringValue];
            
            [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
                [context setDuration:0.5f];
                [self.closeImage.animator setAlphaValue:0.0];
                [self.okImage.animator setAlphaValue:1.0];
            } completionHandler:^{
            }];

        }
        else {
            [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
                [context setDuration:0.5f];
                [self.okImage.animator setAlphaValue:0.0];
                [self.closeImage.animator setAlphaValue:1.0];
            } completionHandler:^{
                
            }];

            
        }
    }
}

- (IBAction)showNotificationChanged:(id)sender {
    NSButton * button = sender;
    if ([button state] == NSOnState) {
        [AWHelper setShowingNotifications:YES];
    }
    else {
        [AWHelper setShowingNotifications:NO];
        
    }
}

- (IBAction)fontFamilyChanged:(NSPopUpButton *)sender {
    [AWNotifications notifyFontFamilyChanged:sender.titleOfSelectedItem];
}

- (IBAction)fontSizeChanged:(NSPopUpButton *)sender {
    NSNumber * newFontSize = [[NSNumberFormatter new] numberFromString:sender.titleOfSelectedItem];
    [AWNotifications notifyFontSizeChanged:newFontSize];
}

- (IBAction)pathToLibrariesAction:(NSTextField *)sender {
    [AWHelper savePathToLibraries:sender.stringValue];
}


- (IBAction)browseAction:(NSButton *)sender {
    
    NSOpenPanel * panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:NO];
    [panel setCanChooseDirectories:NO];
    [panel setCanChooseFiles:YES];
    [panel setShowsHiddenFiles:YES];
    [panel setAllowedFileTypes:@[@""]];
    if ([panel runModal] != NSFileHandlingPanelOKButton) {
        return;
    }
    NSURL * selectedFileURL = [[panel URLs] lastObject];
//    NSLog(@"Selected File Path: %@", [selectedFileURL path]);
    if ([self isAgdaAvaliableAtPath:[selectedFileURL path]]) {
        [self.agdaPathTextField setStringValue:[selectedFileURL path]];
        [AWNotifications setAgdaLaunchPath:[selectedFileURL path]];
        
        [self setImagesFoundPath:YES];
    }
    else {
        [self setImagesFoundPath:NO];
    }
    
}

-(NSArray *)control:(NSControl *)control textView:(NSTextView *)textView completions:(NSArray *)words forPartialWordRange:(NSRange)charRange indexOfSelectedItem:(NSInteger *)index
{
    return @[];
}


-(void)setNilValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"delayForAutocomplete"]) {
        self.delayForAutocomplete = 0;
        [self.delayForAutocompleteTextField setStringValue:@"0"];
    }
}


- (IBAction)delayForAutocompleteChanged:(NSTextField *)sender {
    NSLog(@"input changed");
}

- (IBAction)showHelpForExternalLibraries:(NSButton *)sender {
    [_popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSMaxXEdge];
    // Text can be changed AFTER UI elements has been loaded!
    [_popoverViewController.contentTextField setStringValue:[AWHelper helpForExternalLibraries]];
}



@end
