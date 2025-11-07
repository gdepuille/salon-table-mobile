//
//  Settings.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 10/11/2025.
//

import Foundation
internal import Combine

enum AuthMode {
    case TOKEN
    case PASSWORD
}

class SettingsModel: ObservableObject {
    @Published var authMode: AuthMode = .PASSWORD
    @Published var token: String? = nil
    @Published var username: String? = nil
    @Published var password: String? = nil
}
