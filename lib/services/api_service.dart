import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://wantapi.com';
  static const String _productsEndpoint = '/products.php';

  /// API'den ürün listesini çeker
  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl$_productsEndpoint'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['status'] == 'success' && jsonData['data'] != null) {
          final List<dynamic> productsJson = jsonData['data'];
          return productsJson.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('API yanıtı başarısız: ${jsonData['status']}');
        }
      } else {
        throw Exception('HTTP Hata: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ürünler yüklenirken hata oluştu: $e');
    }
  }

  /// Banner URL'ini döndürür
  static String getBannerUrl() {
    return '$_baseUrl/assets/banner.png';
  }
}
