# Mini Katalog Uygulaması

Flutter ile geliştirilmiş, Apple ürünlerini listeleyen basit bir mobil katalog uygulamasıdır.

## Proje Hakkında

Bu uygulama, Flutter eğitimi kapsamında geliştirilmiş bir "Mini Katalog Uygulaması"dır. Uygulama, bir API'den ürün verilerini çekerek kullanıcıya modern bir arayüzde sunar.

### Özellikler

- **Ana Sayfa**: Banner görseli ve GridView ile ürün listesi
- **Arama**: Ürün adına göre arama ve filtreleme
- **Ürün Detayı**: Ürün görseli, açıklama, teknik özellikler ve fiyat
- **Sepet Sistemi**: Ürün ekleme, çıkarma ve toplam fiyat hesaplama (simülasyon)
- **Sayfa Geçişleri**: Navigator ile sayfalar arası geçiş ve route arguments kullanımı
- **Hero Animasyonu**: Ürün kartından detay sayfasına geçişte animasyon

## Kullanılan Flutter Sürümü

- Flutter SDK: >=3.0.0
- Dart SDK: >=3.0.0

## Kullanılan Paketler

- `http` - API'den veri çekmek için
- `material.dart` - UI widget'ları için

## Proje Yapısı

```
lib/
├── main.dart              # Uygulama giriş noktası ve tema
├── models/
│   └── product.dart       # Ürün veri modeli (fromJson/toJson)
├── screens/
│   ├── home_screen.dart   # Ana sayfa (Banner + GridView + Arama)
│   ├── detail_screen.dart # Ürün detay sayfası
│   └── cart_screen.dart   # Sepet sayfası
├── services/
│   └── api_service.dart   # HTTP API servisi
└── widgets/
    └── product_card.dart  # Ürün kartı widget'ı
```

## Çalıştırma Adımları

1. Flutter SDK'nın kurulu olduğundan emin olun
2. Projeyi klonlayın:
   ```bash
   git clone <repo-url>
   ```
3. Proje dizinine gidin:
   ```bash
   cd miniCatalogApp
   ```
4. Bağımlılıkları yükleyin:
   ```bash
   flutter pub get
   ```
5. Uygulamayı çalıştırın:
   ```bash
   flutter run
   ```

## Veri Kaynağı

- Banner: https://wantapi.com/assets/banner.png
- Ürün verileri: https://wantapi.com/products.php

> **Not:** Bu adresler eğitim ve demo amaçlıdır. Gerçek bir e-ticaret altyapısını temsil etmez.


## Geliştirici

Doğukan Ogan
