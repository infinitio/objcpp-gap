//
//  NSNotificationCenter+Debug.m
//  Gap
//
//  Created by Christopher Crone on 01/06/15.
//
//

#ifdef DEBUG

# import "NSNotificationCenter+Debug.h"

# import "InfinitThreadSafeDictionary.h"

# import <objc/runtime.h>

static
void
swizzle_class_selector(Class class, SEL original_sel, SEL swizzled_sel)
{
  Method original_meth = class_getInstanceMethod(class, original_sel);
  Method swizzled_meth = class_getInstanceMethod(class, swizzled_sel);
  BOOL did_add = class_addMethod(class,
                                 original_sel,
                                 method_getImplementation(swizzled_meth),
                                 method_getTypeEncoding(swizzled_meth));
  if (did_add)
  {
    class_replaceMethod(class,
                        swizzled_sel,
                        method_getImplementation(original_meth),
                        method_getTypeEncoding(original_meth));
  }
  else
  {
    method_exchangeImplementations(original_meth, swizzled_meth);
  }
}

static dispatch_once_t _load_token = 0;
static InfinitThreadSafeDictionary* _observer_map;

@implementation NSNotificationCenter (infinit_Debug)

+ (void)load
{
  dispatch_once(&_load_token, ^
  {
    SEL original_add_observer_sel = @selector(addObserver:selector:name:object:);
    SEL swizzled_add_observer_sel = @selector(infinit_addObserver:selector:name:object:);
    swizzle_class_selector(self.class, original_add_observer_sel, swizzled_add_observer_sel);

    SEL original_post_sel = @selector(postNotificationName:object:userInfo:);
    SEL swizzled_post_sel = @selector(infinit_postNotificationName:object:userInfo:);
    swizzle_class_selector(self.class, original_post_sel, swizzled_post_sel);
    _observer_map =
      [InfinitThreadSafeDictionary dictionaryWithName:@"io.Infinit.NSNotificationCenter-Observers"
                                      withNillSupport:YES];
  });
}

- (NSArray*)observersForNotificationWithName:(NSString*)name
{
  return _observer_map[name];
}

# pragma mark - Swizzled

- (void)infinit_addObserver:(id)observer
                   selector:(SEL)aSelector
                       name:(NSString*)aName
                     object:(id)anObject
{
  [self infinit_addObserver:observer selector:aSelector name:aName object:anObject];
  NSMutableArray* observers = _observer_map[aName];
  if (!observers)
    observers = [NSMutableArray array];
  __weak id weak_observer = observer;
  [observers addObject:weak_observer];
  _observer_map[aName] = observers;
}

- (void)infinit_postNotificationName:(NSString*)aName
                              object:(id)anObject
                            userInfo:(NSDictionary*)aUserInfo
{
  [self infinit_postNotificationName:aName object:anObject userInfo:aUserInfo];
//  if ([aName containsString:@"INFINIT"])
//  {
//    NSLog(@"xxx posting: %@", aName);
//    for (id observer in _observer_map[aName])
//      NSLog(@"xxx\t\tto %@", observer);
//  }
}

@end

#endif
