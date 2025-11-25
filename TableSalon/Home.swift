//
//  ContentView.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 06/11/2025.
//

import SwiftUI
internal import Combine


struct Home: View {
    @StateObject private var vm = HomeViewModel()

    var body: some View {

        VStack(spacing: 16) {
            HStack {
                Text(vm.infos?.name ?? "Loading...")
                    .font(.largeTitle)
                    .bold()
                
                if vm.isLoading {
                    ProgressView()
                }
                Spacer()
                
                Button("Settings", action: {})
                    .buttonStyle(.borderedProminent)
                    .scaledToFit()
            }
            HStack {
                Text(vm.infos?.version ?? "...")
                    .font(.title3)
                Spacer()
                
                Text(vm.infos?.hashGit ?? "...")
                    .font(.title3)
            }
            
            Toggle(isOn: $vm.enableLeds) {
                Text("Toggle LEDs")
                    .font(.title2)
            }
            
            HStack {
                Text("Intensity")
                    .font(.title2)
                
                Slider(value: $vm.intensity, in: 0...100)
            }
            
            TabView(selection: $vm.selectedTab) {
                
                SimpleColorTab()
                    .tag(TabSelected.COLOR)
                    .tabItem {
                        Label("Color", systemImage: "circle.lefthalf.filled.righthalf.striped.horizontal")
                    }
                
                AnimateTab()
                    .tag(TabSelected.ANIMATE)
                    .tabItem {
                        Label("Animate", systemImage: "star.circle.fill")
                    }
                
                GameTab()
                    .tag(TabSelected.GAME)
                    .tabItem {
                        Label("Game", systemImage: "gamecontroller.circle")
                    }
            }
        }
        .task {
            await vm.loadInfos()
            await vm.loadStatus()
        }
        .padding()
    }
}


#Preview {
    Home()
}
