import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

Widget cardMember(card, BuildContext context) {
  return Stack(
    children: [
      Container(
          padding: const EdgeInsets.all(13),
          width: fullWidth(context),
          decoration: BoxDecoration(
              color: getMembershipColor(card['card']['name']),
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: AssetImage(
                    "assets/bgcard.png",
                  ),
                  opacity: 0.1,
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      for (var i = 0; i < card['card']['stars_number']; i++)
                        const Icon(
                          CupertinoIcons.star_fill,
                          size: 14,
                          color: Color.fromARGB(255, 215, 152, 6),
                        ),
                    ],
                  ),
                ],
              ),
              Text(
                card['number'] ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 21,
                    color: Colors.white,
                    letterSpacing: 2.2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Titulaire",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      FutureBuilder(
                          future: getSessionDetails(),
                          builder: (context, AsyncSnapshot session) {
                            if (session.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    converToUpperCase(
                                        "${session.data['first_name'] ?? ''} ${session.data['last_name'] ?? ''}"),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "${session.data['function'] ?? 'Compte Professionel'}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              );
                            }
                            return Container();
                          })
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "VALIDITE",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "${card['wallet'][0]['stock']} Jours",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
      Positioned(
          child: Container(
        height: 220,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        alignment: Alignment.topRight,
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.5, image: AssetImage("assets/logo.png"))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: roundAlert(),
                          title: const Text(
                            "VERIFICATION DE LA CARTE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          content: SizedBox(
                            width: fullWidth(context),
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                QrImageView(
                                  dataModuleStyle:
                                      QrDataModuleStyle(color: mainColor),
                                  eyeStyle: const QrEyeStyle(
                                      eyeShape: QrEyeShape.circle,
                                      color: Colors.black),
                                  data: card['number'],
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  card['number'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                                const Text(
                                  "Veuillez scanner cette pour vérifier la validité de l'abonnement.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "HISTORIQUE D'ABONNEMENTS",
                                  style: TextStyle(fontSize: 18),
                                )),
                            TextButton(
                                onPressed: () => back(context),
                                child: const Text(
                                  "TERMINER",
                                  style: TextStyle(fontSize: 18),
                                )),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  CupertinoIcons.qrcode_viewfinder,
                  size: 32,
                  color: Colors.white,
                )),
            InkWell(
              onTap: () {
                print(card);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white),
                child: const Text(
                  "PAYER ABONNEMENT",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ))
    ],
  );
}

roundAlert() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6.0),
  );
}
