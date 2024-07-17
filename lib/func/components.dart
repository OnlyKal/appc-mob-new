import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

inputText(context, controller, hint, onchange, isRequired, isReadOnly) {
  return Container(
      width: fullWidth(context),
      color: isReadOnly
          ? const Color.fromARGB(255, 226, 225, 225)
          : const Color.fromARGB(255, 246, 249, 251),
      child: TextField(
        readOnly: isReadOnly,
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w700),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontWeight: FontWeight.w400),
            contentPadding: const EdgeInsets.all(10),
            suffixIcon: isRequired == true
                ? const Icon(
                    CupertinoIcons.staroflife_fill,
                    size: 8,
                    color: Colors.red,
                  )
                : const Icon(Icons.check_box_outline_blank_outlined,
                    size: 8, color: Colors.transparent)),
        onChanged: onchange,
      ));
}

loading(context) {
  return Container(
    width: fullWidth(context),
    alignment: Alignment.topCenter,
    margin: const EdgeInsets.all(15),
    child: const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeAlign: 1,
        color: Color.fromARGB(255, 217, 217, 217),
        backgroundColor: Colors.blue,
      ),
    ),
  );
}

Widget noCardyet() {
  return Container(
    height: 220.0,
    margin: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  );
}

noElementFount(context) {
  return Container(
    width: fullHeight(context),
    padding: const EdgeInsets.all(15),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.cancel_outlined,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        Text("Aucun élément trouvé")
      ],
    ),
  );
}

backPage(context) {
  return IconButton(
      onPressed: () => back(context), icon: const Icon(CupertinoIcons.back));
}
