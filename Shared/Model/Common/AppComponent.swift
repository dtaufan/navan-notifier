//
//  AppComponent.swift
//  Notification Agent
//
//  Created by Simone Martorelli on 25/06/2021.
//  Copyright © 2021 IBM Inc. All rights reserved.
//  SPDX-License-Identifier: Apache2.0
//

import Foundation

/// This represents all the available components for the agent.
enum AppComponent {
    case popup
    case banner
    case alert
    case onboarding
    case core
    var bundleName: String {
        switch self {
        case .core:
            return "Navan Notifier"
        case .alert:
            return "Navan Notifier Alert"
        case .banner:
            return "Navan Notifier Banner"
        case .onboarding:
            return "Navan Notifier Onboarding"
        case .popup:
            return "Navan Notifier Popup"
        }
    }
    var binaryPath: String {
        return "/Contents/MacOS/\(self.bundleName)"
    }
    var componentDirectory: String {
        switch self {
        case .core:
            return ""
        case .popup, .banner, .alert, .onboarding:
            return "/Contents/Helpers/"
        }
    }
    static var current: AppComponent {
        switch Bundle.main.bundleIdentifier! {
        case "com.navan.cpe.notifier":
            return .core
        case "com.navan.cpe.notifier.alert":
            return .alert
        case "com.navan.cpe.notifier.banner":
            return .banner
        case "com.navan.cpe.notifier.popup":
            return .popup
        case "com.navan.cpe.notifier.onboarding":
            return .onboarding
        default:
            return .core
        }
    }
    /// The local relative path for the component.
    func getRelativeComponentPath() -> String {
        guard Self.current != .core else {
            return Bundle.main.bundlePath + self.componentDirectory + self.bundleName + ".app" + self.binaryPath
        }
        return Bundle.main.bundlePath.replacingOccurrences(of: "\(Self.current.bundleName)", with: "\(self.bundleName)") + self.binaryPath
    }
    func cleanSavedFiles() {
        switch self {
        case .onboarding:
            Utils.delete(Constants.storeFileName)
        case .popup, .alert, .banner, .core:
            break
        }
    }
}
