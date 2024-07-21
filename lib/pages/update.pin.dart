import 'package:appc/func/export.dart';
import 'package:flutter/material.dart';

class UpdatePinPage extends StatefulWidget {
  const UpdatePinPage({super.key});
  _UpdatePinPageState createState() => _UpdatePinPageState();
}

class _UpdatePinPageState extends State<UpdatePinPage> {
  final TextEditingController _oldPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  bool isUpdating = false;
  void _updatePin() {
    setState(() => isUpdating = true);
    if (_oldPinController.text.length == 4) {
      if (_newPinController.text.length == 4) {
        if (_confirmPinController.text.length == 4) {
          updatePIN(_oldPinController.text, _newPinController.text).then((pin) {
            setState(() => isUpdating = false);
            if (pin['matricule'] != null &&
                pin['matricule'].toString().contains("APPC")) {
              goTo(context, const ProfilePage());
              message("Code PIN modifié avec succès", context);
            } else {
              message(pin['detail'], context);
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: backPage(context),
        backgroundColor: Colors.white,
        title: Text(
          "Mettre à jour le PIN",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputText(
                context, _oldPinController, "Ancien PIN", null, true, false),
            inputText(
                context, _newPinController, "Nouveau PIN", null, true, false),
            inputText(context, _confirmPinController,
                "Confirmer le nouveau PIN", null, true, false),
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
