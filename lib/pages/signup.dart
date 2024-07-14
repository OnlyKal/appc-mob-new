import 'package:appc/func/export.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class SignUp extends StatefulWidget {
  final province;
  const SignUp({super.key, this.province});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController controllerNom = TextEditingController();
  TextEditingController controllerPostNom = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerFunction = TextEditingController();
  TextEditingController controllerAdress = TextEditingController();
  var ctrcodepin = "";
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(26),
            // height: fullHeight(context),
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
                    const Text(
                      "Définissez votre CODE-PIN",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
                    inputText(context, controllerNom, "Nom", null, true),
                    inputText(
                        context, controllerPostNom, "Postnom", null, true),
                    inputText(
                        context, controllerEmail, "Adresse mail", null, true),
                    inputText(
                        context, controllerPhone, "Téléphone", null, false),
                    inputText(
                        context, controllerPhone, "Votre fonction", null, true),
                    inputText(context, controllerPhone, "Adresse de résidence",
                        null, true),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
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
                const SizedBox(
                  height: 30,
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
                      onPressed: () {},
                      child: const Text(
                        "Connectez-vous",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
