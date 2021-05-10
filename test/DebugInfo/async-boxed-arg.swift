// RUN: %target-swift-frontend %s -emit-ir -g -o - -parse-as-library \
// RUN:    -module-name M -enable-experimental-concurrency | %FileCheck %s --dump-input always
// REQUIRES: concurrency

@available(SwiftStdlib 5.5, *)
extension Collection where Element: Sendable {
  public func f() async throws {
    return try await withThrowingTaskGroup(of: Element.self) { group in
      var i = self.startIndex
      func doit() async throws {
        group.spawn { [i] in
          return self[i]
        }
      }
      try await doit()
    }
  }
}

// CHECK: ![[BOXTY:[0-9]+]] = !DICompositeType(tag: DW_TAG_structure_type, name: "$s5IndexSlQzz_x_SlRzs8Sendable7ElementSTRpzlXXD"
// CHECK: !DILocalVariable(name: "i", arg: 3, {{.*}}type: ![[BOXTY]]
