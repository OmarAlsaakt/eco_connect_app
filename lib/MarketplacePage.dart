import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'models/product.dart';
import 'ProductDetailsPage.dart';

class MarketplacePage extends StatefulWidget {
  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  String selectedCategory = 'الكل';
  String searchQuery = '';

  final List<String> categories = [
    'الكل',
    'المنزل الذكي',
    'العناية الشخصية',
    'الأزياء المستدامة',
    'إعادة التدوير',
    'رعاية الحيوانات',
    'منتجات الأطفال',
  ];

  static final List<Product> products = [
    Product(
      id: '1',
      name: 'زجاجة مياه ذكية من الستانلس ستيل',
      price: 89.99,
      image:
          'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=400',
      category: 'المنزل الذكي',
      rating: 4.8,
      ecoImpact: 'توفر 365 زجاجة بلاستيكية سنوياً',
      description:
          'زجاجة مياه ذكية تحافظ على درجة حرارة المشروبات لمدة 24 ساعة، مصنوعة من الستانلس ستيل المقاوم للصدأ.',
      features: [
        'مقاومة للصدأ',
        'عزل حراري ممتاز',
        'خالية من BPA',
        'سهلة التنظيف'
      ],
      sustainability: 'مصنوعة من مواد قابلة لإعادة التدوير 100%',
      brand: 'logo',
      title: 'logo',
      reviews: 20,
    ),
    Product(
      id: '2',
      name: 'شامبو طبيعي بزيت الأرغان العضوي',
      price: 45.50,
      image: 'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400',
      category: 'العناية الشخصية',
      rating: 4.6,
      ecoImpact: 'مكونات عضوية 100% وعبوة قابلة للتحلل',
      description:
          'شامبو طبيعي غني بزيت الأرغان العضوي، ينظف الشعر بلطف ويغذيه من الجذور حتى الأطراف.',
      features: [
        'زيت أرغان عضوي',
        'خالي من الكبريتات',
        'مناسب لجميع أنواع الشعر',
        'عبوة قابلة للتحلل'
      ],
      sustainability: 'مكونات طبيعية 100% وتغليف صديق للبيئة',
      brand: 'logo',
      title: 'logo',
      reviews: 20,
    ),
    Product(
      id: '3',
      name: 'حقيبة تسوق من القطن العضوي المعاد تدويره',
      price: 35.00,
      image: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
      category: 'الأزياء المستدامة',
      rating: 4.9,
      ecoImpact: 'تحل محل 1000 كيس بلاستيكي',
      description:
          'حقيبة تسوق عملية ومتينة مصنوعة من القطن العضوي المعاد تدويره، مثالية للتسوق اليومي.',
      features: [
        'قطن عضوي معاد تدويره',
        'متينة وقابلة للغسل',
        'تصميم أنيق',
        'مقاومة للماء'
      ],
      sustainability: 'مصنوعة من 80% قطن معاد تدويره',
      brand: 'logo',
      title: 'logo',
      reviews: 20,
    ),
    Product(
      id: '4',
      name: 'مجموعة أدوات المطبخ من الخيزران',
      price: 125.00,
      image: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400',
      category: 'المنزل الذكي',
      rating: 4.7,
      ecoImpact: 'بديل مستدام للأدوات البلاستيكية',
      description:
          'مجموعة كاملة من أدوات المطبخ المصنوعة من الخيزران الطبيعي، تشمل ملاعق وشوك وسكاكين.',
      features: [
        'خيزران طبيعي 100%',
        'مضاد للبكتيريا',
        'خفيف الوزن',
        'سهل التنظيف'
      ],
      sustainability: 'الخيزران مورد متجدد سريع النمو',
      brand: 'logo',
      title: 'logo',
      reviews: 20,
    ),
    Product(
      id: '5',
      name: 'طعام طبيعي للكلاب من مكونات عضوية',
      price: 78.99,
      image:
          'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=400',
      category: 'رعاية الحيوانات',
      rating: 4.5,
      ecoImpact: 'مكونات عضوية وتغليف قابل للتحلل',
      description:
          'طعام متكامل للكلاب مصنوع من مكونات عضوية طبيعية، يوفر التغذية المثلى لحيوانك الأليف.',
      features: [
        'مكونات عضوية 100%',
        'خالي من المواد الحافظة',
        'غني بالبروتين',
        'سهل الهضم'
      ],
      sustainability: 'مصادر مستدامة وتغليف صديق للبيئة',
      brand: 'logo',
      title: 'logo',
      reviews: 20,
    ),
    Product(
      id: '6',
      name: 'ألعاب أطفال من الخشب الطبيعي',
      price: 95.00,
      image:
          'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?w=400',
      category: 'منتجات الأطفال',
      rating: 4.8,
      ecoImpact: 'خشب من غابات مستدامة وأصباغ طبيعية',
      description:
          'مجموعة ألعاب تعليمية للأطفال مصنوعة من الخشب الطبيعي، تنمي المهارات الحركية والذهنية.',
      features: [
        'خشب طبيعي آمن',
        'أصباغ غير سامة',
        'تصميم تعليمي',
        'متين وطويل الأمد'
      ],
      sustainability: 'خشب من غابات معتمدة FSC',
      brand: 'logo',
      title: 'logo',
      reviews: 20,
    ),
  ];

  List<Product> get filteredProducts {
    List<Product> filtered = products;

    if (selectedCategory != 'الكل') {
      filtered = filtered
          .where((product) => product.category == selectedCategory)
          .toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((product) =>
              product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              product.description
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // شريط التطبيق المرن
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Color(0xFF4CAF50),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('سوق Eco-Connect'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4CAF50), Color(0xFF6D9773)],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Icon(Icons.eco, size: 60, color: Colors.white),
                      SizedBox(height: 8),
                      Text(
                        'اكتشف منتجات صديقة للبيئة',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  _showFilterBottomSheet(context);
                },
              ),
            ],
          ),

          // شريط البحث
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'ابحث عن المنتجات...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                ),
              ),
            ),
          ),

          // قائمة التصنيفات الأفقية
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: Color(0xFF4CAF50).withOpacity(0.2),
                      checkmarkColor: Color(0xFF4CAF50),
                      labelStyle: TextStyle(
                        color:
                            isSelected ? Color(0xFF4CAF50) : Color(0xFF616161),
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 8)),

          // شبكة المنتجات
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = filteredProducts[index];
                  return _buildProductCard(product);
                },
                childCount: filteredProducts.length,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
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
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Stack(
                  children: [
                    Image.network(
                      product.image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 12),
                            SizedBox(width: 2),
                            Text(
                              '${product.rating}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
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

            // معلومات المنتج
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E7D32),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      product.ecoImpact,
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price.toStringAsFixed(2)} ريال',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        Consumer<CartProvider>(
                          builder: (context, cart, child) {
                            return InkWell(
                              onTap: () {
                                cart.addToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'تم إضافة ${product.name} إلى السلة'),
                                    backgroundColor: Color(0xFF4CAF50),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تصفية المنتجات',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'التصنيفات',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF424242),
                ),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.map((category) {
                  final isSelected = selectedCategory == category;
                  return FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.white,
                    selectedColor: Color(0xFF4CAF50).withOpacity(0.2),
                    checkmarkColor: Color(0xFF4CAF50),
                    labelStyle: TextStyle(
                      color: isSelected ? Color(0xFF4CAF50) : Color(0xFF616161),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
