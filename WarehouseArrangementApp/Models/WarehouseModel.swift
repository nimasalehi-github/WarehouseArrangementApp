//
//  WarehouseModel.swift
//  WarehouseArrangementApp
//
//  Created by Nima Salehi on 10/22/25.
//

import Foundation
import SwiftUI

// 🧠 کلاس مسئول مدیریت انبار و نحوه چینش مجسمه‌ها
class WarehouseModel: ObservableObject {
    // 🧩 ویژگی‌ها (Properties)
    
    // 🔸 آرایه‌ای از مجسمه‌ها
    @Published var sculptures: [Sculpture] = []
    
    // 🔸 ابعاد انبار (۴۴ در ۴۴ متر)
    let size: Double = 44.0
    
    // 🔸 تعداد کل محافظ‌ها (هر محافظ ۱×۱ متر)
    var totalProtectors = 300
    
    // 🌀 مرکز انبار برای محاسبه‌ی فاصله‌ها
    var center: CGPoint {
        CGPoint(x: size / 2, y: size / 2)
    }
    
    // 🔧 تابع اصلی چینش مجسمه‌ها در انبار
    func arrangeAll() {
        // مرتب‌سازی مجسمه‌ها بر اساس امتیاز ایمنی (ترکیب ضدسرقت و آسیب‌پذیری)
        sculptures.sort {
            $0.safetyScore(center: center) > $1.safetyScore(center: center)
        }
        
        // شروع از مرکز و پخش مجسمه‌ها در شعاع‌های مختلف
        var angle: Double = 0
        var radius: Double = 0
        
        for i in 0..<sculptures.count {
            // هر چند مجسمه، شعاع رو افزایش می‌دیم تا دورتر برن
            if i % 4 == 0 { radius += 2.5 }
            angle += .pi / 4
            
            // محاسبه موقعیت با مختصات قطبی (polar → cartesian)
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            
            sculptures[i].position = CGPoint(x: x, y: y)
        }
        
        // پس از تعیین مکان‌ها، محافظ‌ها رو تخصیص بده
        assignProtectors()
    }
    
    // 🛡️ تابع تخصیص محافظ‌ها به اطراف مجسمه‌ها
    func assignProtectors() {
        // اول محافظ‌ها رو بین مجسمه‌ها پخش می‌کنیم تا کل ۳۰۰ تا استفاده شه
        let baseProtectorPerStatue = max(totalProtectors / max(sculptures.count, 1), 1)
        
        for i in 0..<sculptures.count {
            let s = sculptures[i]
            
            // امتیاز محافظ مورد نیاز بر اساس آسیب‌پذیری و ضدسرقت بودن
            let riskFactor = Double(s.vulnerability) / Double(s.antiTheft + 1)
            var assigned = Int(Double(baseProtectorPerStatue) * (1.0 + riskFactor))
            
            // اطمینان از اینکه محافظ‌ها از تعداد کل تجاوز نکنن
            if totalProtectors - assigned < 0 {
                assigned = totalProtectors
            }
            totalProtectors -= assigned
            
            // بروزرسانی مقدار در مجسمه
            sculptures[i].protectorsAssigned = assigned
        }
    }
}
