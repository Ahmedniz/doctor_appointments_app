import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userInfo = FirebaseAuth.instance.currentUser;
    final themColor = Theme.of(context).primaryColor;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: themColor),
              margin: EdgeInsets.zero,
              accountName: Text(
                "${userInfo?.displayName}",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
              ),
              accountEmail: Text(
                '${userInfo!.phoneNumber}',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(),
              ),
              currentAccountPicture: const CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'My Profile',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.health_and_safety,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {},
            title: Text(
              'Recent Doctors',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.wallet,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {},
            title: Text(
              'Wallet',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.readme,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'Refer a Friend',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.feedback,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'Give Feedback',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
            ),
            onTap: () {},
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamed('/');
            },
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
            ),
          ),
        ],
      ),
    );
  }
}
