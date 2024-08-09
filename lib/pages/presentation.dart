import 'package:appc/func/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../func/export.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  String tokenCkeck = "";

  @override
  void initState() {
    checkSession();
    super.initState();
  }

  checkSession() async {
    SharedPreferences auth = await SharedPreferences.getInstance();
    setState(() => tokenCkeck = auth.getString("token")!);
    print(tokenCkeck);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            if (tokenCkeck == "")
              InkWell(
                onTap: () => goTo(context, const SignUp()),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "CRÉER UN COMPTE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            if (tokenCkeck == "")
              InkWell(
                onTap: () => goTo(context, const SignUp()),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "CONNEXION",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            if (tokenCkeck != "")
              InkWell(
                onTap: () => goTo(context, const Actualities()),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "ACTUALITÉS",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            if (tokenCkeck != "")
              InkWell(
                onTap: () => goTo(context, const OrderCard()),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "COMMENDER UNE CARTE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            IconButton(
                onPressed: () => goTo(context, const ProfilePage()),
                icon: const Icon(CupertinoIcons.person)),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bosss.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: fullWidth(context),
                height: 220,
                color: const Color.fromARGB(153, 0, 0, 0),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'EXCELENCE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Sylvestre DANGNONSI MAKAMBO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const Text(
                      'Amour du Prochain et pour la Patrie "APPC"',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (tokenCkeck != "")
                      InkWell(
                        onTap: () => goTo(context, const HomePage()),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          width: fullHeight(context),
                          child: const Center(
                              child: Text(
                            "TABLEAU DE BORD",
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
            ),
          ],
        ),
      ),
    );
  }
}
