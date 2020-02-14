//
//  SettingsBundleHelper.swift
//  ColorPatterns
//
//  Created by Administrator on 09/07/2019.
//  Copyright © 2019 vandermesis. All rights reserved.
//

import Foundation

final class SettingsBundleHelper {
    
    class func setVersionAndBuildNumber() {
        guard let version: String = Bundle.main.object(forInfoDictionaryKey: Constants.SettingsBundleKeys.cfBundleVersionStringShort) as? String else { return }
        UserDefaults.standard.set(version, forKey: Constants.SettingsBundleKeys.appVersionKey)
        guard let build: String = Bundle.main.object(forInfoDictionaryKey: Constants.SettingsBundleKeys.cfBundleVersionString) as? String else { return }
        UserDefaults.standard.set(build, forKey: Constants.SettingsBundleKeys.buildVersionKey)
    }

    class func setSoundSettings() {
        if UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.sound) == nil {
            UserDefaults.standard.set(true, forKey: Constants.UserDefaultsKeys.sound)
        }
    }
}
