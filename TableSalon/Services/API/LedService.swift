//
//  SampleService.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 10/11/2025.
//

import Foundation
import SwiftUI

protocol LedService {
    func loadInfos() async throws -> DeviceInfo
    func loadStatus() async throws -> DeviceStatus
    
    func loadAnimations() async throws -> [Animation]
    func loadGames() async throws -> [Game]
    
    func changeState(enabled: Bool, intensity: Int) async throws -> APIResult
    func changeColor(color: Color, pulse: Bool) async throws -> APIResult
    func changeAnimate(id: Int) async throws -> APIResult
}
