// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class StudentHomeView extends StatelessWidget {
  const StudentHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Matematik eğitimi arıyorum'),
              subtitle: Text('Utku Doğrusöz'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              subtitle: Text('Ayşe Almacı'),
              title: Text('Fizik eğitimi arıyorum'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('İngilizce eğitimi arıyorum'),
              subtitle: Text('Emirhan Geçer'),
            ),
             ListTile(
              leading: Icon(Icons.person),
              title: Text('Kimya eğitimi arıyorum'),
              subtitle: Text('Özge Yüksel'),
            ),
          ],
        ),
      ),
    );
  }
}
