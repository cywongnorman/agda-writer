//
//  ViewController.h
//  Agda Writer
//
//  Created by Marko Koležnik on 15. 07. 15.
//  Copyright (c) 2015 koleznik.net. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "AWCommunitacion.h"
#import "AWAgdaActions.h"
#import "AWToastWindow.h"
#import "AWMainTextView.h"
#import "Document.h"
#import "AWGoalsTableController.h"
#import "AWStatusTextView.h"
#import "AWInputWindow.h"
#import "MAAttachedWindow.h"
#import "AWInputViewController.h"


@class AgdaGoal;

@interface ViewController : NSViewController <NSApplicationDelegate, NSTextViewDelegate, NSTextDelegate, NSTableViewDataSource, NSTableViewDelegate, AWInputDelegate>
{
    Document * document;
}

@property (unsafe_unretained) IBOutlet AWMainTextView *mainTextView;

@property (strong) IBOutlet AWGoalsTableController *goalsTableController;

@property (unsafe_unretained) IBOutlet AWStatusTextView *statusTextView;



@property IBOutlet NSTextView *lineNumbersView;
@property AWToastWindow * toastView;
@property MAAttachedWindow * inputWindow;
@property AWInputViewController * inputViewController;
@property (weak) IBOutlet NSTextField *lastStatusTextField;

- (IBAction)hideOutputs:(id)sender;

- (IBAction)AddToken:(NSButton *)sender;

#pragma mark -
#pragma mark Global actions

// Global actions
- (IBAction)actionLoad:(id)sender;
- (IBAction)actionQuitAndRestartAgda:(NSMenuItem *)sender;
- (IBAction)actionQuit:(NSMenuItem *)sender;
// Goal specific actions
#pragma mark Goal specific actions
- (IBAction)actionGive:(NSMenuItem *)sender;
- (IBAction)actionRefine:(id)sender;
- (IBAction)actionAuto:(NSMenuItem *)sender;
- (IBAction)actionCase:(NSMenuItem *)sender;
- (IBAction)actionGoalType:(NSMenuItem *)sender;
- (IBAction)actionContextEnvironment:(NSMenuItem *)sender;
- (IBAction)actionGoalTypeAndContext:(NSMenuItem *)sender;
- (IBAction)actionGoalTypeAndInferredType:(NSMenuItem *)sender;
- (IBAction)actionComputeNormalForm:(NSMenuItem *)sender;
- (IBAction)actionNormalize:(id)sender;
- (IBAction)actionNormalizeGoal:(id)sender;

#pragma mark -
- (IBAction)applyUnicodeTransformation:(id)sender;




@end

