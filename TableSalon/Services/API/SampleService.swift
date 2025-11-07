//
//  SampleService.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 10/11/2025.
//

import Foundation

protocol SampleService {
    func fetchPost(postId: Int) async throws -> Sample
    func toggleLeds() async throws -> Bool
}
