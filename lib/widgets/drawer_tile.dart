import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app_working/pages/login_page.dart';
import 'package:share/share.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    String displayNameInitial = '';
    if (user?.displayName != null && user!.displayName!.isNotEmpty) {
      displayNameInitial = user.displayName![0].toUpperCase();
    }

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue, // Customize color if needed
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Text(
                displayNameInitial,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            accountEmail: Text(
              user?.email ?? 'No Email',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            accountName: Text(
              user?.displayName ?? 'No Name',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          const Divider(),
          DrawerTile(
            text: 'H O M E',
            icon: Icons.home,
            onTap: () => Navigator.pop(context), // Close the drawer
          ),
          DrawerTile(
            text: 'S H A R E',
            icon: Icons.share,
            onTap: () {
              Share.share('Check out this awesome app!');
            },
          ),
          DrawerTile(
            text: 'S I G N O U T',
            icon: Icons.logout,
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      emailController: TextEditingController(),
                      passwordController: TextEditingController(),
                      onTap: () {},
                    ),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Failed to sign out: ${e.toString()}')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
  });

  final String text;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        title: Text(text),
        leading: Icon(icon),
        onTap: onTap,
      ),
    );
  }
}
