import 'package:eco_connect_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => CartProvider(),
    //   child: EcoConnectApp(),
    // ),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        // ChangeNotifierProvider(create: (context) => WishlistProvider()),
      ],
      child: EcoConnectApp(),
    ),
  );
}

class EcoConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eco-Connect: سوق الحياة المستدامة',
      theme: ThemeData(
        // لوحة الألوان الجديدة
        primaryColor: Color(0xFF4CAF50), // أخضر طبيعي
        hintColor: Color(0xFF6D9773), // خلفية فاتحة
        scaffoldBackgroundColor: Color(0xFFFFFFFF), // أبيض نظيف

        // تصميم الأزرار
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF4CAF50),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),

        // تصميم البطاقات
        cardTheme: CardTheme(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),

        // شريط التطبيق
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF4CAF50),
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'Montserrat',
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),

        // شريط التنقل السفلي
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF4CAF50),
          unselectedItemColor: Color(0xFF9E9E9E),
          elevation: 8,
          type: BottomNavigationBarType.fixed,
        ),

        // الأيقونات
        iconTheme: IconThemeData(
          color: Color(0xFF4CAF50),
          size: 24,
        ),

        // الحقول النصية
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF4CAF50), width: 2),
          ),
          filled: true,
          fillColor: Color(0xFFF5F5F5),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: MaterialColor(0xFF4CAF50, {
          50: Color(0xFFE8F5E8),
          100: Color(0xFFC8E6C9),
          200: Color(0xFFA5D6A7),
          300: Color(0xFF81C784),
          400: Color(0xFF66BB6A),
          500: Color(0xFF4CAF50),
          600: Color(0xFF43A047),
          700: Color(0xFF388E3C),
          800: Color(0xFF2E7D32),
          900: Color(0xFF1B5E20),
        })).copyWith(background: Color(0xFFF8F9FA)),
      ),
      home: HomePage(),
    );
  }
}
