import 'package:appc/func/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProfilePage extends StatelessWidget {
  final String imageUrl = 'https://example.com/image.jpg';
  final String firstName = 'John';
  final String lastName = 'Doe';
  final String email = 'john.doe@example.com';
  final String phone = '+1234567890';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: backPage(context),
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
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
                    return Stack(
                      children: [
                        InkWell(
                          onTap: ()=>goTo(context, PhotoViewer(image:user.data['image'].toString())),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              user.data['image'].toString(),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () =>
                                  goTo(context, const ProfileImagePage()),
                              child: CircleAvatar(
                                backgroundColor: mainColor,
                                child: const Icon(
                                  CupertinoIcons.camera,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ))
                      ],
                    );
                  }
                  return const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/user.png"),
                  );
                }),
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
            const Divider(),
            _buildOption(context, 'Accueil', CupertinoIcons.home, null,
                () => goTo(context, const HomePage())),
            _buildOption(
                context, 'Paramètres', CupertinoIcons.gear_alt, null, null),
            _buildOption(context, 'Nouvelle Carte', CupertinoIcons.creditcard,
                null, () => goTo(context, const OrderCard())),
            // _buildOption(context, 'Éditer le Profil', Icons.edit, null, null),
            _buildOption(context, 'Changer le PIN', CupertinoIcons.lock, null,
                () => goTo(context, const UpdatePinPage())),
            _buildOption(
                context,
                'Compte Revendeur',
                Icons.business,
                const Icon(
                  CupertinoIcons.circle_fill,
                  size: 15,
                ),
                () => message("Pas encore disponible", context)),
            _buildOption(context, 'Déconnexion', Icons.logout, null,
                () => logout(context)),
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
