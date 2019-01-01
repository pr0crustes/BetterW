@interface XMPPPresenceStanza : NSObject
    // Creates an instance with given presence and nickname, Used to inform online state.
    +(id)stanzaWithPresence:(unsigned long long)arg1 nickname:(id)arg2;
@end
