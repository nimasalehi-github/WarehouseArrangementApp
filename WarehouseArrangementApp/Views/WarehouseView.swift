
import Foundation

//
//  WarehouseView.swift
//  WarehouseArrangementApp
//
//  Created by Nima Salehi on 10/21/25.
//

import SwiftUI

// 🏗️ نمایش چیدمان مجسمه‌ها در فضای انبار
struct WarehouseView: View {
    var sculptures: [Sculpture] // ترکیب (Composition): شامل مجموعه‌ای از مجسمه‌ها
    
    var body: some View {
        ZStack {
            // 🌈 پس‌زمینه با افکت شیشه‌ای و گرادینت زیبا
            LinearGradient(colors: [.cyan.opacity(0.4), .indigo.opacity(0.4)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .blur(radius: 30)
            
            // 📦 نمایش مجسمه‌ها در فضا
            ForEach(sculptures) { sculpture in
                VStack {
                    Text(sculpture.name)
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    // نمایش نماد مجسمه
                    RoundedRectangle(cornerRadius: 8)
                        .fill(sculptureColor(for: sculpture))
                        .frame(width: sculpture.width * 10, height: sculpture.height * 10)
                        .overlay(
                            Text("🔒\(sculpture.antiTheft)")
                                .foregroundColor(.white)
                        )
                        .shadow(radius: 5)
                }
                // موقعیت‌دهی در فضای فرضی ۴۴×۴۴
                .position(x: sculpture.position.x * 10, y: sculpture.position.y * 10)
            }
        }
    }
    
    // 🎨 رنگ مجسمه بر اساس میزان ضدسرقت بودن
    func sculptureColor(for sculpture: Sculpture) -> Color {
        if sculpture.antiTheft >= 9 {
            return .green.opacity(0.8)
        } else if sculpture.antiTheft >= 6 {
            return .yellow.opacity(0.8)
        } else {
            return .red.opacity(0.8)
        }
    }
}
