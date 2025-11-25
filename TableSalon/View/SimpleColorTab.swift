//
//  SimpleColorTab.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 24/11/2025.
//

import Foundation
import SwiftUI
internal import Combine


struct SimpleColorTab: View {
    @StateObject private var vm = SimpleColorViewModel()

    var body: some View {

        VStack(spacing: 16) {
            ColorPicker(selection: $vm.selectedColor) {
                Text("Color")
                    .font(.title2)
            }.padding()
            
            Toggle(isOn: $vm.pulseMode) {
                Text("Pulse Mode")
                    .font(.title2)
            }.padding()
            
            Rectangle()
                .fill(vm.selectedColor)
                .frame(width: 100, height: 100)
                .border(Color.black, width: 2)
                .cornerRadius(25)
        }
        .task {
            await vm.changeColor()
        }
    }
}

#Preview {
    SimpleColorTab()
}
