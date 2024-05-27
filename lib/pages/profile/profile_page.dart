// ignore_for_file: use_build_context_synchronously, deprecated_member_use, unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness/Const/color_constans.dart';
import 'package:flutter_fitness/Const/common%20widgets/round_button.dart';
import 'package:flutter_fitness/Const/common%20widgets/setting_row.dart';
import 'package:flutter_fitness/database/collections/user_collection.dart';
import 'package:flutter_fitness/database/storage/image.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UsersCollection usersCollection = UsersCollection();
  ImageStorage imageStorage = ImageStorage();
  File? _selectImage;
  XFile? _file;
  selectImageGallery() async {
    var returnimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _file = returnimage;
      _selectImage = File(returnimage!.path);
    });
  }

  dynamic userdoc;
  final String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  getuser() async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    setState(() {
      userdoc = documentSnapshot;
    });
  }

  @override
  void initState() {
    getuser();
    super.initState();
  }

  bool positive = false;
  List accountArr = [
    {"image": "assets/img/p_personal.png", "name": "Personal Data", "tag": "1"},
  ];

  List otherArr = [
    {"image": "assets/img/p_setting.png", "name": "Setting", "tag": "7"},
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: TColor.white,
          centerTitle: true,
          elevation: 0,
          leadingWidth: 0,
          leading: null,
          title: Text(
            "Profile",
            style: TextStyle(
                color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: TColor.lightGray,
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
        backgroundColor: TColor.white,
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: userdoc['image'] != null
                      ? Image.network(
                          userdoc['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.person),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userdoc["name"],
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        userdoc['email'],
                        style: TextStyle(
                          color: TColor.gray,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 25,
                  child: RoundButton(
                    title: "Edit",
                    type: RoundButtonType.bgGradient,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Container(
                          alignment: Alignment.center,
                          height: 0.5,
                          width: 0.5,
                          child: Dialog(
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blueGrey[800],
                                      child: _selectImage != null
                                          ? Image.file(_selectImage!)
                                          : IconButton(
                                              onPressed: () =>
                                                  selectImageGallery(),
                                              icon: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: RoundButton(
                                      title: "Add images",
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                        await imageStorage.pushImage(_file!);
                                        Future.delayed(
                                            const Duration(seconds: 4));
                                        await usersCollection.updateImageUser(
                                            userdoc, imageStorage.urlImage!);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: media.height * 0.01,
                ),
                SizedBox(
                  width: 70,
                  height: 25,
                  child: RoundButton(
                    title: "Exit",
                    type: RoundButtonType.bgGradient,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/sign_in');
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: TColor.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 2)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Other",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: otherArr.length,
                    itemBuilder: (context, index) {
                      var iObj = otherArr[index] as Map? ?? {};
                      return SettingRow(
                        icon: iObj["image"].toString(),
                        title: iObj["name"].toString(),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/set');
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: TColor.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 2)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: accountArr.length,
                    itemBuilder: (context, index) {
                      var iObj = accountArr[index] as Map? ?? {};
                      return SettingRow(
                        icon: iObj["image"].toString(),
                        title: iObj["name"].toString(),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/person');
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About us',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  '“GetMoreFit” - your personal trainer in your pocket, helping you achieve your fitness goals and become the best version of yourself. With the “GetMoreFit” app, you’ll get access to effective workouts, progress tracking, and motivation every step of the way. “GetMoreFit” is more than just an app, it’s your path to a healthy lifestyle, filled with energy and self-confidence.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        const url = 'https://vk.com/idforbbiden';
                      },
                      icon: const Icon(Icons.contacts),
                    ),
                    IconButton(
                      onPressed: () {
                        const url = 'https://my.mail.ru/mail/boss.rybak71/';
                      },
                      icon: const Icon(Icons.email),
                    ),
                    IconButton(
                      onPressed: () {
                        const url = 'https://t.me/HellDem';
                      },
                      icon: const Icon(Icons.telegram),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        )));
  }
}
