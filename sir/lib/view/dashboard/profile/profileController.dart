import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sir/res/colours.dart';
import 'package:firebase_storage/firebase_storage.dart ' as firebase_stoarge;
import 'package:sir/res/components/input_textfield.dart';
import 'package:sir/utils/utils.dart';
import 'package:sir/viewmodel/services/session_manager.dart';

class ProfileController with ChangeNotifier {
  firebase_stoarge.FirebaseStorage storage =
      firebase_stoarge.FirebaseStorage.instance;

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final picker = ImagePicker();

  XFile? _image;

  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

// GAllery :
  Future pickGalleryImage(BuildContext context) async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (PickedFile != null) {
      _image = XFile(PickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);

    firebase_stoarge.Reference storageRef = firebase_stoarge
        .FirebaseStorage.instance
        .ref('/profileImage' + SessionController().userid.toString());

    firebase_stoarge.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    ref
        .child(SessionController().userid.toString())
        .update({'profile': newUrl.toString()}).then((value) {
      Utils.toastMessage('Profile Updated');

      setLoading(false);
      _image = null;
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      setLoading(false);
    });
  }

// Camera ;
  Future pickCameraImage(BuildContext context) async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (PickedFile != null) {
      _image = XFile(PickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      pickCameraImage(context);
                    },
                    leading: Icon(
                      Icons.camera,
                      color: AppColors.primaryIconColor,
                    ),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.image,
                      color: AppColors.primaryIconColor,
                    ),
                    title: Text("Gallery"),
                  )
                ],
              ),
            ),
          );
        });
  }

  // Edit User Porfile :
  Future<void> showUserNameDailogAlert(BuildContext context, String name) {
    nameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Update UserName')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      myController: nameController,
                      focusNode: nameFocusNode,
                      onFieldSubmittedValue: (value) {},
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      hint: 'Enter name',
                      onValidator: (value) {})
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.alertColor),
                  )),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userid.toString()).update({
                      'userName': nameController.text.toString()
                    }).then((value) {
                      nameController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Oke",
                    style: Theme.of(context).textTheme.subtitle2,
                  )),
            ],
          );
        });
  }

  // Edit User Porfile :
  Future<void> showUserPhoneDailogAlert(BuildContext context, String phone) {
    phoneController.text = phone;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Update PhoneNumber')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                      myController: phoneController,
                      focusNode: phoneFocusNode,
                      onFieldSubmittedValue: (value) {},
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      hint: 'Enter PhoneNumber',
                      onValidator: (value) {})
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.alertColor),
                  )),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userid.toString()).update({
                      'phone': phoneController.text.toString()
                    }).then((value) {
                      phoneController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Oke",
                    style: Theme.of(context).textTheme.subtitle2,
                  )),
            ],
          );
        });
  }
}
