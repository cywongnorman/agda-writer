 //
//  PreferencesGeneralController.h
//  Agda Writer
//
//  Created by Marko Koležnik on 25. 07. 15.
//  Copyright (c) 2015 koleznik.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferencesGeneralController : NSViewController
@property (weak) IBOutlet NSTextField *agdaPathTextField;
@property (weak) IBOutlet NSImageView *okImage;
@property (weak) IBOutlet NSImageView *closeImage;
- (IBAction)pathSelected:(id)sender;
@property (weak) IBOutlet NSPopUpButton *fontFamilyPopupButton;
@property (weak) IBOutlet NSPopUpButton *fontSizePopupButton;
@property (weak) IBOutlet NSButton *showsNotifications;

- (IBAction)showNotificationChanged:(id)sender;
- (IBAction)fontFamilyChanged:(NSPopUpButton *)sender;

- (IBAction)fontSizeChanged:(NSPopUpButton *)sender;

- (IBAction)browseAction:(NSButton *)sender;
@end