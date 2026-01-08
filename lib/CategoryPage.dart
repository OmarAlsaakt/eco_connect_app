import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product.dart';
import 'providers/cart_provider.dart';
import 'ProductDetailsPage.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final List<Product> products;

  const CategoryPage({
    Key? key,
    required this.categoryName,
    required this.products,
  }) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String searchQuery = '';
  String sortBy = 'name'; // name, price, rating

  List<Product> get filteredAndSortedProducts {
    List<Product> filtered = widget.products;

    // تصفية حسب البحث
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((product) =>
              product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              product.description
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }

    // ترتيب المنتجات
    switch (sortBy) {
      case 'price':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'name':
      default:
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: _showSortOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط البحث
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'ابحث في ${widget.categoryName}...',
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

          // عدد النتائج
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredAndSortedProducts.length} منتج',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF616161),
                  ),
                ),
                Text(
                  'مرتب حسب: ${_getSortDisplayName()}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // شبكة المنتجات
          Expanded(
            child: filteredAndSortedProducts.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredAndSortedProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredAndSortedProducts[index];
                      return _buildProductCard(product);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Color(0xFFBDBDBD),
          ),
          SizedBox(height: 16),
          Text(
            'لا توجد منتجات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF424242),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'جرب البحث بكلمات مختلفة',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF757575),
            ),
          ),
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
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Color(0xFFF5F5F5),
                          child: Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Color(0xFFBDBDBD),
                          ),
                        );
                      },
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
                padding: EdgeInsets.all(12),
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
                      maxLines: 2,
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

  void _showSortOptions() {
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
                'ترتيب المنتجات',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 20),
              _buildSortOption('name', 'الاسم', Icons.sort_by_alpha),
              _buildSortOption('price', 'السعر', Icons.attach_money),
              _buildSortOption('rating', 'التقييم', Icons.star),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(String value, String label, IconData icon) {
    final isSelected = sortBy == value;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Color(0xFF4CAF50) : Color(0xFF616161),
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Color(0xFF4CAF50) : Color(0xFF424242),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: Color(0xFF4CAF50))
          : null,
      onTap: () {
        setState(() {
          sortBy = value;
        });
        Navigator.pop(context);
      },
    );
  }

  String _getSortDisplayName() {
    switch (sortBy) {
      case 'price':
        return 'السعر';
      case 'rating':
        return 'التقييم';
      case 'name':
      default:
        return 'الاسم';
    }
  }
}

