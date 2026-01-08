import 'package:flutter/material.dart';

class PartnershipsPage extends StatelessWidget {
  final List<Map<String, dynamic>> organizations = [
    {
      'name': 'منظمة حماية البيئة',
      'logo': 'https://images.unsplash.com/photo-1532982765242-f04523030263?w=200',
      'description': 'منظمة غير ربحية تهدف إلى حماية البيئة الطبيعية والموارد المستدامة.',
      'projects': [
        {'title': 'مشروع تشجير الغابات', 'description': 'زراعة مليون شجرة في المناطق المتضررة.'},
        {'title': 'حملة تنظيف الشواطئ', 'description': 'تنظيف 100 كيلومتر من الشواطئ.'},
      ],
      'support_options': [
        {'type': 'تبرع', 'details': 'تبرع لدعم مشاريعنا.'},
        {'type': 'تطوع', 'details': 'انضم إلينا في حملات التنظيف.'},
      ],
      'website': 'https://example.com/org1',
    },
    {
      'name': 'مؤسسة الحياة المستدامة',
      'logo': 'https://images.unsplash.com/photo-1509099836639-ce7677ad4d25?w=200',
      'description': 'مؤسسة تعمل على تعزيز الممارسات المستدامة في المجتمعات المحلية.',
      'projects': [
        {'title': 'برنامج إعادة التدوير', 'description': 'توفير حاويات إعادة التدوير في الأحياء.'},
        {'title': 'ورش عمل التوعية', 'description': 'ورش عمل حول أهمية الاستدامة.'},
      ],
      'support_options': [
        {'type': 'تبرع', 'details': 'تبرع لدعم برامج التوعية.'},
        {'type': 'شراء منتجات', 'details': 'منتجات صديقة للبيئة.'},
      ],
      'website': 'https://example.com/org2',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شراكات مع منظمات بيئية'),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: organizations.length,
        itemBuilder: (context, index) {
          final org = organizations[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrganizationDetailsPage(organization: org),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            org['logo'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            org['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      org['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF616161),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrganizationDetailsPage(organization: org),
                            ),
                          );
                        },
                        child: Text(
                          'اعرف المزيد',
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrganizationDetailsPage extends StatelessWidget {
  final Map<String, dynamic> organization;

  const OrganizationDetailsPage({Key? key, required this.organization}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(organization['name']),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  organization['logo'],
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              organization['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              organization['description'],
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF424242),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Text(
              'مشاريعنا',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            SizedBox(height: 12),
            ...organization['projects'].map<Widget>((project) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.eco, color: Color(0xFF4CAF50)),
                    title: Text(
                      project['title'],
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(project['description']),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 24),
            Text(
              'كيف تدعمنا',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            SizedBox(height: 12),
            ...organization['support_options'].map<Widget>((option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.volunteer_activism, color: Color(0xFF4CAF50)),
                    title: Text(
                      option['type'],
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(option['details']),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('سيتم توجيهك لـ ${option['type']}'),
                          backgroundColor: Color(0xFF4CAF50),
                        ),
                      );
                      // يمكنك إضافة منطق للتوجيه إلى صفحة التبرع أو التطوع هنا
                    },
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('سيتم فتح موقع ${organization['name']}'),
                      backgroundColor: Color(0xFF4CAF50),
                    ),
                  );
                  // يمكنك إضافة منطق لفتح الرابط هنا
                },
                icon: Icon(Icons.public, color: Colors.white),
                label: Text(
                  'زيارة الموقع الإلكتروني',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


