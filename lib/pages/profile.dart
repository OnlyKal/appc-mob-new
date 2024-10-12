import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final lngx = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: backPage(context),
        title: Text(
          lngx.trans("profile"),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: getImageSession(),
              builder: (context, AsyncSnapshot user) {
                if (user.hasData) {
                  String currentUrl = user.data['image'].toString();
                  String newImage = currentUrl.split("/media").last.toString();
                  final imageUrl = "$serveradress/media/$newImage";
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () =>
                            goTo(context, PhotoViewer(image: imageUrl)),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(imageUrl),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => goTo(context, const ProfileImagePage()),
                          child: CircleAvatar(
                            backgroundColor: mainColor,
                            child: const Icon(
                              CupertinoIcons.camera,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/user.png"),
                );
              },
            ),
            const SizedBox(height: 16),
            FutureBuilder(
                future: getSessionDetails(),
                builder: (context, AsyncSnapshot user) {
                  if (user.hasData) {
                    return Column(
                      children: [
                        Text(
                          '${user.data['first_name']} ${user.data['last_name']} ',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(newVal(user.data['email']),
                            style: const TextStyle(fontSize: 16)),
                        Text(newVal(user.data['phone']),
                            style: const TextStyle(fontSize: 16)),
                      ],
                    );
                  }
                  return Container();
                }),
            const SizedBox(height: 24),
            const Divider(
              color: Colors.grey,
            ),
            _buildOption(context, lngx.trans("home"), CupertinoIcons.home, null,
                () => goTo(context, const HomePage())),
            _buildOption(
                context,
                lngx.trans("settings"),
                CupertinoIcons.gear_alt,
                null,
                () => goTo(context, const Settings())),
            _buildOption(
                context,
                lngx.trans("new_card"),
                CupertinoIcons.creditcard,
                null,
                () => goTo(context, const OrderCard())),
            _buildOption(context, lngx.trans("change_pin"), CupertinoIcons.lock,
                null, () => goTo(context, const UpdatePinPage())),
            _buildOption(
                context,
                lngx.trans("reseller_account"),
                Icons.business,
                const Icon(
                  CupertinoIcons.circle_fill,
                  size: 15,
                ),
                () => message(lngx.trans("not_yet_available"), context)),
            _buildOption(context, lngx.trans("logout"), Icons.logout, null,
                () => logout(context, lngx.trans)),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(
      BuildContext context, String title, IconData icon, trailing, event) {
    return ListTile(
      leading: Icon(
        icon,
        color: mainColor,
      ),
      title: Text(title),
      onTap: event,
      trailing: trailing,
    );
  }
}
