import Foundation

// Prints the average Apple Silicon die temperature in °C (rounded) from the
// "PMU tdie*" HID sensors, which are readable without root. Used by plugins/temp.sh.
let iokit = dlopen("/System/Library/Frameworks/IOKit.framework/IOKit", RTLD_NOW)
func symbol<T>(_ name: String, as _: T.Type) -> T { unsafeBitCast(dlsym(iokit, name)!, to: T.self) }

let createClient = symbol("IOHIDEventSystemClientCreate", as: (@convention(c) (CFAllocator?) -> Unmanaged<AnyObject>).self)
let setMatching = symbol("IOHIDEventSystemClientSetMatching", as: (@convention(c) (AnyObject, CFDictionary) -> Int32).self)
let copyServices = symbol("IOHIDEventSystemClientCopyServices", as: (@convention(c) (AnyObject) -> Unmanaged<CFArray>?).self)
let copyProperty = symbol("IOHIDServiceClientCopyProperty", as: (@convention(c) (AnyObject, CFString) -> Unmanaged<AnyObject>?).self)
let copyEvent = symbol("IOHIDServiceClientCopyEvent", as: (@convention(c) (AnyObject, Int64, Int32, Int64) -> Unmanaged<AnyObject>?).self)
let floatValue = symbol("IOHIDEventGetFloatValue", as: (@convention(c) (AnyObject, Int32) -> Double).self)

let kIOHIDEventTypeTemperature: Int64 = 15

let client = createClient(kCFAllocatorDefault).takeRetainedValue()
_ = setMatching(client, ["PrimaryUsagePage": 0xff00, "PrimaryUsage": 5] as CFDictionary) // temperature sensors
let services = (copyServices(client)?.takeRetainedValue() as? [AnyObject]) ?? []

let temps = services.compactMap { service -> Double? in
  guard let name = copyProperty(service, "Product" as CFString)?.takeRetainedValue() as? String,
        name.hasPrefix("PMU tdie"),
        let event = copyEvent(service, kIOHIDEventTypeTemperature, 0, 0)?.takeRetainedValue() else { return nil }
  let celsius = floatValue(event, Int32(kIOHIDEventTypeTemperature << 16))
  return (1.0...150.0).contains(celsius) ? celsius : nil
}

guard !temps.isEmpty else { exit(1) }
print(Int((temps.reduce(0, +) / Double(temps.count)).rounded()))
