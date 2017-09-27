//
//  ViewIBDebugLogger.swift
//  PredixMobileUIKit
//
//  Created by Johns, Andy (GE Corporate) on 9/22/17.
//  Copyright © 2017 GE. All rights reserved.
//

import Foundation


extension UIView {
    public func liveDebugLog(_ message: String) {
        #if TARGET_INTERFACE_BUILDER
            let logPath = "/tmp/XcodeLiveRendering.log"
            if !FileManager.default.fileExists(atPath: logPath) {
                FileManager.default.createFile(atPath: logPath, contents: Data(), attributes: nil)
            }
            
            if let fileHandle = FileHandle(forWritingAtPath: logPath) {
                fileHandle.seekToEndOfFile()
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                let bundle = Bundle(for: type(of: self))
                let application = bundle.object(forInfoDictionaryKey: "CFBundleName") ?? ""
                let data = "\(formatter.string(from: Date())) \(application) \(message)\n".data(using: .utf8, allowLossyConversion: true) ?? Data()
                fileHandle.write(data)
            }
        #endif
    }
}
