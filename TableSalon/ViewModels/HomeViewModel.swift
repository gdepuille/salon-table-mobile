//
//  SampleViewModel.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 10/11/2025.
//

import Foundation
import SwiftUI
internal import Combine


@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    @Published var infos: DeviceInfo? = nil
    
    @Published var selectedTab: TabSelected = TabSelected.COLOR
    
    @Published var enableLeds: Bool = false {
        didSet {
            Task {
                await self.changeState()
            }
        }
    }
        
    @Published var intensity: Double = 20 {
        didSet {
            Task {
                await self.changeState()
            }
        }
    }

    private let service: LedService
    
    init(service: LedService = LedServiceImpl()) {
        self.service = service
    }
    
    func loadInfos() async {
        isLoading = true
        do {
            infos = try await service.loadInfos()
        } catch {
            errorMessage = "Error load infos"
        }
        isLoading = false
    }
    
    func loadStatus() async {
        isLoading = true
        do {
            let result = try await service.loadStatus()
            enableLeds = result.state?.enabled ?? false
            intensity = Double(result.state?.intensity ?? 0)
            
            if (result.color != nil) {
                self.selectedTab = .COLOR
            } else if (result.animation != nil) {
                selectedTab = .ANIMATE
            } else {
                selectedTab = .GAME
            }
        } catch {
            errorMessage = "Error load status"
        }
        isLoading = false
    }
    
    func changeState() async {
        isLoading = true
        do {
            _ = try await service.changeState(enabled: enableLeds, intensity: Int(intensity))
        } catch {
            errorMessage = "Error change state"
        }
        isLoading = false
    }
}

enum TabSelected {
    case COLOR
    case ANIMATE
    case GAME
}
