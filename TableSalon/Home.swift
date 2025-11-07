//
//  ContentView.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 06/11/2025.
//

import SwiftUI
internal import Combine


struct Home: View {
    @StateObject private var vm = SampleViewModel()

    var body: some View {

        VStack(spacing: 16) {
            Text("TableSalon")
                .font(.largeTitle)
                .bold()
            
            HStack {
                Button("Toggle LEDs", action: {
                    Task {
                        await vm.toggleLeds()
                    }
                })
                .tint(vm.enableLeds ? Color.green : Color.red)
                .buttonStyle(.borderedProminent)
                .scaledToFit()
                .padding()
                
                Text(vm.enableLeds ? "ON" : "OFF")
                    .padding()
            }
            
            if let error = vm.errorMessage {
                Text(error).foregroundColor(.red)
            } else {
                ControlGroup("Foo", systemImage: "magnifyingglass") {
                    Button("Increase", systemImage: "plus",
                           action: {
                                Task {
                                    await vm.next()
                                }
                            }
                    )
                    Button("Decrease", systemImage: "minus",
                           action: {
                                Task {
                                    await vm.previous()
                                }
                            }
                    )
                }
            
                Spacer()
                
                if let sample = vm.sample {
                    Text("ID de post: \(sample.id)")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Text(sample.title)
                        .font(.body)
                        .bold()
                        .foregroundColor(.secondary)
                    
                    Text(sample.body)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            
            if vm.isLoading {
                ProgressView("Chargement")
            }

        }
        
        .task {
            await vm.next()
        }
    }
}

#Preview {
    Home()
}
