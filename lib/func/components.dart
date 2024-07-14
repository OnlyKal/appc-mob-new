import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

inputText(context, controller, hint, onchange, isRequired) {
  return Container(
      width: fullWidth(context),
      color: const Color.fromARGB(255, 246, 249, 251),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
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
