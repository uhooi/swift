// RUN: %target-swift-emit-ir -verify %s -parse-stdlib -enable-experimental-feature Embedded -target arm64e-apple-none

public class MyClass {
  func foo<T>(t: T) { } // expected-error {{classes cannot have non-final generic fuctions in embedded Swift}}
  func bar() { }
}
