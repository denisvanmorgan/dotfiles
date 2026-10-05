import Foundation
import IOKit

// Prints "<rpm> <percent of max>" for the fastest fan, read from the SMC (no root needed):
// FNum = fan count, F<n>Ac = actual rpm, F<n>Mx = max rpm (floats on Apple Silicon).
// Used by plugins/fan.sh.

// Field offsets in the 80-byte SMCKeyData_t struct exchanged with the AppleSMC user client
let keyOffset = 0, dataSizeOffset = 28, resultOffset = 40, commandOffset = 42, bytesOffset = 48
let readKeyInfo: UInt8 = 9, readBytes: UInt8 = 5

var connection: io_connect_t = 0
let smc = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("AppleSMC"))
guard IOServiceOpen(smc, mach_task_self_, 0, &connection) == kIOReturnSuccess else { exit(1) }

func smcCall(_ input: [UInt8]) -> [UInt8]? {
  var input = input, output = [UInt8](repeating: 0, count: 80), size = 80
  guard IOConnectCallStructMethod(connection, 2, &input, 80, &output, &size) == kIOReturnSuccess,
        output[resultOffset] == 0 else { return nil }
  return output
}

func read(_ key: String) -> [UInt8]? {
  var input = [UInt8](repeating: 0, count: 80)
  withUnsafeBytes(of: key.utf8.reduce(UInt32(0)) { $0 << 8 | UInt32($1) }) {
    input.replaceSubrange(keyOffset..<keyOffset + 4, with: $0)
  }
  input[commandOffset] = readKeyInfo
  guard let info = smcCall(input) else { return nil }
  let sizeField = info[dataSizeOffset..<dataSizeOffset + 4]
  input.replaceSubrange(dataSizeOffset..<dataSizeOffset + 4, with: sizeField)
  input[commandOffset] = readBytes
  guard let output = smcCall(input) else { return nil }
  let size = Int(sizeField.withUnsafeBytes { $0.loadUnaligned(as: UInt32.self) })
  return Array(output[bytesOffset..<bytesOffset + size])
}

func float(_ key: String) -> Float? {
  guard let bytes = read(key), bytes.count == 4 else { return nil }
  return bytes.withUnsafeBytes { $0.loadUnaligned(as: Float.self) }
}

let fans = (0..<Int(read("FNum")?.first ?? 0)).compactMap { i -> (rpm: Float, max: Float)? in
  guard let rpm = float("F\(i)Ac"), let max = float("F\(i)Mx"), max > 0 else { return nil }
  return (rpm, max)
}
guard let fastest = fans.max(by: { $0.rpm < $1.rpm }) else { exit(1) }
print(Int(fastest.rpm.rounded()), Int((fastest.rpm / fastest.max * 100).rounded()))
