//
//  DeviceModel.swift
//  DeviceModel-Swift
//
//  Created by deblur99 on 2024/06/05.
//

import Foundation
import UIKit

// Usage
// 1) Returns an enumeration instance of the currently running device: DeviceModel.type
// 2) Returns the actual model name as a string: DeviceModel.type.rawValue
public extension UIDevice {
    static var type: DeviceModel {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String(validatingUTF8: ptr)
            }
        }

        if let modelCode, let model = modelMap[modelCode] {
            if model != .simulator {
                return model
            } else {
                // If the model name is a simulator, fetch the model name from the simulator's environment variables and return that model name instead
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"],
                   let simModel = modelMap[simModelCode]
                {
                    return simModel
                } else {
                    return .unknown
                }
            }
        } else {
            return .unknown
        }
    }
}

// MARK: UIDevice extensions

public extension UIDevice {
    static let modelMap: [String: DeviceModel] = [
        // Simulator
        "i386": .simulator,
        "x86_64": .simulator,
        "arm64": .simulator,

        // iPad
        "iPad1,1": .iPad,
        "iPad2,1": .iPad2,
        "iPad2,2": .iPad2,
        "iPad2,3": .iPad2,
        "iPad2,4": .iPad2,
        "iPad3,1": .iPad3,
        "iPad3,2": .iPad3,
        "iPad3,3": .iPad3,
        "iPad3,4": .iPad4,
        "iPad3,5": .iPad4,
        "iPad3,6": .iPad4,
        "iPad6,11": .iPad5,
        "iPad6,12": .iPad5,
        "iPad7,5": .iPad6,
        "iPad7,6": .iPad6,
        "iPad7,11": .iPad7,
        "iPad7,12": .iPad7,
        "iPad11,6": .iPad8,
        "iPad11,7": .iPad8,
        "iPad12,1": .iPad9,
        "iPad12,2": .iPad9,
        "iPad13,18": .iPad10,
        "iPad13,19": .iPad10,

        // iPad Air
        "iPad4,1": .iPadAir,
        "iPad4,2": .iPadAir,
        "iPad4,3": .iPadAir,
        "iPad5,3": .iPadAir2,
        "iPad5,4": .iPadAir2,
        "iPad11,3": .iPadAir3,
        "iPad11,4": .iPadAir3,
        "iPad13,1": .iPadAir4,
        "iPad13,2": .iPadAir4,
        "iPad13,16": .iPadAir5,
        "iPad13,17": .iPadAir5,
        "iPad14,8": .iPadAir_11_M2, // .Model_Inch_Processor
        "iPad14,9": .iPadAir_11_M2,
        "iPad14,10": .iPadAir_13_M2,
        "iPad14,11": .iPadAir_13_M2,

        // iPad Pro
        "iPad6,3": .iPadPro9_7,
        "iPad6,4": .iPadPro9_7,
        "iPad6,7": .iPadPro12_9,
        "iPad6,8": .iPadPro12_9,
        "iPad7,1": .iPadPro2_12_9,
        "iPad7,2": .iPadPro2_12_9,
        "iPad7,3": .iPadPro10_5,
        "iPad7,4": .iPadPro10_5,
        "iPad8,1": .iPadPro11,
        "iPad8,2": .iPadPro11,
        "iPad8,3": .iPadPro11,
        "iPad8,4": .iPadPro11,
        "iPad8,5": .iPadPro3_12_9,
        "iPad8,6": .iPadPro3_12_9,
        "iPad8,7": .iPadPro3_12_9,
        "iPad8,8": .iPadPro3_12_9,
        "iPad8,9": .iPadPro2_11,
        "iPad8,10": .iPadPro2_11,
        "iPad8,11": .iPadPro4_12_9,
        "iPad8,12": .iPadPro4_12_9,
        "iPad13,4": .iPadPro3_11,
        "iPad13,5": .iPadPro3_11,
        "iPad13,6": .iPadPro3_11,
        "iPad13,7": .iPadPro3_11,
        "iPad13,8": .iPadPro5_12_9,
        "iPad13,9": .iPadPro5_12_9,
        "iPad13,10": .iPadPro5_12_9,
        "iPad13,11": .iPadPro5_12_9,
        "iPad14,3": .iPadPro4_11,
        "iPad14,4": .iPadPro4_11,
        "iPad14,5": .iPadPro6_12_9,
        "iPad14,6": .iPadPro6_12_9,
        "iPad16,3": .iPadPro_11_M4,
        "iPad16,4": .iPadPro_11_M4,
        "iPad16,5": .iPadPro_13_M4,
        "iPad16,6": .iPadPro_13_M4,

        // iPad mini
        "iPad2,5": .iPadMini,
        "iPad2,6": .iPadMini,
        "iPad2,7": .iPadMini,
        "iPad4,4": .iPadMini2,
        "iPad4,5": .iPadMini2,
        "iPad4,6": .iPadMini2,
        "iPad4,7": .iPadMini3,
        "iPad4,8": .iPadMini3,
        "iPad4,9": .iPadMini3,
        "iPad5,1": .iPadMini4,
        "iPad5,2": .iPadMini4,
        "iPad11,1": .iPadMini5,
        "iPad11,2": .iPadMini5,
        "iPad14,1": .iPadMini6,
        "iPad14,2": .iPadMini6,

        // iPhone
        "iPhone1,1": .iPhone1,
        "iPhone1,2": .iPhone3G,
        "iPhone2,1": .iPhone3GS,
        "iPhone3,1": .iPhone4,
        "iPhone3,2": .iPhone4,
        "iPhone3,3": .iPhone4,
        "iPhone4,1": .iPhone4S,
        "iPhone5,1": .iPhone5,
        "iPhone5,2": .iPhone5,
        "iPhone5,3": .iPhone5C,
        "iPhone5,4": .iPhone5C,
        "iPhone6,1": .iPhone5S,
        "iPhone6,2": .iPhone5S,
        "iPhone7,1": .iPhone6Plus,
        "iPhone7,2": .iPhone6,
        "iPhone8,1": .iPhone6S,
        "iPhone8,2": .iPhone6SPlus,
        "iPhone8,4": .iPhoneSE,
        "iPhone9,1": .iPhone7,
        "iPhone9,3": .iPhone7,
        "iPhone9,2": .iPhone7Plus,
        "iPhone9,4": .iPhone7Plus,
        "iPhone10,1": .iPhone8,
        "iPhone10,4": .iPhone8,
        "iPhone10,2": .iPhone8Plus,
        "iPhone10,5": .iPhone8Plus,
        "iPhone10,3": .iPhoneX,
        "iPhone10,6": .iPhoneX,
        "iPhone11,2": .iPhoneXS,
        "iPhone11,4": .iPhoneXSMax,
        "iPhone11,6": .iPhoneXSMax,
        "iPhone11,8": .iPhoneXR,
        "iPhone12,1": .iPhone11,
        "iPhone12,3": .iPhone11Pro,
        "iPhone12,5": .iPhone11ProMax,
        "iPhone12,8": .iPhoneSE2,
        "iPhone13,1": .iPhone12Mini,
        "iPhone13,2": .iPhone12,
        "iPhone13,3": .iPhone12Pro,
        "iPhone13,4": .iPhone12ProMax,
        "iPhone14,2": .iPhone13Pro,
        "iPhone14,3": .iPhone13ProMax,
        "iPhone14,4": .iPhone13Mini,
        "iPhone14,5": .iPhone13,
        "iPhone14,6": .iPhoneSE3,
        "iPhone14,7": .iPhone14,
        "iPhone14,8": .iPhone14Plus,
        "iPhone15,2": .iPhone14Pro,
        "iPhone15,3": .iPhone14ProMax,
        "iPhone15,4": .iPhone15,
        "iPhone15,5": .iPhone15Plus,
        "iPhone16,1": .iPhone15Pro,
        "iPhone16,2": .iPhone15ProMax,

        // Apple TV
        "AppleTV1,1": .AppleTV1,
        "AppleTV2,1": .AppleTV2,
        "AppleTV3,1": .AppleTV3,
        "AppleTV3,2": .AppleTV3,
        "AppleTV5,3": .AppleTV_HD,
        "AppleTV6,2": .AppleTV_4K,
        "AppleTV11,1": .AppleTV_4K2,
        "AppleTV14,1": .AppleTV_4K3,

        // Apple Vision
        "RealityDevice14,1": .AppleVisionPro,

        // iPod
        "iPod1,1": .iPod1,
        "iPod2,1": .iPod2,
        "iPod3,1": .iPod3,
        "iPod4,1": .iPod4,
        "iPod5,1": .iPod5,
        "iPod7,1": .iPod6,
        "iPod9,1": .iPod7,
    ]
}

