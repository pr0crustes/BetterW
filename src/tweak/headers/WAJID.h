@interface WAJID : NSObject {
        NSString *_user;
        unsigned long long _domain;
    }

    @property(readonly) unsigned long long domain;
    @property(readonly, copy) NSString *user;
    @property(readonly, getter=isUserValid) _Bool userValid;
    @property(readonly, copy) NSString *stringRepresentation;

    - (id)initWithStringRepresentation:(id)arg1;
    - (id)initWithUser:(id)arg1 domain:(unsigned long long)arg2;

@end