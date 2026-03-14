import 'package:flutter/material.dart';
import '../models/product.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Üst Görsel Bölümü
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: Color(0xFFF5F5F7),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF1D1D1F),
                  size: 20,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/cart');
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Color(0xFF1D1D1F),
                    size: 22,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Color(0xFFF5F5F7),
                child: Hero(
                  tag: 'product_${product.id}',
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(40, 80, 40, 20),
                    child: Image.asset(
                      product.localImagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Ürün Bilgileri
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              transform: Matrix4.translationValues(0, -20, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 28, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ürün Adı ve Fiyat
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1D1D1F),
                                  letterSpacing: -0.5,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                product.tagline,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF86868B),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF007AFF).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            product.price,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF007AFF),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24),

                    // Teknik Özellikler
                    if (product.specs.isNotEmpty) ...[
                      Text(
                        'Teknik Özellikler',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1D1D1F),
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: product.specs.entries.map((entry) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.withValues(alpha: 0.15),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatSpecKey(entry.key),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF86868B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    entry.value,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1D1D1F),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],

                    // Açıklama
                    Text(
                      'Açıklama',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1D1D1F),
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF424245),
                        height: 1.6,
                        letterSpacing: -0.1,
                      ),
                    ),

                    SizedBox(height: 32),

                    // Sepete Ekle Butonu
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          _addToCart(context, product);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF007AFF),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_bag_outlined, size: 22),
                            SizedBox(width: 8),
                            Text(
                              'Sepete Ekle',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatSpecKey(String key) {
    // Spec anahtarlarını okunabilir hale getir
    switch (key.toLowerCase()) {
      case 'chip':
        return 'İşlemci';
      case 'material':
        return 'Malzeme';
      case 'camera':
        return 'Kamera';
      case 'display':
        return 'Ekran';
      case 'battery':
        return 'Batarya';
      case 'weight':
        return 'Ağırlık';
      case 'design':
        return 'Tasarım';
      case 'ports':
        return 'Portlar';
      case 'id':
        return 'Kimlik';
      case 'storage':
        return 'Depolama';
      case 'connectivity':
        return 'Bağlantı';
      case 'sensor':
        return 'Sensör';
      case 'water_resistance':
        return 'Su Dayanımı';
      case 'audio':
        return 'Ses';
      case 'driver':
        return 'Sürücü';
      case 'anc':
        return 'Gürültü Engel.';
      case 'tracking':
        return 'Takip';
      default:
        return key[0].toUpperCase() + key.substring(1);
    }
  }

  void _addToCart(BuildContext context, Product product) {
    // CartManager üzerinden sepete ekle
    CartManager.addItem(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                '${product.name} sepete eklendi!',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF34C759),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Sepete Git',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
  }
}

/// Basit sepet yönetim sınıfı (state simülasyonu)
class CartManager {
  static final List<Product> _items = [];

  static List<Product> get items => List.unmodifiable(_items);

  static int get itemCount => _items.length;

  static void addItem(Product product) {
    _items.add(product);
  }

  static void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }

  static void clear() {
    _items.clear();
  }

  static String get totalPrice {
    double total = 0;
    for (var item in _items) {
      // "$999" -> 999.0
      String priceStr = item.price.replaceAll(RegExp(r'[^\d.]'), '');
      total += double.tryParse(priceStr) ?? 0;
    }
    return '\$${total.toStringAsFixed(0)}';
  }
}
