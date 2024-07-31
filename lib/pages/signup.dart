import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

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
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "PAGE D'ADHÉSION",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "Connectez-vous, veuillez saisir scrupuleusement les éléments demandés.",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(height: 1.8, fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Définissez votre CODE-PIN",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
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
                    inputText(context, controllerProvice, "Provice", null,
                        false, true),
                    inputText(context, controllerNom, "Nom", null, true, false),
                    inputText(context, controllerPostNom, "Postnom", null, true,
                        false),
                    inputText(context, controllerEmail, "Adresse mail", null,
                        true, false),
                    inputText(context, controllerPhone, "Téléphone", null,
                        false, false),
                    inputText(context, controllerFunction, "Votre fonction",
                        null, true, false),
                    inputText(context, controllerAdress, "Adresse de résidence",
                        null, true, false),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                isAdding == true
                    ? loading(context)
                    : InkWell(
                        onTap: () {
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
                            print(member);
                            setState(() => isAdding = false);
                            if (member['id'] != null) {
                              storeUserDetails(
                                  member['matricule'],
                                  member['first_name'],
                                  member['last_name'],
                                  member['email'],
                                  member['phone_number'],
                                  member['url'],
                                  member['auth_token'],
                                  member['function']);
                              goTo(context, ProfileImagePage(member: member));
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          width: fullHeight(context),
                          child: const Center(
                              child: Text(
                            "VALIDER",
                            style: TextStyle(
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
                    const Text(
                      "Etes-vous déjà un membre APPC ? ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.8, fontSize: 16, color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () => goTo(context, const SignIn()),
                      child: const Text(
                        "Connectez-vous",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.8, fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => goTo(context, const ProvincesList()),
                  child: const Text(
                    "Changer la province",
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
