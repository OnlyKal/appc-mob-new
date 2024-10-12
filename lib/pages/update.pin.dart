import 'package:appc/func/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePinPage extends StatefulWidget {
  const UpdatePinPage({super.key});
  _UpdatePinPageState createState() => _UpdatePinPageState();
}

class _UpdatePinPageState extends State<UpdatePinPage> {
  final TextEditingController _oldCtlr = TextEditingController();
  final TextEditingController newCtrl = TextEditingController();
  final TextEditingController _cftCtrl = TextEditingController();
  bool isUpdating = false;
  void _updatePin(lngx) {
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
              message(lngx("pin_modified_success"), context);
            } else {
              message(pin['detail'], context);
            }
          });
        } else {
          message(lngx("pin_must_have_4_digits"), context);
        }
      } else {
        message(lngx("pin_must_have_4_digits"), context);
      }
    } else {
      message(lngx("pin_must_have_4_digits"), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lngx = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: backPage(context),
        title: Text(
          lngx.trans("update_pin"),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputText(
                context, _oldCtlr, lngx.trans("old_pin"), null, true, false),
            inputText(
                context, newCtrl, lngx.trans("new_pin"), null, true, false),
            inputText(context, _cftCtrl, lngx.trans("confirm_new_pin"), null,
                true, false),
            const SizedBox(height: 20),
            isUpdating == true
                ? loading(context)
                : InkWell(
                    onTap: () => _updatePin(lngx.trans),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      width: fullHeight(context),
                      child: Center(
                          child: Text(
                        lngx.trans("update").toUpperCase(),
                        style: const TextStyle(
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
