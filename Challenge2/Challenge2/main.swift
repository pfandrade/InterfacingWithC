//
//  main.swift
//  Challenge2
//
//  Created by Paulo Andrade on 15/06/2019.
//  Copyright © 2019 Paulo Andrade. All rights reserved.
//

import Foundation
import Clibsodium

let base64Key           = "RlTBmTMO20iht3rMPrZxJoqx+2xYmFKC3zcchQus9QM="
let base64Nonce         = "Gl2qCKBO7Bf6PhQKX8u63a8KAWwBWxYf"
let base64CipherText    = """
dpoMuV+aQm+X0DtNEPh0jnjpCVZRc1aJOfp9Ltk1qbblvgO4av5KTsugkM4Xu4cu
Pt5b4NPuBQAXCDvMqNp792jEC/flzTYoRmSWnUC8nykcuYQn6as2x17lwDE0DTh5
Bu+4g4HWROmuAQ0MZoGT8ClKxuLQJUvzHw3RrzbfZOyslNKEm03aVNM6v1ayxEXA
3Fo73tSpTsD72KscTe2U+4m+hNc3ahRSJg==
"""

let key = Data(base64Encoded: base64Key)!
let nonce = Data(base64Encoded: base64Nonce)!
let cipherText = Data(base64Encoded: base64CipherText, options: .ignoreUnknownCharacters)!

let keyPtr = UnsafeMutablePointer<UInt8>.allocate(capacity: key.count)
defer {
    keyPtr.deallocate()
}
key.copyBytes(to: keyPtr, count: key.count)

let noncePtr = UnsafeMutablePointer<UInt8>.allocate(capacity: nonce.count)
defer {
    noncePtr.deallocate()
}
nonce.copyBytes(to: noncePtr, count: nonce.count)


let messageLength = cipherText.count - Int(crypto_secretbox_MACBYTES)
let messagePtr = UnsafeMutablePointer<UInt8>.allocate(capacity: messageLength)
defer {
    messagePtr.deallocate()
}

let success = cipherText.withUnsafeBytes { (buffer: UnsafeRawBufferPointer) -> Bool in
    let c = buffer.bindMemory(to: UInt8.self).baseAddress!
    return crypto_secretbox_open_easy(messagePtr, c, UInt64(cipherText.count), noncePtr, keyPtr) == 0
}

guard success else {
    exit(1)
}

let messageData = Data(bytes: messagePtr, count: messageLength)
if let message = String(data: messageData, encoding: .utf8) {
    print(message)
}


