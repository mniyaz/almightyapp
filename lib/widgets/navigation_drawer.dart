import 'package:almighty/pages/login.dart';
import 'package:almighty/pages/profile.dart';
import 'package:flutter/material.dart';
import 'create_drawer_body_item.dart';
import 'create_drawer_header.dart';
import 'package:almighty/globals.dart' as globals;
import 'package:almighty/services/local_data_service.dart';
import 'package:almighty/models/contact_model.dart';
import 'dart:convert';

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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => ProfilePage()));
            },
          ),
          createDrawerBodyItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () async {
                Contact contact = await LocalService.loadContact();
                contact.contactMobile = "";
                LocalService.saveAPIData(
                    globals.CONTACT_KEY, json.encode(contact));
                LocalService.saveAPIData(globals.AUTH_KEY, "");
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginPage()));
              }),
          ListTile(
            title: Text(''),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
