//
//  StdExtensions.swift
//  TableSalon
//
//  Created by Gregory DEPUILLE on 24/11/2025.
//

import Foundation
import SwiftUI

extension Color {

    func rgb255() -> (r: Int, g: Int, b: Int, a: Int) {
        guard let cgColor = self.cgColor else {
            return (0, 0, 0, 255)
        }

        let components = cgColor.components ?? [0, 0, 0, 1]

        // Cas standard: RGBA
        if components.count >= 4 {
            return (
                r: Int(components[0] * 255),
                g: Int(components[1] * 255),
                b: Int(components[2] * 255),
                a: Int(components[3] * 255)
            )
        }

        // Cas : gris + alpha (Display P3 souvent)
        if components.count == 2 {
            let gray = components[0]
            let alpha = components[1]
            return (
                r: Int(gray * 255),
                g: Int(gray * 255),
                b: Int(gray * 255),
                a: Int(alpha * 255)
            )
        }

        return (0, 0, 0, 255)
    }
}
