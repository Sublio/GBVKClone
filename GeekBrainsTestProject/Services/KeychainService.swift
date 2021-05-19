//
//  KeyChainsManager.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 16.05.2021.
//

import Foundation
import Security

// Arguments for the keychain queries
let kSecClassValue = NSString(format: kSecClass)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

class KeychainService: NSObject {

    class func removeToken(service: String) {

           // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, kCFBooleanTrue as Any], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecReturnDataValue])

           // Delete any existing items
           let status = SecItemDelete(keychainQuery as CFDictionary)
           if status != errSecSuccess {
               if let err = SecCopyErrorMessageString(status, nil) {
                   print("Remove failed: \(err)")
               }
           }

       }

    class func saveToken(service: String, data: String) {
            if let dataFromString = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {

                // Instantiate a new default keychain query
                let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecValueDataValue])

                // Add the new keychain item
                let status = SecItemAdd(keychainQuery as CFDictionary, nil)

                if status != errSecSuccess {    // Always check the status
                    if let err = SecCopyErrorMessageString(status, nil) {
                        print("Write failed: \(err)")
                    }
                }
            }
        }

    class func loadToken(service: String) -> String? {
            // Instantiate a new default keychain query
            // Tell the query to return a result
            // Limit our results to one item
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, kCFBooleanTrue as Any, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecReturnDataValue, kSecMatchLimitValue])

            var dataTypeRef: AnyObject?

            // Search for the keychain items
            let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
            var contentsOfKeychain: String?

            if status == errSecSuccess {
                if let retrievedData = dataTypeRef as? Data {
                    contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
                }
            } else {
                print("Nothing was retrieved from the keychain. Status code \(status)")
            }

            return contentsOfKeychain
        }

}
