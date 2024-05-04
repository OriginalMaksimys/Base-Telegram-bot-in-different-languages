objective-c
#import <Foundation/Foundation.h>

NSString *const EXIT_COMMAND = @"exit";

@interface PRBot : NSObject
@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign) BOOL clearUpdatesOnStart;
@property (nonatomic, strong) NSArray<NSNumber *> *whiteListUsers;
@property (nonatomic, strong) NSArray<NSNumber *> *admins;
@property (nonatomic, assign) NSInteger botId;

- (void)start;
@end

@interface PRBot (Logging)
- (void)logErrorWithException:(NSException *)exception forId:(nullable NSNumber *)id;
- (void)logCommonWithMessage:(NSString *)message eventType:(NSEnum)typeEvent color:(NSColor *)color;
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        PRBot *telegram = [[PRBot alloc] init];
        telegram.token = @"";
        telegram.clearUpdatesOnStart = YES;
        telegram.whiteListUsers = @[@0];
        telegram.admins = @[@0];
        telegram.botId = 0;
        
        [telegram start];
        
        while (true) {
            NSString *result = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:@"/dev/stdin"] encoding:NSUTF8StringEncoding];
            if ([result.lowercaseString isEqualToString:EXIT_COMMAND]) {
                exit(0);
            }
        }
    }
    return 0;
}

