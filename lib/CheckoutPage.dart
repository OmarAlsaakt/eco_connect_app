import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'models/product.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();

  String _selectedPaymentMethod = 'credit_card';
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إتمام الشراء'),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.itemCount == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Color(0xFFBDBDBD)),
                  SizedBox(height: 20),
                  Text(
                    'سلتك فارغة!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF424242),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'أضف منتجات للمتابعة',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF757575),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50),
                    ),
                    child: Text('العودة للتسوق'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // ملخص الطلب
                _buildOrderSummary(cart),
                
                // نموذج معلومات الشحن
                _buildShippingForm(),
                
                // طرق الدفع
                _buildPaymentMethods(),
                
                // زر إتمام الشراء
                _buildCheckoutButton(cart),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderSummary(CartProvider cart) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF4CAF50), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ملخص الطلب',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          SizedBox(height: 16),
          ...cart.cartItems.map((product) => _buildOrderItem(product)).toList(),
          Divider(color: Color(0xFF4CAF50)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المجموع الفرعي:',
                style: TextStyle(fontSize: 16, color: Color(0xFF424242)),
              ),
              Text(
                '${cart.totalPrice.toStringAsFixed(2)} ريال',
                style: TextStyle(fontSize: 16, color: Color(0xFF424242)),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'رسوم الشحن:',
                style: TextStyle(fontSize: 16, color: Color(0xFF424242)),
              ),
              Text(
                'مجاني',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4CAF50),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(color: Color(0xFF4CAF50)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الإجمالي:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              Text(
                '${cart.totalPrice.toStringAsFixed(2)} ريال',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Product product) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
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
                  '${product.price.toStringAsFixed(2)} ريال',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'معلومات الشحن',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _nameController,
              label: 'الاسم الكامل',
              icon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال الاسم الكامل';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              label: 'البريد الإلكتروني',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال البريد الإلكتروني';
                }
                if (!value.contains('@')) {
                  return 'يرجى إدخال بريد إلكتروني صحيح';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _phoneController,
              label: 'رقم الهاتف',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال رقم الهاتف';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _addressController,
              label: 'العنوان',
              icon: Icons.location_on,
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال العنوان';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _cityController,
                    label: 'المدينة',
                    icon: Icons.location_city,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال المدينة';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _postalCodeController,
                    label: 'الرمز البريدي',
                    icon: Icons.local_post_office,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال الرمز البريدي';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF4CAF50)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
        filled: true,
        fillColor: Color(0xFFF9F9F9),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'طريقة الدفع',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          SizedBox(height: 16),
          _buildPaymentOption(
            'credit_card',
            'بطاقة ائتمان',
            Icons.credit_card,
            'فيزا، ماستركارد، أمريكان إكسبريس',
          ),
          _buildPaymentOption(
            'apple_pay',
            'Apple Pay',
            Icons.phone_iphone,
            'دفع سريع وآمن',
          ),
          _buildPaymentOption(
            'cash_on_delivery',
            'الدفع عند الاستلام',
            Icons.money,
            'ادفع نقداً عند وصول الطلب',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(
      String value, String title, IconData icon, String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: _selectedPaymentMethod == value
              ? Color(0xFF4CAF50)
              : Color(0xFFE0E0E0),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (String? newValue) {
          setState(() {
            _selectedPaymentMethod = newValue!;
          });
        },
        activeColor: Color(0xFF4CAF50),
        title: Row(
          children: [
            Icon(icon, color: Color(0xFF4CAF50)),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Color(0xFF757575)),
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(CartProvider cart) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : () => _processOrder(cart),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4CAF50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
          ),
          child: _isProcessing
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'جاري المعالجة...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Text(
                  'تأكيد الطلب - ${cart.totalPrice.toStringAsFixed(2)} ريال',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  void _processOrder(CartProvider cart) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    // محاكاة معالجة الطلب
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _isProcessing = false;
    });

    // عرض رسالة نجاح
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'تم تأكيد طلبك بنجاح!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              'سيتم التواصل معك قريباً لتأكيد التسليم',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF757575),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cart.clearCart();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'العودة للصفحة الرئيسية',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }
}

