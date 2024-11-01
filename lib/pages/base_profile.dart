// import 'dart:typed_data';

// import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BaseProfile extends StatefulWidget {
  const BaseProfile({super.key});

  @override
  State<BaseProfile> createState() => BaseProfileState();
}

class BaseProfileState extends State<BaseProfile> {
  //
  var profilePictureID = "profile_pic_3534";
  var pickedImage;
  //
  //
  //start
  Future<void> selectProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child("profile_pic_3534");
    final imageBytes = await image.readAsBytes();

    await imageRef.putData(imageBytes);

    setState(() {
      pickedImage = imageBytes;
    });
  }

  Future<void> getProfilePicture(String fileID) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(fileID);

    try {
      final imageBytes = await imageRef.getData();
      if (imageBytes == null) return;
      setState(() {
        pickedImage = imageBytes;
      });
    } catch (error) {
      debugPrint("The error is $error");
    }
  }

  // Future<void> accessFileManipulator() {}

  @override
  void initState() {
    super.initState();
    getProfilePicture(profilePictureID);
  }

  @override
  Widget build(BuildContext context) {
    //Image Box and Selector
    return GestureDetector(
      onTap: selectProfilePicture,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
          image: pickedImage != null
              ? DecorationImage(
                  image: Image.memory(
                  pickedImage,
                  fit: BoxFit.cover,
                ).image)
              : null,
        ),
        child: const Icon(
          Icons.person_rounded,
          color: Colors.black38,
          size: 35,
        ),
      ),
    );
  }
}
