//
//  SampleControllerService.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 10/11/2025.
//

import Foundation

final class SampleServiceImpl: SampleService {
    
    private let api: APIClient
    private let apiTable: APIClient
    
    init() {
        self.api = APIClient(baseURL: URL(string: "https://jsonplaceholder.typicode.com")!)
        self.apiTable = APIClient(baseURL: URL(string: "http://table-salon.local")!)
    }
    
    func fetchPost(postId: Int) async throws -> Sample {
        var result:Sample = try await api.get("posts/\(postId)")
                   
        if (result.title.isEmpty) {
            result.title = "No data"
            result.body = "Empty"
        }
        
        return result
    }
    
    func toggleLeds() async throws -> Bool {
        var result:LedState = try await apiTable.get("/leds")
        return result.state
    }
}
