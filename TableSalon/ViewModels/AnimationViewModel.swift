//
//  AnimationViewModel.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 25/11/2025.
//

import Foundation
internal import Combine

@MainActor
final class AnimationViewModel: ObservableObject {
       
    @Published var animations: [Animation] = []
    @Published var selectedAnimation: Animation? = nil {
        didSet {
            Task {
                await changeAnimation()
            }
        }
    }
        
    private let service: LedService
    
    init(service: LedService = LedServiceImpl()) {
        self.service = service
    }
    
    func loadAnimations() async {
        do {
            animations = try await service.loadAnimations()
            if (selectedAnimation == nil) {
                selectedAnimation = animations.first
            } else {
                await changeAnimation()
            }
        } catch {
            
        }
    }
       
    func changeAnimation() async {
        do {
            _ = try await service.changeAnimate(id: selectedAnimation!.id)
        } catch {
            
        }
    }
}
