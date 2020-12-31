import 'package:almighty/pages/login.dart';
import 'package:almighty/pages/profile.dart';
import 'package:flutter/material.dart';
import 'create_drawer_body_item.dart';
import 'create_drawer_header.dart';

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.account_circle,
            text: 'Profile',
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => ProfilePage()));
            },
          ),
          createDrawerBodyItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => LoginPage()));
            }
          ),
          ListTile(
            title: Text(''),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}