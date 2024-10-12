import 'dart:convert';
import 'dart:io';
import 'package:appc/func/export.dart';
import 'package:appc/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImagePage extends StatefulWidget {
  final member;
  const ProfileImagePage({super.key, this.member});

  @override
  State<ProfileImagePage> createState() => _ProfileImagePageState();
}

class _ProfileImagePageState extends State<ProfileImagePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String base64String = "";
  bool isUpdating = false;
  getImageFrom(ImageSource imageSource) async {
    SharedPreferences auth = await SharedPreferences.getInstance();

    final XFile? pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() => isUpdating = true);
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
    final lngx = Provider.of<LocalizationProvider>(context);
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              lngx.trans("profile_image"),
              style: const TextStyle(fontWeight: FontWeight.w600),
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
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      lngx.trans("camera"),
                                      style: const TextStyle(
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
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      lngx.trans("gallery"),
                                      style: const TextStyle(
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
                    onPressed: () => base64String == ""
                        ? message(lngx.trans('select_image'), context)
                        : goTo(context, const SplashScreen()),
                    child: Text(
                      lngx.trans("start"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
