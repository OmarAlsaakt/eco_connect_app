import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // قائمة المستخدمين المسجلين (في التطبيق الحقيقي ستكون في قاعدة البيانات)
  final List<Map<String, String>> _registeredUsers = [
    {
      'email': 'admin@ecoconnect.com',
      'password': '123456',
      'name': 'مدير النظام',
      'phone': '+966501234567',
      'address': 'الرياض، المملكة العربية السعودية'
    },
    {
      'email': 'user@example.com',
      'password': 'password',
      'name': 'أحمد محمد',
      'phone': '+966507654321',
      'address': 'جدة، المملكة العربية السعودية'
    },
  ];

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // محاكاة تأخير الشبكة
      await Future.delayed(Duration(seconds: 1));

      // البحث عن المستخدم في القائمة
      final userMap = _registeredUsers.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
        orElse: () => {},
      );

      if (userMap.isNotEmpty) {
        _currentUser = User(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: userMap['name']!,
          email: userMap['email']!,
          phone: userMap['phone']!,
          address: userMap['address']!,
          createdAt: DateTime.now(),
          isVerified: true,
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'حدث خطأ أثناء تسجيل الدخول';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password, String phone, String address) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // محاكاة تأخير الشبكة
      await Future.delayed(Duration(seconds: 1));

      // التحقق من وجود المستخدم مسبقاً
      final existingUser = _registeredUsers.any((user) => user['email'] == email);
      
      if (existingUser) {
        _errorMessage = 'البريد الإلكتروني مستخدم مسبقاً';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // إضافة المستخدم الجديد
      _registeredUsers.add({
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'address': address,
      });

      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        address: address,
        createdAt: DateTime.now(),
        isVerified: false,
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'حدث خطأ أثناء التسجيل';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> updateProfile(String name, String phone, String address) async {
    if (_currentUser == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(Duration(seconds: 1));

      _currentUser = _currentUser!.copyWith(
        name: name,
        phone: phone,
        address: address,
      );

      // تحديث في قائمة المستخدمين المسجلين
      final userIndex = _registeredUsers.indexWhere(
        (user) => user['email'] == _currentUser!.email,
      );
      if (userIndex != -1) {
        _registeredUsers[userIndex]['name'] = name;
        _registeredUsers[userIndex]['phone'] = phone;
        _registeredUsers[userIndex]['address'] = address;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'حدث خطأ أثناء تحديث الملف الشخصي';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}

