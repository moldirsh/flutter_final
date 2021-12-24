import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_app/models/user_model.dart';
import 'package:online_shop_app/pages/login.dart';

import '../pages/calendar.dart';
import '../pages/home.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void initState (){
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value){
          this.loggedInUser = UserModel.fromMap(value.data());
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    final name;
    final email;
    return Drawer(
      child: Container(
        color: Colors.grey[800],
        child: ListView(
          children: <Widget>[
            buildHeader(
              name: "${loggedInUser.firstName} ${loggedInUser.secondName}",
              email: "${loggedInUser.email}",
            ),
            buildMenuItem(
              text: 'Calendar',
              icon: Icons.calendar_today_outlined,
              onClicked: () => selectedItem(context, 0),
            ),
            SizedBox(height: 15,),
            buildMenuItem(
              text: 'Notes',
              icon: Icons.notes_outlined,
              onClicked: () => selectedItem(context, 1),
            ),
            SizedBox(height: 15,),
            buildMenuItem(
              text: 'Map',
              icon: Icons.map_outlined,
              onClicked: () => selectedItem(context, 2),
            ),
            SizedBox(height: 15,),
            buildMenuItem(
              text: 'Dark mode',
              icon: Icons.toggle_off_outlined,
              onClicked: () => selectedItem(context, 3),
            ),
            SizedBox(height: 24,),
            Divider(color: Colors.white70,),
            SizedBox(height: 24),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () => selectedItem(context, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader ({
    required String name,
    required String email,
}) =>
  InkWell(
    child: Container(
      padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(color: Colors.white, fontSize: 20),),
          SizedBox(height: 4,),
          Text(email, style: TextStyle(color: Colors.white, fontSize: 14),)
        ],
      ),
    ),
  );

  Widget buildMenuItem ({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
}) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: color,),
      title: Text(text, style: TextStyle(color: color),),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

    void selectedItem (BuildContext context, int index) {
    Navigator.of(context).pop();
      switch (index) {
        case 0:
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Calendar(),));
          break;
        case 1:
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));
          break;
        case 2:
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));
          break;
        case 3:
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));
          break;
        case 4:
          logout(context);
          break;
      }
    }

    Future<void> logout (BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    }
}
