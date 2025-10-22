//
//  ContentView.swift
//  WarehouseArrangementApp
//
//  Created by Nima Salehi on 10/22/25.
//

import SwiftUI
import Foundation
// 🧱 ویوی اصلی اپلیکیشن که کاربر در ابتدا آن را می‌بیند
// در شیءگرایی این View مانند یک شیء است که شامل رفتار (تابع) و داده (State) است.

struct ContentView: View {
    @State private var sculptures: [Sculpture] = [] // نگهداری آرایه‌ای از مجسمه‌ها
        @State private var showWarehouse = false // وضعیت نمایش انبار
        @State private var homeWidth: String = "" // ورودی طول خانه
        @State private var homeHeight: String = "" // ورودی عرض خانه
        @State private var eagleWidth: String = "" // ورودی طول عقاب
        @State private var eagleHeight: String = "" // ورودی عرض عقاب
    
    var body: some View {
            ZStack {
                // 🪟 پس‌زمینه با افکت شیشه‌ای (Glass Effect)
                LinearGradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    .blur(radius: 40) // ایجاد جلوه‌ی شیشه‌ای با بلور
                
                VStack {
                    if showWarehouse {
                        // اگر کاربر دکمه شروع را زده باشد، ویوی انبار نمایش داده می‌شود
                        WarehouseView(sculptures: sculptures)
                    } else {
                        // فرم ورود داده‌ها
                        VStack(spacing: 15) {
                            Text("🔹 وارد کردن اطلاعات مجسمه‌های مرکزی")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(.bottom, 10)
                            
                            // فیلدهای ورودی با ظاهر شیشه‌ای
                            Group {
                                TextField("طول خونه", text: $homeWidth)
                                TextField("عرض خونه", text: $homeHeight)
                                TextField("طول عقاب", text: $eagleWidth)
                                TextField("عرض عقاب", text: $eagleHeight)
                            }
                            .textFieldStyle(.roundedBorder)
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .padding(.horizontal)
                            
                            // دکمه‌ی شروع
                            Button("شروع چینش") {
                                createCentralSculptures()
                                showWarehouse = true
                            }
                            .font(.title3)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                        }
                        .padding()
                    }
                }
            }
        }
    
    // 🧩 تابع ایجاد مجسمه‌های مرکزی
        func createCentralSculptures() {
            let home = Sculpture(
                name: "خونه",
                width: Double(homeWidth) ?? 4.0,
                height: Double(homeHeight) ?? 4.0,
                vulnerability: 2,
                antiTheft: 10,
                price: 12000,
                position: CGPoint(x: 22, y: 22)
            )
            
            let eagle = Sculpture(
                name: "عقاب",
                width: Double(eagleWidth) ?? 3.0,
                height: Double(eagleHeight) ?? 3.0,
                vulnerability: 3,
                antiTheft: 9,
                price: 9000,
                position: CGPoint(x: 22, y: 23)
            )
            
            sculptures = [home, eagle]
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
