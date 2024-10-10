import 'package:appc/func/export.dart';
import 'package:flutter/material.dart';

class UpdatePinPage extends StatefulWidget {
  const UpdatePinPage({super.key});
  _UpdatePinPageState createState() => _UpdatePinPageState();
}

class _UpdatePinPageState extends State<UpdatePinPage> {
  final TextEditingController _oldCtlr = TextEditingController();
  final TextEditingController newCtrl = TextEditingController();
  final TextEditingController _cftCtrl = TextEditingController();
  bool isUpdating = false;
  void _updatePin() {
    if (_oldCtlr.text.length == 4) {
      if (newCtrl.text.length == 4) {
        if (_cftCtrl.text.length == 4) {
          setState(() => isUpdating = true);
          updatePIN(_oldCtlr.text, newCtrl.text).then((pin) {
            setState(() => isUpdating = false);
            if (pin['matricule'] != null &&
                pin['matricule'].toString().contains("APPC")) {
              _oldCtlr.text = newCtrl.text = _cftCtrl.text = "";
              back(context);
              message("Code PIN modifié avec succès", context);
            } else {
              message(pin['detail'], context);
            }
          });
        } else {
          message("Le code doit avoir 4 chiffres", context);
        }
      } else {
        message("Le code doit avoir 4 chiffres", context);
      }
    } else {
      message("Le code doit avoir 4 chiffres", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: backPage(context),
        // backgroundColor: Colors.white,
        title: const Text(
          "Mettre à jour le PIN",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputText(context, _oldCtlr, "Ancien PIN", null, true, false),
            inputText(context, newCtrl, "Nouveau PIN", null, true, false),
            inputText(context, _cftCtrl, "Confirmer le nouveau PIN", null, true,
                false),
            const SizedBox(height: 20),
            isUpdating == true
                ? loading(context)
                : InkWell(
                    onTap: _updatePin,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      width: fullHeight(context),
                      child: const Center(
                          child: Text(
                        "METTRE A JOUR",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      )),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
