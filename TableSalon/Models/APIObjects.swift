//
//  LedState.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 13/11/2025.
//

import Foundation

struct APIResult: Codable {
    var ack: Bool
    var error: String?
}

struct DeviceInfo: Codable {
    var name: String
    var version: String
    var hashGit: String
}

struct DeviceStatus: Codable {
    var state: LedState?
    var color: SimpleColor?
    var animation: Animation?
    var game: Game?
}

struct LedState: Codable {
    var enabled: Bool
    var intensity: Int
}

struct SimpleColor: Codable {
    var red: Int
    var green: Int
    var blue: Int
    var pulse: Bool
}

struct Animation: Codable, Hashable {
    var id: Int
    var name: String
    var icon: String?
}

struct Game: Codable {
    var id: Int
    var name: String
    var icon: String?
}
