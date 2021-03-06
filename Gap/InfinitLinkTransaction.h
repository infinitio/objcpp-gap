//
//  InfinitLinkTransaction.h
//  Gap
//
//  Created by Christopher Crone on 13/11/14.
//
//

#import <Foundation/Foundation.h>

#import "InfinitTransaction.h"

@interface InfinitLinkTransaction : InfinitTransaction

@property (nonatomic, readonly) NSNumber* click_count;
@property (nonatomic, readonly) NSString* link;
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) BOOL screenshot;

- (instancetype)initWithId:(NSNumber*)id_
                   meta_id:(NSString*)meta_id
                    status:(gap_TransactionStatus)status
             sender_device:(NSString*)sender_device
                      name:(NSString*)name
                     mtime:(NSTimeInterval)mtime
                      hash:(NSString*)hash
                      link:(NSString*)link
               click_count:(NSNumber*)click_count
                   message:(NSString*)message
                      size:(NSNumber*)size
                screenshot:(BOOL)screenshot
               status_info:(gap_Status)status_info;

- (void)updateWithTransaction:(InfinitLinkTransaction*)transaction;

@end
