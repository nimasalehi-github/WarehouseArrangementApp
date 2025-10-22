//
//  Sculpture.swift
//  WarehouseArrangementApp
//
//  Created by Nima Salehi on 10/22/25.
//


import Foundation
import SwiftUI

// 🧩 تعریف مدل داده‌ای مجسمه
// در شیءگرایی، این struct نقش "کلاس داده" را دارد که ویژگی‌های هر مجسمه را مشخص می‌کند.
// 🧩 مدل داده‌ای برای نمایش یک "مجسمه"
struct Sculpture: Identifiable {
    // 🧱 در شیءگرایی، این struct نقش "کلاس داده‌ای" را دارد
    // یعنی شامل ویژگی‌های (Properties) و رفتارهای (Methods) مربوط به مجسمه است
    
    let id = UUID() // شناسه‌ی یکتا برای هر مجسمه (Encapsulation)
    // 📏 ویژگی‌های فیزیکی
    var name: String // نام مجسمه
    var width: Double // عرض مجسمه
    var height: Double // طول مجسمه
    
    // ⚙️ ویژگی‌های تحلیلی
    var vulnerability: Int // درجه‌ی آسیب‌پذیری
    var antiTheft: Int // ضریب ضد سرقت بودن
    var price: Double // قیمت
    // 📍 موقعیت در انبار (مختصات x و y)
    var position: CGPoint // موقعیت در انبار
    
    // 🛡️ تعداد محافظ‌های اطراف
        var protectorsAssigned: Int = 0
        
        // 💡 رفتار: تابع محاسبه امتیاز ایمنی مجسمه
        func safetyScore(center: CGPoint) -> Double {
            // فاصله از مرکز انبار
            let dx = position.x - center.x
            let dy = position.y - center.y
            let distance = sqrt(dx * dx + dy * dy)
            
            // محاسبه امتیاز ایمنی ترکیبی بر اساس ضدسرقت بودن، فاصله از مرکز و آسیب‌پذیری
            return (Double(antiTheft) * 1.5) - (Double(vulnerability) * 0.8) - (distance * 0.2)
        }
}

