//
//  SimpleColorViewModel.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 24/11/2025.
//

import Foundation
import SwiftUI
internal import Combine


@MainActor
final class SimpleColorViewModel: ObservableObject {
       
    @Published var selectedColor: Color = Color.blue  {
        didSet {
            Task { await changeColor() }
        }
    }
    
    @Published var pulseMode: Bool = false {
        didSet {
            Task { await changeColor() }
        }
    }
    
    private let service: LedService
    
    init(service: LedService = LedServiceImpl()) {
        self.service = service
    }
       
    func changeColor() async {
        do {
            _ = try await service.changeColor(color: selectedColor, pulse: pulseMode)
        } catch {
            
        }
    }
}
