<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="13142" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
    <dependencies>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12042"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner"/>
        <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
    </objects>
</document>

# 🧭 راهنمای دیباگ و بررسی پروژه WarehouseArrangementApp

این راهنما گام‌به‌گام توضیح می‌دهد که چطور پروژه را در Xcode بررسی، اجرا و خطاگیری کنید.

---

## 🔹 گام ۱: بررسی وضعیت اولیه متغیر `showWarehouse`

در فایل `ContentView.swift` این خط را پیدا کنید:

```swift
@State private var showWarehouse = false
```

این مقدار باید **در ابتدا false باشد** تا کاربر اول فرم ورودی را ببیند.

### تست:
1. اپ را اجرا کنید (`Cmd + R`).
2. اگر فرم ورودی دیده می‌شود → ✅ درست است.
3. اگر بلافاصله نمای انبار باز می‌شود → مقدار اولیه اشتباه تنظیم شده.

---

## 🔹 گام ۲: بررسی داده‌های ایجاد مجسمه‌ها

تابع زیر را در همان فایل پیدا کنید:

```swift
func createCentralSculptures()
```

در این تابع دو مجسمه ساخته می‌شود (`خونه` و `عقاب`).  
می‌توانید در انتهای تابع دستور چاپ اضافه کنید:

```swift
print("✅ Created sculptures: \(warehouse.sculptures.map { $0.name })")
```

سپس Console را باز کنید (`Cmd + Shift + C`) و در خروجی Xcode ببینید که نام‌ها چاپ می‌شوند.

---

## 🔹 گام ۳: بررسی داده‌ها در WarehouseView

به فایل `WarehouseView.swift` بروید.  
در داخل `ForEach(sculptures.indices, id: \.self)` می‌توانید اضافه کنید:

```swift
print("🪶 Showing sculpture:", sculptures[index].name)
```

در زمان اجرا، اگر در Console نام‌ها ظاهر شوند → یعنی داده از `ContentView` به درستی پاس داده شده است.

---

## 🔹 گام ۴: بررسی مسیر جریان داده

```mermaid
graph LR
A[ContentView] -->|@StateObject| B[WarehouseModel]
B -->|Array of| C[Sculpture]
A -->|pass sculptures| D[WarehouseView]
E[PreviewProvider] -->|mock data| D
```

- `ContentView` داده‌های واقعی را از کاربر می‌گیرد.
- `WarehouseModel` منطق چینش را نگه می‌دارد.
- `WarehouseView` فقط دادهٔ ورودی را نمایش می‌دهد.
- `PreviewProvider` برای تست نمایشی است (در طراحی، نه در اجرای واقعی).

---

## 🔹 گام ۵: استفاده از Breakpoint

برای بررسی جریان واقعی داده:
1. کنار خط `createCentralSculptures()` در Xcode کلیک کنید تا نقطهٔ قرمز ظاهر شود.
2. برنامه را اجرا کنید.
3. وقتی به آن خط رسید، Xcode متوقف می‌شود.
4. در پایین پنجره مقدار متغیرها را ببینید (`warehouse.sculptures` را باز کنید).

---

## 🔹 گام ۶: نکات شیءگرایی (OOP) در پروژه

| مفهوم | در کجا دیده می‌شود | توضیح |
|--------|------------------|--------|
| **Encapsulation (کپسوله‌سازی)** | در `WarehouseModel` | متغیرها و توابع فقط از طریق شیء کنترل می‌شوند. |
| **Composition (ترکیب)** | در `WarehouseView` | لیستی از مجسمه‌ها را در خود دارد. |
| **Abstraction (انتزاع)** | در `ContentView` | جزئیات مدل از کاربر پنهان است. |
| **Inheritance (وراثت)** | در Viewها از `View` | هر struct از View ارث‌بری می‌کند. |

---

## 🔹 گام ۷: بررسی Preview‌ها

در فایل `WarehouseView.swift` بخشی مشابه زیر وجود دارد:

```swift
#Preview {
    let sampleSculptures = [...]
    WarehouseView(sculptures: sampleSculptures)
}
```

این قسمت فقط برای پیش‌نمایش است و در اجرای اصلی تأثیری ندارد.

---

## 🧩 جمع‌بندی

- `showWarehouse = false` در آغاز باید فعال باشد.
- از Console برای مشاهده داده‌ها و جریان اطلاعات استفاده کنید.
- از Breakpoint برای بررسی مقدار دقیق متغیرها بهره ببرید.
- پیش‌نمایش‌ها فقط جهت طراحی هستند، نه اجرای نهایی.

---

🗓️ تاریخ: ۲۳ مهر ۱۴۰۴
