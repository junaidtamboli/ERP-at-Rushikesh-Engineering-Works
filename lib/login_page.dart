import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/Admin/AdminHome.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/Firebase/app_tools.dart';
import 'package:rushikesh_engg/HR/HR_Home.dart';
import 'package:rushikesh_engg/Marketing_Manager/Marketing_Manager_Home.dart';
import 'package:rushikesh_engg/Project_Manager/Project_Manager_Home.dart';
import 'package:rushikesh_engg/Password_Reset_Screen.dart';
import 'package:rushikesh_engg/TeamLeader/TeamLeaderHome.dart';
import 'theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AppMethods appMethod = FirebaseMethods();

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        getCurrentUser();
      }
    });
  }

  Future getCurrentUser() async {
    String acctType = await getStringDataLocally(key: empType);
    setState(() {});
    if (acctType == "Admin") {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => Admin_HomePage()));
    } else if (acctType == "Marketing Manager") {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => new Marketing_Manager_HomePage()));
    } else if (acctType == "HR") {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => HR_Manager_HomePage()));
    } else if (acctType == "Project Manager") {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => Project_Manager_HomePage()));
    } else if (acctType == "Team Leader") {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => TeamLeader_HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      'Login to your\naccount',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/accent.png',
                      width: 99,
                      height: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          controller: email,
                          decoration: InputDecoration(
                            hintText: 'Email ID',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: password,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: heading6.copyWith(color: textGrey),
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePassword,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordResetScreen()))
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot Password???', style: regular16pt),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Material(
                  borderRadius: BorderRadius.circular(14.0),
                  elevation: 0,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => verifyLogin(),
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Login',
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  verifyLogin() async {
    String? response =
        await appMethod.logginUser(email: email.text, password: password.text);
    if (response == successful) {
      Fluttertoast.showToast(msg: "Login Successful");
      String acctType = await getStringDataLocally(key: empType);
      if (acctType == "Admin") {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Admin_HomePage()));
      } else if (acctType == "Marketing Manager") {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Marketing_Manager_HomePage()));
      } else if (acctType == "HR") {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => HR_Manager_HomePage()));
      } else if (acctType == "Project Manager") {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Project_Manager_HomePage()));
      } else if (acctType == "Team Leader") {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => TeamLeader_HomePage()));
      }
    } else {
      Fluttertoast.showToast(msg: response);
    }
  }
}
