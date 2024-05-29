// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness/Const/color_constans.dart';
import 'package:flutter_fitness/database/collections/profile_collection.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  dynamic docs;
  final UserProfileCollection userProfileCollection = UserProfileCollection();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Переменные для хранения данных пользователя
  String? gender;
  int? weight;
  int? height;
  String? dateOfBirth;
  getuser() async {
    final String uid = _auth.currentUser!.uid.toString();
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('userProfiles')
        .doc(uid)
        .get();
    setState(() {
      docs = documentSnapshot;
    });
  }

  // Функция для получения данных пользователя из Firebase
  @override
  void initState() {
    getuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
        ),
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gender:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              docs['gender'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Weight:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              docs['weight'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Height:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              docs['height'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Date of Birthday:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              docs['dateOfBirth'], // Отображаем "Не указано" если нет данных
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
