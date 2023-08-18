import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../configs/palette.dart';
import '../widgets/button_widget.dart';
import '../widgets/toast.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  const ProfileScreen({super.key, required this.name});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String? url;
  bool isLoading = false;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      try {
        final imageFile = File(pickedImage.path);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images/${DateTime.now().toString()}.jpg');
        final uploadTask = storageRef.putFile(imageFile);
        final snapshot = await uploadTask.whenComplete(() => null);
        final imageUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          url = imageUrl;
        });

        final user = _auth.currentUser;
        if (user != null) {
          await _fireStore.collection('users').doc(user.uid).update({
            'imageUrl': imageUrl,
          });
        }

        ToastBottomSuccess('Image uploaded successfully');
      } catch (e) {
        ToastBottomError('Image uploaded failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Palette.kBackgroundColor,
            image: DecorationImage(
              image: AssetImage('assets/images/back.png'),
              opacity: 0.8,
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.keyboard_backspace_rounded,
                        size: 25.0,
                        color: Palette.kHeadingColor,
                      ),
                    ),
                  ),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 65, height: 10)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70.0,
                    backgroundImage: const AssetImage('assets/images/user.png'),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        color: Palette.kLightWhiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        color: Palette.kPrimaryColor,
                        onPressed: () {
                          _selectImage();
                        },
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                widget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                _auth.currentUser!.email ?? "",
                style: const TextStyle(
                  color: Palette.kHeadingColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ButtonWidget(
                  buttonText: "Sign Out",
                  buttonTriggerFunction: () async {
                    await _auth.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
