//
//  SampleViewModel.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 10/11/2025.
//

import Foundation
internal import Combine

@MainActor
final class SampleViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var enableLeds: Bool = false
    @Published var errorMessage: String?
    
    @Published var sample: Sample?
    
    private let service: SampleService
    
    init(service: SampleService = SampleServiceImpl()) {
        self.service = service
    }
    
    private func load(postId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let sample = try await service.fetchPost(postId: postId)
            self.sample = sample
            
        } catch {
            errorMessage = "Impossible de récupérer le post \(postId)"
        }
        
        isLoading = false
    }
    
    func next() async {
        let currentId = sample?.id ?? 0
        await load(postId: currentId + 1)
    }
    
    func previous() async {
        let currentId = sample?.id ?? 0
        await load(postId: currentId - 1)
    }
    
    func toggleLeds() async {
        isLoading = true
        do {
            enableLeds = try await service.toggleLeds()
        } catch {
            errorMessage = "Error to toggle LEDs"
        }
        isLoading = false
    }
}
