import Foundation

struct Foo {
    let a: UInt8
    let b: UInt16
}

let size = MemoryLayout<Foo>.size
let alignment = MemoryLayout<Foo>.alignment

let rawPtr = UnsafeMutableRawPointer.allocate(byteCount: size,
                                              alignment: alignment)

rawPtr.storeBytes(of: 42, toByteOffset: 0, as: UInt8.self)
rawPtr.storeBytes(of: 4321, toByteOffset: 2, as: UInt16.self)

let foo = rawPtr.load(as: Foo.self)
rawPtr.deallocate()
print(foo) // Foo(a: 42, b: 4321)

