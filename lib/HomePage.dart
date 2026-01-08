import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'CartPage.dart';
import 'CommunityPage.dart';
import 'ProfilePage.dart';
import 'MarketplacePage.dart';
import 'ProductDetailsPage.dart';
import 'CategoryPage.dart';
import 'WishlistPage.dart';
import 'models/product.dart';
import 'PartnershipsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MarketplacePage(),
    CommunityPage(),
    CartPage(),
    WishlistPage(),
    PartnershipsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF4CAF50),
        unselectedItemColor: Color(0xFF9E9E9E),
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined),
            activeIcon: Icon(Icons.store),
            label: 'السوق',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'المجتمع',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart_outlined),
                Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return cart.itemCount > 0
                        ? Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Color(0xFFE97451),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${cart.itemCount}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
              ],
            ),
            activeIcon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return cart.itemCount > 0
                        ? Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Color(0xFFE97451),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${cart.itemCount}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
              ],
            ),
            label: 'السلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'المفضلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake_outlined),
            activeIcon: Icon(Icons.handshake),
            label: 'الشراكات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'الملف الشخصي',
          ),
        ],
      ),
    );
  }
}

// صفحة السوق الجديدة
// class MarketplacePage extends StatelessWidget {
//   final List<Map<String, dynamic>> categories = [
//     {
//       'networkImage':
//           'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400',
//       'title': 'المنزل الذكي المستدام',
//       'subtitle': 'منتجات منزلية صديقة للبيئة',
//       'icon': Icons.home_outlined,
//       'color': Color(0xFF4CAF50),
//     },
//     {
//       'networkImage':
//           'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
//       'title': 'العناية الشخصية الطبيعية',
//       'subtitle': 'منتجات عناية طبيعية وعضوية',
//       'icon': Icons.spa_outlined,
//       'color': Color(0xFF6D9773),
//     },
//     {
//       'networkImage':
//           'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400',
//       'title': 'أزياء صديقة للبيئة',
//       'subtitle': 'ملابس مستدامة وأخلاقية',
//       'icon': Icons.checkroom_outlined,
//       'color': Color(0xFF5B84B1),
//     },
//     {
//       'networkImage':
//           'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
//       'title': 'منتجات إعادة التدوير',
//       'subtitle': 'منتجات مصنوعة من مواد معاد تدويرها',
//       'icon': Icons.recycling_outlined,
//       'color': Color(0xFFE97451),
//     },
//     {
//       'networkImage':
//           'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=400',
//       'title': 'رعاية الحيوانات الأليفة',
//       'subtitle': 'منتجات طبيعية للحيوانات الأليفة',
//       'icon': Icons.pets_outlined,
//       'color': Color(0xFFFFD700),
//     },
//     {
//       'networkImage':
//           'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?w=400',
//       'title': 'منتجات الأطفال',
//       'subtitle': 'منتجات آمنة وطبيعية للأطفال',
//       'icon': Icons.child_care_outlined,
//       'color': Color(0xFFA7D9F0),
//     },
//   ];

//   final List<Map<String, dynamic>> featuredProducts = [
//     {
//       'name': 'زجاجة مياه قابلة لإعادة الاستخدام',
//       'price': '45 ريال',
//       'image':
//           'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=300',
//       'rating': 4.8,
//       'eco_impact': 'توفر 365 زجاجة بلاستيكية سنوياً',
//     },
//     {
//       'name': 'شامبو طبيعي خالي من الكيماويات',
//       'price': '35 ريال',
//       'image':
//           'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=300',
//       'rating': 4.6,
//       'eco_impact': 'مكونات عضوية 100%',
//     },
//     {
//       'name': 'حقيبة تسوق من القطن العضوي',
//       'price': '25 ريال',
//       'image':
//           'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=300',
//       'rating': 4.9,
//       'eco_impact': 'تحل محل 1000 كيس بلاستيكي',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Eco-Connect'),
//         backgroundColor: Color(0xFF4CAF50),
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // تنفيذ البحث
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.notifications_outlined),
//             onPressed: () {
//               // تنفيذ الإشعارات
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // لافتة ترحيبية
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Color(0xFF4CAF50), Color(0xFF6D9773)],
//                 ),
//               ),
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'مرحباً بك في عالم الاستدامة',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'اكتشف منتجات صديقة للبيئة وانضم لمجتمع الحياة المستدامة',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white.withOpacity(0.9),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Color(0xFF4CAF50),
//                       backgroundColor: Colors.white,
//                     ),
//                     child: Text('ابدأ التسوق'),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 20),

