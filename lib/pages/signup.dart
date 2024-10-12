import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final province;
  const SignUp({super.key, this.province});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController controllerProvice = TextEditingController();
  TextEditingController controllerNom = TextEditingController();
  TextEditingController controllerPostNom = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerFunction = TextEditingController();
  TextEditingController controllerAdress = TextEditingController();
  var ctrcodepin = "";

  bool isAdding = false;

  @override
  void initState() {
    setState(() => controllerProvice.text =
        widget.province['name'].toString().toUpperCase());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lngx = Provider.of<LocalizationProvider>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  lngx.trans("membership_page"),
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
                    Row(
                      children: [
                        Text(
                          lngx.trans("enter_pin"),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          CupertinoIcons.staroflife_fill,
                          size: 8,
                          color: Colors.red,
                        )
                      ],
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
                    const SizedBox(
                      height: 30,
                    ),
                    inputText(context, controllerProvice,
                        lngx.trans("province"), null, true, true),
                    inputText(context, controllerNom, lngx.trans("name"), null,
                        true, false),
                    inputText(context, controllerPostNom, lngx.trans("surname"),
                        null, true, false),
                    inputText(context, controllerEmail, lngx.trans("email"),
                        null, false, false),
                    inputText(context, controllerPhone,
                        "${lngx.trans("phone")} (243)", null, true, false),
                    inputText(context, controllerFunction,
                        lngx.trans("your_function"), null, true, false),
                    inputText(context, controllerAdress,
                        lngx.trans("residence_address"), null, true, false),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                isAdding == true
                    ? loading(context)
                    : InkWell(
                        onTap: () {
                          if (controllerNom.text == "") {
                            message("Nom field is empty", context);
                          } else if (controllerEmail.text == "") {
                            message("Email field is empty", context);
                          } else if (controllerPhone.text == "") {
                            message("Phone field is empty", context);
                          } else if (controllerFunction.text == "") {
                            message("Function field is empty", context);
                          } else if (controllerAdress.text == "") {
                            message("Address field is empty", context);
                          } else {
                            setState(() => isAdding = true);
                            addMember(
                                    widget.province['id'],
                                    ctrcodepin,
                                    controllerNom.text,
                                    controllerPostNom.text,
                                    controllerEmail.text,
                                    controllerPhone.text,
                                    controllerFunction.text,
                                    controllerAdress.text)
                                .then((member) {
                              setState(() => isAdding = false);

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
                                    null);
                                goTo(context, ProfileImagePage(member: member));
                              }
                            });
                          }
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
                  height: 10,
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
                      onPressed: () => goTo(context, const SignIn()),
                      child: Text(
                        lngx.trans("login"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            height: 1.8, fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => goTo(context, const ProvincesList()),
                  child: Text(
                    lngx.trans("change_province"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        height: 1.8, fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
