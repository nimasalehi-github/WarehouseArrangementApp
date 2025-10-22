
import Foundation

//
//  WarehouseView.swift
//  WarehouseArrangementApp
//
//  Created by Nima Salehi on 10/21/25.
//

import SwiftUI
import Foundation


// 🏗️ نمایش چیدمان مجسمه‌ها در فضای انبار
// 🏭 ویویی برای نمایش چیدمان مجسمه‌ها در انبار
struct WarehouseView: View {
    // 📦 لیست مجسمه‌هایی که باید نمایش داده شوند
    var sculptures: [Sculpture] // ترکیب (Composition): شامل مجموعه‌ای از مجسمه‌ها
    // 📏 تنظیم اندازه‌ی کلی محیط انبار
       let gridSize: CGFloat = 40.0
    
    var body: some View {
        ZStack {
//            // 🌈 پس‌زمینه با افکت شیشه‌ای و گرادینت زیبا
//            LinearGradient(colors: [.cyan.opacity(0.4), .indigo.opacity(0.4)], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
//                .blur(radius: 30)
            // 🧱 پس‌زمینه خاکستری شفاف برای محیط انبار
                       RoundedRectangle(cornerRadius: 25)
                           .fill(.ultraThinMaterial)
                           .shadow(radius: 20)
                           .padding()
            
            // 📦 نمایش مجسمه‌ها در فضا
            ForEach(sculptures.indices, id: \.self) { index in
                let sculpture = sculptures[index]
                VStack(spacing:5){
                    Text(sculpture.name)
                        .font(.caption)
                        .bold()
                        .foregroundColor(.white)
                    
                    // 🔶 شکل نمایشی هر مجسمه
                    // نمایش نماد مجسمه
                    Rectangle()
                        .fill(Color.cyan.opacity(0.5))
                        .frame(width: sculpture.width * gridSize, height: sculpture.height * gridSize)
                        .overlay(
                            //                            Text("🔒\(sculpture.antiTheft)")
                            //                                .foregroundColor(.white)
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.white.opacity(0.8),lineWidth: 1)
                        )
                        .shadow(radius: 5)
                    
                    
                }
                // 📍 محل قرارگیری مجسمه در فضای انبار
                // موقعیت‌دهی در فضای فرضی ۴۴×۴۴
                .position(
                    x: sculpture.position.x * gridSize,
                    y: sculpture.position.y * gridSize
                )
                // 🎯 انیمیشن نرم برای ورود مجسمه‌ها
                //                                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: sculptures)
                
                // 🛡️ رسم محافظ‌ها اطراف مجسمه
                ForEach(0..<sculpture.protectorsAssigned, id: \.self) { p in
                    let angle = Double(p) / Double(sculpture.protectorsAssigned) * 2 * .pi
                    let radius: CGFloat = max(sculpture.width, sculpture.height) / 2 + 1.0 // فاصله از مجسمه
                    
                    let px = sculpture.position.x * gridSize + radius * cos(angle) * gridSize
                    let py = sculpture.position.y * gridSize + radius * sin(angle) * gridSize
                    
                    Rectangle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(width: gridSize, height: gridSize)
                        .position(x: px, y: py)
                }

            }
            .navigationTitle("نمایش انبار 🏗️")
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
//ین که createCentralSculptures() دوباره ظاهر شده و بعدش در PreviewProvider هم نمونه‌های مجسمه وجود داره، هیچ مشکلی ایجاد نمی‌کنه چون کارکردشون متفاوت است:
//
//تفاوت‌ها و دلیل وجود دو بار:
//
//تابع createCentralSculptures() در ContentView
//
//وظیفه‌اش اینه که وقتی کاربر دکمه شروع چینش رو زد، دو مجسمه مرکزی رو بسازه و به warehouse.sculptures اضافه کنه.
//
//این کد برای اجرای واقعی اپ لازمه.
//
//آرایه sampleSculptures در WarehouseView_Previews
//
//این فقط برای پیش‌نمایش SwiftUI Canvas استفاده می‌شه.
//
//هیچ تاثیری روی داده‌های واقعی در اپ نداره و فقط در Editor و Canvas دیده می‌شه.
//
//💡 نکته کلیدی:
//
//PreviewProvider فقط برای توسعه و تست ظاهر هست.
//
//createCentralSculptures() برای اجرای واقعی و منطق اپ هست.
//
//پس وجود هر دو کاملاً طبیعی و درسته و نباید پاک بشه.
//// 🧪 پیش‌نمایش برای SwiftUI Canvas
struct WarehouseView_Previews: PreviewProvider {
    static var previews: some View {
        // آرایه‌ای از داده‌های نمونه برای نمایش سریع
        let sampleSculptures = [
            Sculpture(
                name: "خونه",
                width: 4,
                height: 4,
                vulnerability: 2,
                antiTheft: 10,
                price: 12000,
                position: CGPoint(x: 3, y: 3)
            ),
            Sculpture(
                name: "عقاب",
                width: 3,
                height: 3,
                vulnerability: 3,
                antiTheft: 9,
                price: 9000,
                position: CGPoint(x: 8, y: 4)
            )
        ]
        
        WarehouseView(sculptures: sampleSculptures)
    }
}
