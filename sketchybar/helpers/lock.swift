import Foundation

// Locks the screen right away, independent of the "require password after
// display is turned off" delay. Built by items/apple.sh on first config load.
guard let handle = dlopen("/System/Library/PrivateFrameworks/login.framework/Versions/Current/login", RTLD_NOW),
      let symbol = dlsym(handle, "SACLockScreenImmediate") else { exit(1) }

typealias LockScreenImmediate = @convention(c) () -> Int32
exit(unsafeBitCast(symbol, to: LockScreenImmediate.self)() == 0 ? 0 : 1)
