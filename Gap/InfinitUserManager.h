//
//  InfinitUserManager.h
//  Infinit
//
//  Created by Christopher Crone on 31/10/14.
//  Copyright (c) 2014 Christopher Crone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "InfinitUser.h"

/** Notification sent when there is a new user added to the model.
 Includes dictionary with the user "id".
 */
#define INFINIT_NEW_USER_NOTIFICATION     @"INFINIT_NEW_USER_NOTIFICATION"

/** Notification sent when an existing user's status has changed.
 Includes dictionary with the user "id".
 */
#define INFINIT_USER_STATUS_NOTIFICATION  @"INFINIT_USER_STATUS_NOTIFICATION"

/** Notification sent when an existing user is deleted.
 Includes dictionary with the user "id".
 */
#define INFINIT_USER_DELETED_NOTIFICATION @"INFINIT_USER_DELETED_NOTIFICATION"

/** Notification sent when an address book contact joined.
 Includes dictionary with the user "id" and "contact" identifier (email currently).
 */
#define INFINIT_CONTACT_JOINED_NOTIFICATION @"INFINIT_CONTACT_JOINED_NOTIFICATION"

@interface InfinitUserManager : NSObject

+ (instancetype)sharedInstance;

/** Returns currently logged in user.
 @return Currently logged in user.
 */
- (InfinitUser*)me;

/** Return list of users that the user has previously been involved in a share with
 (alphabetical order).
 @return An array of users.
 */
- (NSArray*)alphabetical_swaggers;

/** Return list of users that the user has previously been involved in a share with
  (time order).
 @return An array of users.
 */
- (NSArray*)time_ordered_swaggers;

/** Return list of user's favorites.
 @return An array of users.
 */
- (NSArray*)favorites;

/** Add favorite.
 Add a user as a favorite.
 @param user
  User to add as a favorite.
 */
- (void)addFavorite:(InfinitUser*)user;

/** Remove favorite.
 Remove a user as a favorite.
 @param user
  User to remove as a favorite.
 */
- (void)removeFavorite:(InfinitUser*)user;

/** User with corresponding ID.
 @param id_
  User ID.
 @return User with corresponding ID.
 */
+ (InfinitUser*)userWithId:(NSNumber*)id_;

/** User with corresponding ID.
 @param id_
  User ID.
 @return User with corresponding ID.
 */
- (InfinitUser*)userWithId:(NSNumber*)id_;

/** User locally in model with corresponding Meta ID.
 @param meta_id
  User's Meta ID.
 @return The corresponding user or nil.
 */
- (InfinitUser*)localUserWithMetaId:(NSString*)meta_id;

/** Search in the local user map for users.
 @param text
  Search text.
 @return Array of users.
 */
- (NSArray*)searchLocalUsers:(NSString*)text;


#pragma mark - State Manager Callbacks
- (void)updateUser:(InfinitUser*)user;
- (void)userWithId:(NSNumber*)id_
     statusUpdated:(BOOL)status;
- (void)userDeletedWithId:(NSNumber*)id_;
- (void)contactJoined:(NSNumber*)id_
              contact:(NSString*)contact;

@end
