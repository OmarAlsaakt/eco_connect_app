import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> posts = [
    {
      'id': '1',
      'author': 'سارة أحمد',
      'avatar': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100',
      'time': 'منذ ساعتين',
      'content': 'بدأت رحلتي نحو الحياة المستدامة منذ شهر، والنتائج مذهلة! قللت من استهلاك البلاستيك بنسبة 80%',
      'image': 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=400',
      'likes': 24,
      'comments': 8,
      'isLiked': false,
    },
    {
      'id': '2',
      'author': 'محمد علي',
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'time': 'منذ 4 ساعات',
      'content': 'نصائح لتوفير الطاقة في المنزل: استخدام المصابيح LED، فصل الأجهزة غير المستخدمة، واستخدام الطاقة الشمسية',
      'image': 'https://images.unsplash.com/photo-1497435334941-8c899ee9e8e9?w=400',
      'likes': 45,
      'comments': 12,
      'isLiked': true,
    },
    {
      'id': '3',
      'author': 'فاطمة الزهراء',
      'avatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
      'time': 'منذ يوم',
      'content': 'شاركوني تجاربكم مع الزراعة المنزلية! بدأت بزراعة الأعشاب والخضروات في شرفة المنزل',
      'image': 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400',
      'likes': 67,
      'comments': 23,
      'isLiked': false,
    },
  ];

  final List<Map<String, dynamic>> tips = [
    {
      'title': 'توفير المياه',
      'description': 'استخدم رؤوس الدش الموفرة للمياه',
      'icon': Icons.water_drop,
      'color': Color(0xFF2196F3),
    },
    {
      'title': 'إعادة التدوير',
      'description': 'فصل النفايات وإعادة تدوير البلاستيك',
      'icon': Icons.recycling,
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'الطاقة المتجددة',
      'description': 'استخدم الألواح الشمسية لتوليد الكهرباء',
      'icon': Icons.wb_sunny,
      'color': Color(0xFFFF9800),
    },
    {
      'title': 'النقل الأخضر',
      'description': 'استخدم الدراجة أو وسائل النقل العام',
      'icon': Icons.directions_bike,
      'color': Color(0xFF8BC34A),
    },
  ];

  final List<Map<String, dynamic>> challenges = [
    {
      'title': 'تحدي الأسبوع الأخضر',
      'description': 'عش أسبوعاً كاملاً بدون استخدام البلاستيك',
      'participants': 156,
      'daysLeft': 3,
      'progress': 0.7,
    },
    {
      'title': 'تحدي توفير الطاقة',
      'description': 'قلل استهلاك الكهرباء بنسبة 30%',
      'participants': 89,
      'daysLeft': 12,
      'progress': 0.4,
    },
    {
      'title': 'تحدي الزراعة المنزلية',
      'description': 'ازرع 5 أنواع من النباتات في منزلك',
      'participants': 234,
      'daysLeft': 20,
      'progress': 0.6,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مجتمع Eco-Connect'),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'المنشورات'),
            Tab(text: 'النصائح'),
            Tab(text: 'التحديات'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showCreatePostDialog,
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPostsTab(),
          _buildTipsTab(),
          _buildChallengesTab(),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // محاكاة تحديث البيانات
        await Future.delayed(Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return _buildPostCard(post);
        },
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // معلومات المؤلف
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(post['avatar']),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['author'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      Text(
                        post['time'],
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () => _showPostOptions(post),
                ),
              ],
            ),

            SizedBox(height: 12),

            // محتوى المنشور
            Text(
              post['content'],
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF424242),
              ),
            ),

            if (post['image'] != null) ...[
              SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post['image'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ],

            SizedBox(height: 16),

            // أزرار التفاعل
            Row(
              children: [
                InkWell(
                  onTap: () => _toggleLike(post),
                  child: Row(
                    children: [
                      Icon(
                        post['isLiked'] ? Icons.favorite : Icons.favorite_border,
                        color: post['isLiked'] ? Colors.red : Color(0xFF757575),
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${post['likes']}',
                        style: TextStyle(color: Color(0xFF757575)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 24),
                InkWell(
                  onTap: () => _showComments(post),
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment_outlined,
                        color: Color(0xFF757575),
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${post['comments']}',
                        style: TextStyle(color: Color(0xFF757575)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 24),
                InkWell(
                  onTap: () => _sharePost(post),
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_outlined,
                        color: Color(0xFF757575),
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'مشاركة',
                        style: TextStyle(color: Color(0xFF757575)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: tips.length,
      itemBuilder: (context, index) {
        final tip = tips[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: tip['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                tip['icon'],
                color: tip['color'],
                size: 24,
              ),
            ),
            title: Text(
              tip['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            subtitle: Text(
              tip['description'],
              style: TextStyle(color: Color(0xFF616161)),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _showTipDetails(tip),
          ),
        );
      },
    );
  }

  Widget _buildChallengesTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge['title'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  challenge['description'],
                  style: TextStyle(
                    color: Color(0xFF616161),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.people, color: Color(0xFF4CAF50), size: 16),
                    SizedBox(width: 4),
                    Text(
                      '${challenge['participants']} مشارك',
                      style: TextStyle(color: Color(0xFF616161)),
                    ),
                    Spacer(),
                    Icon(Icons.schedule, color: Color(0xFF4CAF50), size: 16),
                    SizedBox(width: 4),
                    Text(
                      '${challenge['daysLeft']} يوم متبقي',
                      style: TextStyle(color: Color(0xFF616161)),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                LinearProgressIndicator(
                  value: challenge['progress'],
                  backgroundColor: Color(0xFFE0E0E0),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                ),
                SizedBox(height: 8),
                Text(
                  'التقدم: ${(challenge['progress'] * 100).toInt()}%',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _joinChallenge(challenge),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'انضم للتحدي',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('إنشاء منشور جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'شارك تجربتك مع المجتمع...',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم نشر المنشور بنجاح!'),
                  backgroundColor: Color(0xFF4CAF50),
                ),
              );
            },
            child: Text('نشر'),
          ),
        ],
      ),
    );
  }

  void _toggleLike(Map<String, dynamic> post) {
    setState(() {
      post['isLiked'] = !post['isLiked'];
      post['likes'] += post['isLiked'] ? 1 : -1;
    });
  }

  void _showComments(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'التعليقات',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text('لا توجد تعليقات بعد'),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'اكتب تعليقاً...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sharePost(Map<String, dynamic> post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم نسخ رابط المنشور'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _showPostOptions(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.bookmark_border),
              title: Text('حفظ المنشور'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.report_outlined),
              title: Text('الإبلاغ عن المنشور'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showTipDetails(Map<String, dynamic> tip) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tip['title']),
        content: Text(tip['description']),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _joinChallenge(Map<String, dynamic> challenge) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم الانضمام للتحدي: ${challenge['title']}'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }
}

