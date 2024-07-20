import 'dart:convert';
import 'dart:io';
import 'package:appc/func/color.dart';
import 'package:appc/func/export.dart';
import 'package:appc/func/size.dart';
import 'package:appc/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImagePage extends StatefulWidget {
  final member;
  const ProfileImagePage({super.key, this.member});

  @override
  _ProfileImagePageState createState() => _ProfileImagePageState();
}

class _ProfileImagePageState extends State<ProfileImagePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String base64String = "";
  bool isUpdating = false;
  getImageFrom(ImageSource imageSource) async {
    SharedPreferences auth = await SharedPreferences.getInstance();
    setState(() => isUpdating = true);
    final XFile? pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        final bytes = _image!.readAsBytesSync();
        base64String = base64Encode(bytes);
      });
      updateImage(base64String).then((image) {
        auth.setString("image", image['image']);
        setState(() => isUpdating = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text(
              "Image du profil",
              style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: fullWidth(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _image != null
                                ? FileImage(_image!)
                                : const AssetImage("assets/user.png")),
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromARGB(255, 226, 226, 226)),
                  ),
                  const SizedBox(height: 20),
                  isUpdating == true
                      ? loading(context)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => getImageFrom(ImageSource.camera),
                              child: Container(
                                width: 120,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: mainColor),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'CAMERA',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            InkWell(
                              onTap: () => getImageFrom(ImageSource.gallery),
                              child: Container(
                                width: 120,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: mainColor),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'GALLERIE',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: () => goTo(context, const SplashScreen()),
                    child: const Text(
                      "COMMENCER",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.8, fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
