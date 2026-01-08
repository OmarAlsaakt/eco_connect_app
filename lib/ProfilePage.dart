import 'package:eco_connect_app/WishlistPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'LoginPage.dart';
import 'EditProfilePage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Map<String, dynamic> userProfile = {
    'name': 'أحمد محمد',
    'email': 'ahmed.mohamed@example.com',
    'avatar':
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
    'joinDate': 'انضم في يناير 2024',
    'ecoPoints': 1250,
    'level': 'محارب البيئة',
    'completedChallenges': 8,
    'savedCO2': 45.6, // كيلوغرام
    'treesPlanted': 12,
  };

  final List<Map<String, dynamic>> achievements = [
    {
      'title': 'أول خطوة',
      'description': 'أكمل أول تحدي بيئي',
      'icon': Icons.eco,
      'color': Color(0xFF4CAF50),
      'unlocked': true,
    },
    {
      'title': 'محب الطبيعة',
      'description': 'ازرع 10 أشجار',
      'icon': Icons.park,
      'color': Color(0xFF8BC34A),
      'unlocked': true,
    },
    {
      'title': 'موفر الطاقة',
      'description': 'وفر 100 كيلوواط من الكهرباء',
      'icon': Icons.flash_on,
      'color': Color(0xFFFFEB3B),
      'unlocked': false,
    },
    {
      'title': 'خبير إعادة التدوير',
      'description': 'أعد تدوير 50 كيلوغرام من النفايات',
      'icon': Icons.recycling,
      'color': Color(0xFF2196F3),
      'unlocked': true,
    },
  ];

  final List<Map<String, dynamic>> recentOrders = [
    {
      'id': '#12345',
      'date': '15 ديسمبر 2024',
      'total': 125.50,
      'status': 'تم التسليم',
      'items': 3,
    },
    {
      'id': '#12344',
      'date': '10 ديسمبر 2024',
      'total': 89.99,
      'status': 'في الطريق',
      'items': 2,
    },
    {
      'id': '#12343',
      'date': '5 ديسمبر 2024',
      'total': 67.25,
      'status': 'تم التسليم',
      'items': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الملف الشخصي',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.settings),
          //   onPressed: _showSettings,
          // ),
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              if (authProvider.isLoggedIn) {
                return PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()),
                      );
                    } else if (value == 'logout') {
                      _showLogoutDialog(context, authProvider);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Color(0xFF4CAF50)),
                          SizedBox(width: 8),
                          Text('تعديل الملف الشخصي'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.red),
                          SizedBox(width: 8),
                          Text('تسجيل الخروج'),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (!authProvider.isLoggedIn) {
            return _buildLoginPrompt(context);
          }

          final user = authProvider.currentUser!;
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header with user info
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF4CAF50),
                        Color(0xFF6D9773),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'محارب البيئة',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),

                // Stats cards
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'نقاط البيئة',
                          '1250',
                          Icons.eco,
                          Color(0xFF4CAF50),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'CO₂ محفوظ',
                          '45.6 كغ',
                          Icons.cloud,
                          Color(0xFF2196F3),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'أشجار مزروعة',
                          '12',
                          Icons.park,
                          Color(0xFF8BC34A),
                        ),
                      ),
                    ],
                  ),
                ),

                // User info section
                _buildInfoSection(user),

                // Achievements section
                _buildAchievementsSection(),
                _buildRecentOrdersSection(),
                _buildMenuSection(),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       _buildProfileHeader(),
      //       _buildStatsSection(),
      //       _buildAchievementsSection(),
      //       _buildRecentOrdersSection(),
      //       _buildMenuSection(),
      //       SizedBox(height: 20),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: 100,
              color: Colors.grey[400],
            ),
            SizedBox(height: 24),
            Text(
              'يرجى تسجيل الدخول',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'قم بتسجيل الدخول للوصول إلى ملفك الشخصي ومتابعة إنجازاتك البيئية',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(user) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات الحساب',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          _buildInfoRow(Icons.phone, 'رقم الهاتف', user.phone),
          _buildInfoRow(Icons.location_on, 'العنوان', user.address),
          _buildInfoRow(Icons.calendar_today, 'تاريخ الانضمام',
              '${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}'),
          _buildInfoRow(Icons.verified, 'حالة التحقق',
              user.isVerified ? 'محقق' : 'غير محقق'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF4CAF50), size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildAchievementsSection() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.1),
  //           spreadRadius: 1,
  //           blurRadius: 4,
  //           offset: Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'الإنجازات',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.grey[800],
  //           ),
  //         ),
  //         SizedBox(height: 16),
  //         GridView.builder(
  //           shrinkWrap: true,
  //           physics: NeverScrollableScrollPhysics(),
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             crossAxisSpacing: 12,
  //             mainAxisSpacing: 12,
  //             childAspectRatio: 1.2,
  //           ),
  //           itemCount: achievements.length,
  //           itemBuilder: (context, index) {
  //             final achievement = achievements[index];
  //             return _buildAchievementCard(achievement);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildAchievementCard(Map<String, dynamic> achievement) {
  //   return Container(
  //     padding: EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: achievement['unlocked']
  //           ? achievement['color'].withOpacity(0.1)
  //           : Colors.grey[100],
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(
  //         color: achievement['unlocked']
  //             ? achievement['color']
  //             : Colors.grey[300]!,
  //         width: 1,
  //       ),
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(
  //           achievement['icon'],
  //           size: 32,
  //           color: achievement['unlocked']
  //               ? achievement['color']
  //               : Colors.grey[400],
  //         ),
  //         SizedBox(height: 8),
  //         Text(
  //           achievement['title'],
  //           style: TextStyle(
  //             fontSize: 12,
  //             fontWeight: FontWeight.bold,
  //             color:
  //                 achievement['unlocked'] ? Colors.grey[800] : Colors.grey[500],
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           achievement['description'],
  //           style: TextStyle(
  //             fontSize: 10,
  //             color:
  //                 achievement['unlocked'] ? Colors.grey[600] : Colors.grey[400],
  //           ),
  //           textAlign: TextAlign.center,
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildProfileHeader() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //         colors: [Color(0xFF4CAF50), Color(0xFF6D9773)],
  //       ),
  //     ),
  //     padding: EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         CircleAvatar(
  //           radius: 50,
  //           backgroundImage: NetworkImage(userProfile['avatar']),
  //         ),
  //         SizedBox(height: 16),
  //         Text(
  //           userProfile['name'],
  //           style: TextStyle(
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.white,
  //           ),
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           userProfile['email'],
  //           style: TextStyle(
  //             fontSize: 16,
  //             color: Colors.white70,
  //           ),
  //         ),
  //         SizedBox(height: 8),
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //           decoration: BoxDecoration(
  //             color: Colors.white.withOpacity(0.2),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           child: Text(
  //             userProfile['level'],
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 8),
  //         Text(
  //           userProfile['joinDate'],
  //           style: TextStyle(
  //             fontSize: 14,
  //             color: Colors.white70,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildStatsSection() {
  //   return Container(
  //     margin: EdgeInsets.all(16),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: _buildStatCard(
  //             'نقاط البيئة',
  //             '${userProfile['ecoPoints']}',
  //             Icons.eco,
  //             Color(0xFF4CAF50),
  //           ),
  //         ),
  //         SizedBox(width: 12),
  //         Expanded(
  //           child: _buildStatCard(
  //             'CO2 محفوظ',
  //             '${userProfile['savedCO2']} كغ',
  //             Icons.cloud,
  //             Color(0xFF2196F3),
  //           ),
  //         ),
  //         SizedBox(width: 12),
  //         Expanded(
  //           child: _buildStatCard(
  //             'أشجار مزروعة',
  //             '${userProfile['treesPlanted']}',
  //             Icons.park,
  //             Color(0xFF8BC34A),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildStatCard(
  //     String title, String value, IconData icon, Color color) {
  //   return Card(
  //     elevation: 3,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Padding(
  //       padding: EdgeInsets.all(16),
  //       child: Column(
  //         children: [
  //           Icon(icon, color: color, size: 32),
  //           SizedBox(height: 8),
  //           Text(
  //             value,
  //             style: TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //               color: Color(0xFF2E7D32),
  //             ),
  //           ),
  //           SizedBox(height: 4),
  //           Text(
  //             title,
  //             style: TextStyle(
  //               fontSize: 12,
  //               color: Color(0xFF616161),
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildAchievementsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الإنجازات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 12),
                  child: Card(
                    elevation: achievement['unlocked'] ? 3 : 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            achievement['icon'],
                            color: achievement['unlocked']
                                ? achievement['color']
                                : Color(0xFFBDBDBD),
                            size: 32,
                          ),
                          SizedBox(height: 8),
                          Text(
                            achievement['title'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: achievement['unlocked']
                                  ? Color(0xFF2E7D32)
                                  : Color(0xFFBDBDBD),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOrdersSection() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الطلبات الأخيرة',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('عرض الكل'),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...recentOrders.map((order) => _buildOrderCard(order)).toList(),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF4CAF50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.shopping_bag,
            color: Color(0xFF4CAF50),
          ),
        ),
        title: Text(
          'طلب ${order['id']}',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${order['date']} • ${order['items']} منتجات'),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _getStatusColor(order['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                order['status'],
                style: TextStyle(
                  color: _getStatusColor(order['status']),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        trailing: Text(
          '${order['total'].toStringAsFixed(2)} ريال',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        onTap: () => _showOrderDetails(order),
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildMenuItem(
            'قائمة الأمنيات',
            Icons.favorite_border,
            () => _navigateToWishlist(),
          ),
          _buildMenuItem(
            'العناوين',
            Icons.location_on_outlined,
            () => _showAddresses(),
          ),
          _buildMenuItem(
            'طرق الدفع',
            Icons.payment_outlined,
            () => _showPaymentMethods(),
          ),
          _buildMenuItem(
            'الإشعارات',
            Icons.notifications_outlined,
            () => _showNotificationSettings(),
          ),
          _buildMenuItem(
            'المساعدة والدعم',
            Icons.help_outline,
            () => _showHelp(),
          ),
          _buildMenuItem(
            'تسجيل الخروج',
            Icons.logout,
            () => _logout(),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap,
      {bool isDestructive = false}) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : Color(0xFF4CAF50),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : Color(0xFF424242),
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFF9E9E9E),
        ),
        onTap: onTap,
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'تم التسليم':
        return Color(0xFF4CAF50);
      case 'في الطريق':
        return Color(0xFF2196F3);
      case 'قيد المعالجة':
        return Color(0xFFFF9800);
      default:
        return Color(0xFF616161);
    }
  }

  // void _showSettings() {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) => Container(
  //       padding: EdgeInsets.all(20),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             'الإعدادات',
  //             style: TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           SizedBox(height: 20),
  //           ListTile(
  //             leading: Icon(Icons.edit),
  //             title: Text('تعديل الملف الشخصي'),
  //             onTap: () => Navigator.pop(context),
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.security),
  //             title: Text('الخصوصية والأمان'),
  //             onTap: () => Navigator.pop(context),
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.language),
  //             title: Text('اللغة'),
  //             onTap: () => Navigator.pop(context),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تفاصيل الطلب ${order['id']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('التاريخ: ${order['date']}'),
            Text('عدد المنتجات: ${order['items']}'),
            Text('الحالة: ${order['status']}'),
            Text('المجموع: ${order['total'].toStringAsFixed(2)} ريال'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  // void _navigateToWishlist() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('سيتم إضافة صفحة قائمة الأمنيات قريباً'),
  //       backgroundColor: Color(0xFF4CAF50),
  //     ),
  //   );
  // }
  void _navigateToWishlist() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WishlistPage()),
    );
  }

  void _showAddresses() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('سيتم إضافة إدارة العناوين قريباً'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _showPaymentMethods() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('سيتم إضافة طرق الدفع قريباً'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _showNotificationSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('سيتم إضافة إعدادات الإشعارات قريباً'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _showHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('سيتم إضافة صفحة المساعدة قريباً'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تسجيل الخروج'),
        content: Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              // authProvider.logout();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم تسجيل الخروج بنجاح'),
                  backgroundColor: Color(0xFF4CAF50),
                ),
              );
            },
            child: Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تسجيل الخروج'),
          content: Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                authProvider.logout();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('تم تسجيل الخروج بنجاح'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('تسجيل الخروج'),
            ),
          ],
        );
      },
    );
  }
}
