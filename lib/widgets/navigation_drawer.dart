import 'package:flutter/material.dart';
import 'create_drawer_body_item.dart';
import 'create_drawer_header.dart';
import 'package:almighty/routes/page_route.dart';

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
            onTap: () =>
                Navigator.pushReplacementNamed(context, pageRoutes.profile),
          ),

          createDrawerBodyItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () =>
                Navigator.pushReplacementNamed(context, pageRoutes.login),
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