//             // قسم التصنيفات
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'تصنيفات المنتجات',
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//             ),
//             SizedBox(height: 12),
//             Container(
//               height: 140,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   final category = categories[index];
//                   return Container(
//                     width: 120,
//                     margin: EdgeInsets.symmetric(horizontal: 4),
//                     child: Card(
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: InkWell(
//                         onTap: () {
//                           // الانتقال لصفحة التصنيف
//                           _navigateToCategory(context, category['title']);
//                         },
//                         borderRadius: BorderRadius.circular(16),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: category['color'].withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Icon(
//                                 category['icon'],
//                                 color: category['color'],
//                                 size: 28,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               category['title'],
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF2E7D32),
//                               ),
//                               textAlign: TextAlign.center,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             SizedBox(height: 24),

//             // قسم المنتجات المميزة
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'منتجات مميزة',
//                     style: Theme.of(context).textTheme.displaySmall,
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: Text('عرض الكل'),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 12),
//             Container(
//               height: 280,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 itemCount: featuredProducts.length,
//                 itemBuilder: (context, index) {
//                   final product = featuredProducts[index];
//                   return Container(
//                     width: 200,
//                     margin: EdgeInsets.symmetric(horizontal: 4),
//                     child: Card(
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ClipRRect(
//                             borderRadius:
//                                 BorderRadius.vertical(top: Radius.circular(16)),
//                             child: Image.network(
//                               product['image'],
//                               height: 120,
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(12),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   product['name'],
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xFF2E7D32),
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 SizedBox(height: 4),
//                                 Row(
//                                   children: [
//                                     Icon(Icons.star,
//                                         color: Color(0xFFFFD700), size: 16),
//                                     SizedBox(width: 4),
//                                     Text(
//                                       '${product['rating']}',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           color: Color(0xFF616161)),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   product['eco_impact'],
//                                   style: TextStyle(
//                                     fontSize: 10,
//                                     color: Color(0xFF4CAF50),
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 SizedBox(height: 8),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       product['price'],
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFF2E7D32),
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: EdgeInsets.all(4),
//                                       decoration: BoxDecoration(
//                                         color: Color(0xFF4CAF50),
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: Icon(
//                                         Icons.add,
//                                         color: Colors.white,
//                                         size: 16,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   void _navigateToCategory(BuildContext context, String categoryName) {
//     // إنشاء قائمة مؤقتة للمنتجات
//     final List<Product> allProducts = [
//       Product(
//         id: '1',
//         name: 'زجاجة مياه ذكية من الستانلس ستيل',
//         price: 89.99,
//         image: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=400',
//         category: 'المنزل الذكي',
//         rating: 4.8,
//         ecoImpact: 'توفر 365 زجاجة بلاستيكية سنوياً',
//         description: 'زجاجة مياه ذكية تحافظ على درجة حرارة المشروبات لمدة 24 ساعة',
//         features: ['مقاومة للصدأ', 'عزل حراري ممتاز'],
//         sustainability: 'مصنوعة من مواد قابلة لإعادة التدوير 100%',
//         brand: 'EcoBottle',
//         title: 'زجاجة مياه ذكية',
//         reviews: 120,
//       ),
//     ];
    
//     final categoryProducts = allProducts
//         .where((product) => product.category == categoryName)
//         .toList();

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CategoryPage(
//           categoryName: categoryName,
//           products: categoryProducts,
//         ),
//       ),
//     );
//   }
// }