public enum DeviceModel: String, Codable {
    // Simulator
    case simulator = "simulator/sandbox"

    // iPad
    case iPad
    case iPad2 = "iPad 2"
    case iPad3 = "iPad (3rd generation)"
    case iPad4 = "iPad (4th generation)"
    case iPad5 = "iPad (5th generation)"
    case iPad6 = "iPad (6th generation)" // iPad 2018
    case iPad7 = "iPad (7th generation)" // iPad 2019
    case iPad8 = "iPad (8th generation)" // iPad 2020
    case iPad9 = "iPad (9th generation)" // iPad 2021
    case iPad10 = "iPad (10th generation)" // iPad 2022

    // iPad Air
    case iPadAir = "iPad Air"
    case iPadAir2 = "iPad Air 2"
    case iPadAir3 = "iPad Air (3rd generation)"
    case iPadAir4 = "iPad Air (4th generation)"
    case iPadAir5 = "iPad Air (5th generation)"
    case iPadAir_11_M2 = "iPad Air 11-inch (M2)"
    case iPadAir_13_M2 = "iPad Air 13-inch (M2)"

    // iPad Pro
    case iPadPro9_7 = "iPad Pro (9.7-inch)"
    case iPadPro12_9 = "iPad Pro (12.9-inch)"
    case iPadPro2_12_9 = "iPad Pro (12.9-inch) (2nd generation)"
    case iPadPro10_5 = "iPad Pro (10.5-inch)"
    case iPadPro11 = "iPad Pro (11-inch)"
    case iPadPro3_12_9 = "iPad Pro (12.9-inch) (3rd generation)"
    case iPadPro2_11 = "iPad Pro (11-inch) (2nd generation)"
    case iPadPro4_12_9 = "iPad Pro (12.9-inch) (4th generation)"
    case iPadPro3_11 = "iPad Pro (11-inch) (3rd generation)"
    case iPadPro5_12_9 = "iPad Pro (12.9-inch) (5th generation)"
    case iPadPro4_11 = "iPad Pro (11-inch) (4th generation)"
    case iPadPro6_12_9 = "iPad Pro (12.9-inch) (6th generation)"
    case iPadPro_11_M4 = "iPad Pro 11-inch (M4)"
    case iPadPro_13_M4 = "iPad Pro 13-inch (M4)"

