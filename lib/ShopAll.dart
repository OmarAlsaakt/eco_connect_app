import 'package:flutter/material.dart';

class ShopAll extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  ShopAll({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Shop All"),toolbarHeight:100,backgroundColor: const Color.fromARGB(255, 155, 209, 157)),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(categories[index]['networkImage'], width: 80, height: 240, fit: BoxFit.fill),
            title: Text(categories[index]['title'],style: TextStyle(fontSize: 36,color: const Color.fromARGB(255, 48, 140, 29)),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => categories[index]['page']));
            },
          );
        },
      ),
    );
  }
}  