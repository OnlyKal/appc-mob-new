import 'package:appc/func/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final lngx = Provider.of<LocalizationProvider>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                  child: Text(
                    lngx.trans("create_account"),
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
                  child: Text(
                    lngx.trans("login_title"),
                    style: const TextStyle(color: Colors.white),
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
                  child: Text(
                    lngx.trans("news").toUpperCase(),
                    style: const TextStyle(color: Colors.white),
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
                  child: Text(
                    lngx.trans("order_card"),
                    style: const TextStyle(color: Colors.white),
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
                  image: AssetImage('assets/boos.s.png'),
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
                    Text(
                      lngx.trans("excellence"),
                      style: const TextStyle(
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
                      'Amour du Prochain et de la Patrie Congo "APPC"',
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
                          child: Center(
                              child: Text(
                            lngx.trans("dashboard"),
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
            ),
          ],
        ),
      ),
    );
  }
}
