//
//  SampleControllerService.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 10/11/2025.
//

import Foundation
import SwiftUI

final class LedServiceImpl: LedService {
    
    private var mocked: Bool = false
    private let apiTable: APIClient
    
    init() {
        self.apiTable = APIClient(baseURL: URL(string: "http://table-salon.local")!)
    }
    
    func loadInfos() async throws -> DeviceInfo {
        return try await apiTable.get("/infos")
    }
       
    func loadStatus() async throws -> DeviceStatus {
        return try await apiTable.get("/status")
    }
    
    func loadAnimations() async throws -> [Animation] {
        return try await apiTable.get("/animations")
    }
    
    func loadGames() async throws -> [Game] {
        return [
            Game(id: 0, name: "Randomize drink"),
            Game(id: 1, name: "Speed cursor")
        ]
    }
    
    func changeState(enabled: Bool, intensity: Int) async throws -> APIResult {
        let data = LedState(enabled: enabled, intensity: intensity)
        return try await apiTable.post("/state", body: data)
    }
    
    func changeColor(color: Color, pulse: Bool) async throws -> APIResult {
        let rgb = color.rgb255()
        let data = SimpleColor(red: Int(rgb.r), green: Int(rgb.g), blue: Int(rgb.b), pulse: pulse)
        return try await apiTable.post("/color", body: data)
    }
    
    func changeAnimate(id: Int) async throws -> APIResult {
        let body: [String: Int] = ["id": id]
        
        return try await apiTable.post("/animation", body: body)
    }
}

