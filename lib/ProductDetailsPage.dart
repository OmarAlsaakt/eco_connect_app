import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'models/product.dart';
import 'providers/cart_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم إضافة ${product.name} إلى قائمة الأمنيات'),
                  backgroundColor: Color(0xFFE91E63),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            tooltip: 'إضافة للمفضلة',
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم نسخ رابط المنتج'),
                  backgroundColor: Color(0xFF4CAF50),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            tooltip: 'مشاركة',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم المنتج والسعر
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ),
                      Text(
                        '${product.price.toStringAsFixed(2)} ريال',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // التقييم والأثر البيئي
                  Row(
                    children: [
                      Icon(Icons.star, color: Color(0xFFFFD700), size: 24),
                      SizedBox(width: 6),
                      Text(
                        '${product.rating} (${product.reviews} مراجعة)',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF616161),
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.eco, color: Color(0xFF4CAF50), size: 24),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          product.ecoImpact,
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // الوصف
                  Text(
                    'الوصف',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF424242),
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: 24),

                  // المميزات
                  Text(
                    'المميزات',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(height: 10),
                  ...product.features
                      .map((feature) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle,
                                    color: Color(0xFF4CAF50), size: 18),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),

                  SizedBox(height: 24),

                  // الاستدامة
                  Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color(0xFF4CAF50), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.eco, color: Color(0xFF4CAF50), size: 24),
                            SizedBox(width: 10),
                            Text(
                              'الاستدامة',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          product.sustainability,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF2E7D32),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // زر الإضافة للسلة
                  Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            cart.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'تم إضافة ${product.name} إلى السلة بنجاح!'),
                                backgroundColor: Color(0xFF4CAF50),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4CAF50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 5,
                          ),
                          icon: Icon(Icons.add_shopping_cart,
                              color: Colors.white),
                          label: Text(
                            'إضافة إلى السلة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