    // iPad mini
    case iPadMini = "iPad mini"
    case iPadMini2 = "iPad mini 2"
    case iPadMini3 = "iPad mini 3"
    case iPadMini4 = "iPad mini 4"
    case iPadMini5 = "iPad mini (5th generation)"
    case iPadMini6 = "iPad mini (6th generation)"

    // iPhone
    case iPhone1 = "iPhone"
    case iPhone3G = "iPhone 3G"
    case iPhone3GS = "iPhone 3GS"
    case iPhone4 = "iPhone 4"
    case iPhone4S = "iPhone 4S"
    case iPhone5 = "iPhone 5"
    case iPhone5S = "iPhone 5S"
    case iPhone5C = "iPhone 5C"
    case iPhone6 = "iPhone 6"
    case iPhone6Plus = "iPhone 6 Plus"
    case iPhone6S = "iPhone 6S"
    case iPhone6SPlus = "iPhone 6S Plus"
    case iPhoneSE = "iPhone SE"
    case iPhone7 = "iPhone 7"
    case iPhone7Plus = "iPhone 7 Plus"
    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"
    case iPhoneX = "iPhone X"
    case iPhoneXS = "iPhone XS"
    case iPhoneXSMax = "iPhone XS Max"
    case iPhoneXR = "iPhone XR"
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPhoneSE2 = "iPhone SE (2nd generation)"
    case iPhone12Mini = "iPhone 12 Mini"
    case iPhone12 = "iPhone 12"
    case iPhone12Pro = "iPhone 12 Pro"
    case iPhone12ProMax = "iPhone 12 Pro Max"
    case iPhone13Mini = "iPhone 13 Mini"
    case iPhone13 = "iPhone 13"
    case iPhone13Pro = "iPhone 13 Pro"
    case iPhone13ProMax = "iPhone 13 Pro Max"
    case iPhoneSE3 = "iPhone SE (3rd generation)"
    case iPhone14 = "iPhone 14"
    case iPhone14Plus = "iPhone 14 Plus"
    case iPhone14Pro = "iPhone 14 Pro"
    case iPhone14ProMax = "iPhone 14 Pro Max"
    case iPhone15 = "iPhone 15"
    case iPhone15Plus = "iPhone 15 Plus"
    case iPhone15Pro = "iPhone 15 Pro"
    case iPhone15ProMax = "iPhone 15 Pro Max"

    // Apple TV
    case AppleTV1 = "Apple TV (1st generation)"
    case AppleTV2 = "Apple TV (2nd generation)"
    case AppleTV3 = "Apple TV (3rd generation)"
    case AppleTV_HD = "Apple TV HD"
    case AppleTV_4K = "Apple TV 4K"
    case AppleTV_4K2 = "Apple TV 4K (2nd generation)"
    case AppleTV_4K3 = "Apple TV 4K (3rd generation)"

    // Apple Vision
    case AppleVisionPro = "Apple Vision Pro"

    // iPod
    case iPod1 = "iPod touch"
    case iPod2 = "iPod touch (2nd generation)"
    case iPod3 = "iPod touch (3rd generation)"
    case iPod4 = "iPod touch (4th generation)"
    case iPod5 = "iPod touch (5th generation)"
    case iPod6 = "iPod touch (6th generation)"
    case iPod7 = "iPod touch (7th generation)"

    // Unknown
    case unknown = "Unknown Device"
}
