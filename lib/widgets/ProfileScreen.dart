import 'package:flutter/material.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> post;
  ProfileScreen({required this.post});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppMethods appMethod = FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Your Profile',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/accent.png',
                      width: 99,
                      height: 4,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name : ${widget.post[empName]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "ID : ${widget.post[empId]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Address : ${widget.post[empAddr]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Country : ${widget.post[empCountry]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "State : ${widget.post[empState]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "City : ${widget.post[empCity]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Contact No. : ${widget.post[empContact]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Email Id : ${widget.post[empEmail]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Employee Type : ${widget.post[empType]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Department Name : ${widget.post[empDept]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Date of Birth : ${widget.post[empDOB]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
