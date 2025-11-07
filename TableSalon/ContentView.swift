//
//  ContentView.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 06/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var message: String = "Loading..."

    var body: some View {
        VStack(spacing: 16) {
            Text("TableSalon 🪑")
                .font(.largeTitle)
                .bold()

            Text(message)
                .font(.body)
                .foregroundColor(.secondary)
        }
        
        .task {
            await loadMessage()
        }
    }

    func loadMessage() async {
        do {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            message = json?["title"] as? String ?? "No data"
        } catch {
            message = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
