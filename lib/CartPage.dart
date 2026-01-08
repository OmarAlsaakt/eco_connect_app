// import 'package:flutter/material.dart';

// class CartPage extends StatefulWidget {
//   @override
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   List<String> cartItems = [
//     "Eco-Friendly Shampoo",
//      "Reusable Water Bottle",
//       "Organic Cotton Towel"];

//   void _removeItem(int index) {
//     setState(() {
//       cartItems.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Shopping Cart")),
//       body: cartItems.isEmpty
//           ? Center(child: Text("Your cart is empty"))
//           : ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(cartItems[index]),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete, color: Colors.red),
//                     onPressed: () => _removeItem(index),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product.dart';
import 'providers/cart_provider.dart';
import 'CheckoutPage.dart';
import 'HomePage.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4, // إضافة ظل
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFE8F5E9), // لون أخضر فاتح جداً للخلفية
        title: Text(
          'سلة التسوق',
          style: TextStyle(
              fontSize: 20,
              color: Color(0xFF2E7D32), // لون أخضر داكن للنص
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep, size: 24, color: Color(0xFF2E7D32)),
            onPressed: () => _clearCart(context),
            tooltip: 'مسح السلة',
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.itemCount == 0) {
            return _buildEmptyCart(context);
          }
          return Column(
            children: [
              Expanded(child: _buildCartItems(cart)),
              _buildTotalPrice(cart),
              _buildCheckoutSection(context, cart),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined,
              size: 100, color: Color(0xFFBDBDBD)), // أيقونة سلة فارغة
          SizedBox(height: 20),
          Text(
            'سلتك فارغة!',
            style: TextStyle(
              fontSize: 28,
              color: Color(0xFF424242),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'ابدأ بإضافة المنتجات الصديقة للبيئة الآن!',
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
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4CAF50), // لون أخضر أساسي
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

  Widget _buildCartItems(CartProvider cart) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: cart.cartItems.length,
      itemBuilder: (context, index) {
        final product = cart.cartItems[index];
        return Dismissible(
          key: Key(product.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Color(0xFFEF9A9A), // لون أحمر فاتح للخلفية عند السحب
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete, color: Colors.white, size: 30),
          ),
          onDismissed: (direction) => _removeItem(context, product),
          child: Card(
            margin: EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(product.image,
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32))),
                        SizedBox(height: 4),
                        Text(
                          '${product.price.toStringAsFixed(2)} ريال',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4CAF50),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline,
                        color: Color(0xFFD32F2F), size: 24),
                    onPressed: () => _removeItem(context, product),
                    tooltip: 'إزالة المنتج',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalPrice(CartProvider cart) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Color(0xFFF1F8E9), // لون أخضر فاتح جداً للخلفية
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('الإجمالي:',
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.bold)),
          Text(
            '${cart.totalPrice.toStringAsFixed(2)} ريال',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50)),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context, CartProvider cart) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${cart.itemCount} منتجات',
            style: TextStyle(color: Color(0xFF616161), fontSize: 16),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.shopping_cart_checkout, color: Colors.white),
            label: Text('إتمام الشراء', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              backgroundColor: Color(0xFF4CAF50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckoutPage()),
            ),
          ),
        ],
      ),
    );
  }

  void _removeItem(BuildContext context, Product product) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    cart.removeFromCart(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم إزالة ${product.name} من السلة.'),
        backgroundColor: Color(0xFFD32F2F), // لون أحمر للرسالة
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'تراجع',
          textColor: Colors.white,
          onPressed: () => cart.addToCart(product),
        ),
      ),
    );
  }

  void _clearCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('مسح السلة'),
        content: Text('هل أنت متأكد أنك تريد مسح جميع المنتجات من السلة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء', style: TextStyle(color: Color(0xFF757575))), // لون رمادي
          ),
          TextButton(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).clearCart();
              Navigator.pop(context);
            },
            child: Text('مسح', style: TextStyle(color: Color(0xFFD32F2F))), // لون أحمر
          ),
        ],
      ),
    );
  }

}
