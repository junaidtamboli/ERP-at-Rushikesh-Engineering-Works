import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';

class ProjectDetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  ProjectDetailPage({required this.post});
  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
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
                      'Project Details',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title : ${widget.post[projName]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "ID : ${widget.post[projId]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Description : ${widget.post[projDesc]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Start Date : ${widget.post[projStartDate]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "End Date : ${widget.post[projEndDate]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection(clientsdata)
                          .doc(widget.post[projClient])
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return const Text("Client Details not found");
                        }

                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return InkWell(
                            onTap: () => showClientInfoDialog(context, data),
                            child: Text(
                              "Client Name : ${data[clientName]}",
                              style: regular18pt.copyWith(
                                  color: Colors.blueAccent),
                            ),
                          );
                        }

                        return const Text("loading");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection(usersData)
                          .doc(widget.post[projManager])
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return const Text("Project Manager not found");
                        }

                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return InkWell(
                            onTap: () =>
                                showProjectManagerInfoDialog(context, data),
                            child: Text(
                              "Assigned Project Manager : ${data[empName]}",
                              style: regular18pt.copyWith(
                                  color: Colors.blueAccent),
                            ),
                          );
                        }

                        return const Text("loading");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection(usersData)
                          .doc(widget.post[projTeamLeader])
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
                          return InkWell(
                            onTap: () =>
                                showTeamLeaderInfoDialog(context, data),
                            child: Text(
                              "Assigned Team Leader : ${data[empName]}",
                              style: regular18pt.copyWith(
                                  color: Colors.blueAccent),
                            ),
                          );
                        }

                        return const Text("loading");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Project Status : ${widget.post[projStatus]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 20,
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

  void showClientInfoDialog(BuildContext context, Map<String, dynamic> data) {
    // ignore: avoid_single_cascade_in_expression_statements
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO_REVERSED,
      // width: 280,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Client Information',
      body: Column(
        children: [
          Text(
            "ID : ${data[clientId]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Name : ${data[clientName]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Contact : ${data[clientContact]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Email Id : ${data[clientEmail]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Fax No : ${data[clientFax]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Address : ${data[clientAddress]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
        ],
      ),
      showCloseIcon: true,
      btnOkOnPress: () {},
    )..show();
  }

  void showProjectManagerInfoDialog(
      BuildContext context, Map<String, dynamic> data) {
    // ignore: avoid_single_cascade_in_expression_statements
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO_REVERSED,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Project Manager Information',
      body: Column(
        children: [
          Text(
            "ID : ${data[empId]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Name : ${data[empName]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Contact : ${data[empContact]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Email Id : ${data[empEmail]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Address : ${data[empAddr]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
        ],
      ),
      showCloseIcon: true,
      btnOkOnPress: () {},
    )..show();
  }

  void showTeamLeaderInfoDialog(
      BuildContext context, Map<String, dynamic> data) {
    // ignore: avoid_single_cascade_in_expression_statements
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO_REVERSED,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Team Leader Information',
      body: Column(
        children: [
          Text(
            "ID : ${data[empId]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Name : ${data[empName]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Contact : ${data[empContact]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Email Id : ${data[empEmail]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
          Text(
            "Address : ${data[empAddr]}",
            style: regular18pt.copyWith(color: textBlack),
          ),
        ],
      ),
      showCloseIcon: true,
      btnOkOnPress: () {},
    )..show();
  }
}
