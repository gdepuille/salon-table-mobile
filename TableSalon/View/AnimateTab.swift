//
//  AnimateTab.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 24/11/2025.
//

import Foundation
import SwiftUI

struct AnimateTab: View {
    
    @StateObject private var vm = AnimationViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 20) {
                ForEach(vm.animations, id: \.self) { animation in
                    if (vm.selectedAnimation == animation) {
                        Button(animation.name, action: { vm.selectedAnimation = animation })
                            .buttonStyle(.borderedProminent)
                    } else {
                        Button(animation.name, action: { vm.selectedAnimation = animation })
                            .buttonStyle(.borderless)
                    }
                }
            }
        }
        .task {
            await vm.loadAnimations()
        }
    }
}

#Preview {
    AnimateTab()
}
