import 'dart:io';

import 'package:appc/func/export.dart';
import 'package:appc/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController ctrmatricule = TextEditingController();
  var ctrcodepin = "";

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrController;
  bool isLoading = false;
  @override
  void reassemble() {
    super.reassemble();
    launchScan();
  }

  bool issCannig = false;
  launchScan() {
    if (Platform.isAndroid) {
      qrController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrController!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          ctrmatricule.text = result!.code.toString();
          issCannig = false;
          qrController?.dispose();
        }
      });
    });
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lngx = Provider.of<LocalizationProvider>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                if (issCannig == false)
                  Image.asset(
                    "assets/logo.png",
                    height: 200,
                  ),
                if (issCannig == true)
                  const SizedBox(
                    height: 10,
                  ),
                if (issCannig == true)
                  Container(
                    height: fullHeight(context) * 0.5,
                    width: fullWidth(context),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                if (issCannig == true)
                  const SizedBox(
                    height: 20,
                  ),
                Text(
                  lngx.trans("access_page"),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  lngx.trans("login_prompt"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      height: 1.8, fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: fullWidth(context),
                        // color: const Color.fromARGB(255, 246, 249, 251),
                        child: TextField(
                          controller: ctrmatricule,
                          decoration: InputDecoration(
                              hintText: lngx.trans("enter_registration_number"),
                              contentPadding: const EdgeInsets.all(10),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      issCannig = !issCannig;
                                    });
                                  },
                                  icon: Icon(
                                      color: issCannig == true
                                          ? Colors.blue
                                          : Colors.black,
                                      CupertinoIcons.qrcode_viewfinder))),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      lngx.trans("enter_pin"),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Pinput(
                      onCompleted: (pin) {
                        setState(() {
                          ctrcodepin = pin;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                isLoading == true
                    ? loading(context)
                    : InkWell(
                        onTap: () async {
                          setState(() => isLoading = true);
                          login(ctrmatricule.text, ctrcodepin).then((member) {
                            //print(member);
                            setState(() => isLoading = false);

                            if (member['id'] != null) {
                              storeUserDetails(
                                  member['id'].toString(),
                                  member['matricule'],
                                  member['first_name'],
                                  member['last_name'],
                                  member['email'],
                                  member['phone_number'],
                                  member['url'],
                                  member['auth_token'],
                                  member['function'],
                                  member['image']);

                              goTo(context, const SplashScreen());
                            } else {
                              message(member['detail'], context);
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          width: fullHeight(context),
                          child: Center(
                              child: Text(
                            lngx.trans("validate"),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          )),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lngx.trans("already_member"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          height: 1.8, fontSize: 16, color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () => goTo(context, const ProvincesList()),
                      child: Text(
                        lngx.trans("join_now"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            height: 1.8, fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
