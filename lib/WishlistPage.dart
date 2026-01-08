import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product.dart';
import 'providers/cart_provider.dart';
import 'ProductDetailsPage.dart';

class WishlistPage extends StatelessWidget {
  // قائمة مؤقتة للمنتجات المفضلة (يمكن تطويرها لاحقاً مع Provider)
  final List<Product> wishlistItems = [
    Product(
      id: '1',
      name: 'زجاجة مياه ذكية من الستانلس ستيل',
      price: 89.99,
      image: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=400',
      category: 'المنزل الذكي',
      rating: 4.8,
      ecoImpact: 'توفر 365 زجاجة بلاستيكية سنوياً',
      description: 'زجاجة مياه ذكية تحافظ على درجة حرارة المشروبات لمدة 24 ساعة، مصنوعة من الستانلس ستيل المقاوم للصدأ.',
      features: ['مقاومة للصدأ', 'عزل حراري ممتاز', 'خالية من BPA', 'سهلة التنظيف'],
      sustainability: 'مصنوعة من مواد قابلة لإعادة التدوير 100%',
      brand: 'EcoBottle',
      title: 'زجاجة مياه ذكية',
      reviews: 120,
    ),
    Product(
      id: '3',
      name: 'حقيبة تسوق من القطن العضوي المعاد تدويره',
      price: 35.00,
      image: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
      category: 'الأزياء المستدامة',
      rating: 4.9,
      ecoImpact: 'تحل محل 1000 كيس بلاستيكي',
      description: 'حقيبة تسوق عملية ومتينة مصنوعة من القطن العضوي المعاد تدويره، مثالية للتسوق اليومي.',
      features: ['قطن عضوي معاد تدويره', 'متينة وقابلة للغسل', 'تصميم أنيق', 'مقاومة للماء'],
      sustainability: 'مصنوعة من 80% قطن معاد تدويره',
      brand: 'EcoBag',
      title: 'حقيبة تسوق عضوية',
      reviews: 85,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة الأمنيات'),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
      ),
      body: wishlistItems.isEmpty
          ? _buildEmptyWishlist(context)
          : _buildWishlistItems(context),
    );
  }

  Widget _buildEmptyWishlist(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border,
              size: 100, color: Color(0xFFBDBDBD)),
          SizedBox(height: 20),
          Text(
            'قائمة أمنياتك فارغة!',
            style: TextStyle(
              fontSize: 28,
              color: Color(0xFF424242),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'أضف منتجاتك المفضلة هنا',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF757575),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          ElevatedButton.icon(
            icon: Icon(Icons.shopping_bag, color: Colors.white),
            label: Text('تصفح المنتجات', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4CAF50),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItems(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: wishlistItems.length,
      itemBuilder: (context, index) {
        final product = wishlistItems[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: product),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: Color(0xFFFFD700), size: 16),
                            SizedBox(width: 4),
                            Text(
                              '${product.rating}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF616161),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '(${product.reviews} مراجعة)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          product.ecoImpact,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${product.price.toStringAsFixed(2)} ريال',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: Color(0xFFE91E63)),
                        onPressed: () {
                          // إزالة من قائمة الأمنيات
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تم إزالة ${product.name} من قائمة الأمنيات'),
                              backgroundColor: Color(0xFFE91E63),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        tooltip: 'إزالة من المفضلة',
                      ),
                      Consumer<CartProvider>(
                        builder: (context, cart, child) {
                          return IconButton(
                            icon: Icon(Icons.add_shopping_cart, color: Color(0xFF4CAF50)),
                            onPressed: () {
                              cart.addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('تم إضافة ${product.name} إلى السلة'),
                                  backgroundColor: Color(0xFF4CAF50),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            tooltip: 'إضافة للسلة',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

