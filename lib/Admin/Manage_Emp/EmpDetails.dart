import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/Admin/Manage_Emp/UpdateEmpDetails.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';

class EmpDetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  EmpDetailPage({required this.post});
  @override
  _EmpDetailPageState createState() => _EmpDetailPageState();
}

class _EmpDetailPageState extends State<EmpDetailPage> {
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
                      'Employee Details',
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
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Joining Date : ${widget.post[empDOB]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    widget.post[empType] == 'HR'
                        ? Material(
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateEmpDetails(
                                                  post: widget.post,
                                                )));
                                  },
                                  borderRadius: BorderRadius.circular(14.0),
                                  child: Center(
                                    child: Text(
                                      'Update Details',
                                      style: heading5.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 15,
                    ),
                    widget.post[empType] == 'HR'
                        ? Material(
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
                                  onTap: () {
                                    showInfoDialog(context);
                                  },
                                  borderRadius: BorderRadius.circular(14.0),
                                  child: Center(
                                    child: Text(
                                      'Remove Employee',
                                      style: heading5.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInfoDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO_REVERSED,
      borderSide: const BorderSide(color: Colors.green, width: 2),
      width: 280,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Alert',
      desc: 'Are You sure want to delete',
      showCloseIcon: false,
      btnCancelText: "No",
      btnCancelOnPress: () {},
      btnOkText: "Yes",
      btnOkOnPress: () async {
        String res =
            await appMethod.deleteUserAccount(userId: widget.post[empId]);

        if (res == successful) {
          Fluttertoast.showToast(msg: "Deleted Successfully");
        } else {
          Fluttertoast.showToast(msg: "Delete Unsuccessfull");
        }
      },
    )..show();
  }
}
