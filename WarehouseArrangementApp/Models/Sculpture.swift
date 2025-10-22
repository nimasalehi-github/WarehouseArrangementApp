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
struct Sculpture: Identifiable {
    let id = UUID() // شناسه‌ی یکتا برای هر مجسمه (Encapsulation)
    var name: String // نام مجسمه
    var width: Double // عرض مجسمه
    var height: Double // طول مجسمه
    var vulnerability: Int // درجه‌ی آسیب‌پذیری
    var antiTheft: Int // ضریب ضد سرقت بودن
    var price: Double // قیمت
    var position: CGPoint // موقعیت در انبار
}

