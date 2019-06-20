//
//  main.swift
//  Challenge2
//
//  Created by Paulo Andrade on 15/06/2019.
//  Copyright © 2019 Paulo Andrade. All rights reserved.
//

/* For reference, the syntax of your module.modulemap file should look like this
 module MyModule {
    header "include/someheader.h"
    export *
 }
 */


import Foundation
// 1 Start by exposing libsodium to Swift and then uncomment the following line replacing Module_Name with the name you chose on your module map

// import Module_Name

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


// 2 Now we need get some pointers to the memory of the key, nonce and cipherText.
// Tip: You can either allocate a new memory chunk and copy the bytes there using Data.copyBytes or use the Data.withUnsafeBytes function.


// 3 You also need some space to store the decrypted message
//let messageLength = cipherText.count - Int(crypto_secretbox_MACBYTES)
//let messagePtr = UnsafeMutablePointer<UInt8>.allocate(capacity: messageLength)
//defer {
//    messagePtr.deallocate()
//}

// 4 Finally you can call into C
// the function you're looking for is crypto_secretbox_open_easy
