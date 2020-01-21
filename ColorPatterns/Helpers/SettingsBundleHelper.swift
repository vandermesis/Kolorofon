//
//  SettingsBundleHelper.swift
//  ColorPatterns
//
//  Created by Administrator on 09/07/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

final class SettingsBundleHelper {
    
    struct SettingsBundleKeys {
        static let BuildVersionKey = "build_preference"
        static let AppVersionKey = "version_preference"
    }
    
    class func setVersionAndBuildNumber() {
        guard let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else { return }
        UserDefaults.standard.set(version, forKey: "version_preference")
        guard let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else { return }
        UserDefaults.standard.set(build, forKey: "build_preference")
    }
}
