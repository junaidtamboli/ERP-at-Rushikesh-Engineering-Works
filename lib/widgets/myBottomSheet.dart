import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/Firebase/app_tools.dart';
import 'package:rushikesh_engg/login_page.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/ProfileScreen.dart';

Future<dynamic> bottomSheet(BuildContext context, String userId) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection(usersData)
                .doc(userId)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text(
                  "Team Leader not Assigned yet",
                  style: regular18pt.copyWith(color: textBlack),
                );
              }

              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return ListTile(
                  leading: const Icon(Icons.person_sharp),
                  title: Text(
                    'View Profile',
                    style: regular18pt,
                  ),
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (BuildContext context) => ProfileScreen(
                              post: data,
                            )));
                  },
                );
              }

              return const Text("loading");
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: const Icon(Icons.logout_sharp),
            title: Text(
              'Logout',
              style: regular18pt,
            ),
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.WARNING,
                animType: AnimType.RIGHSLIDE,
                headerAnimationLoop: true,
                title: 'Are you sure want to logout',
                btnOkOnPress: () async {
                  bool res = await FirebaseMethods().logOutUser();
                  if (res == true) {
                    Fluttertoast.showToast(msg: "Logged out");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  } else {
                    Fluttertoast.showToast(msg: "Logout UnSuccessful");
                  }
                },
                btnOkColor: Colors.green,
                btnOkText: "Yes",
                btnCancelColor: Colors.red,
                btnCancelText: "No",
                btnCancelOnPress: () {},
              ).show();
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    },
  );
}

void showErrorDialog(BuildContext context, String title, String desc) {
  // ignore: avoid_single_cascade_in_expression_statements
  AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: true,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red)
    ..show();
}
