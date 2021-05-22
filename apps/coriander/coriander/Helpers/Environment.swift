//
//  Environment.swift
//  coriander
//
//  Created by Tomas Korcak on 22.05.2021.
//

import SwiftUI
import UIKit

// -----

struct WindowKey: EnvironmentKey {
    struct Value {
        weak var value: UIWindow?
    }
    
    static let defaultValue: Value = .init(value: nil)
}

// -----

extension EnvironmentValues {
    var window: UIWindow? {
        get { return self[WindowKey.self].value }
        set { self[WindowKey.self] = .init(value: newValue) }
    }
}

// -----

