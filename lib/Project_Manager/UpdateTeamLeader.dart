import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/Dialog.dart';

class UpdateTeamLeader extends StatefulWidget {
  final DocumentSnapshot post;
  UpdateTeamLeader({required this.post});
  @override
  _UpdateTeamLeaderState createState() => _UpdateTeamLeaderState();
}

class _UpdateTeamLeaderState extends State<UpdateTeamLeader> {
  AppMethods appMethod = FirebaseMethods();
  TextEditingController _controller = TextEditingController();
  String? selectedTeamLeader;
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
                      'Update Team Leader',
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
                          return Text(
                            "Current Team Leader : ${data[empName]}",
                            style:
                                regular18pt.copyWith(color: Colors.blueAccent),
                          );
                        }

                        return const Text("loading");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    teamLeaderDropDownList(),
                    const SizedBox(
                      height: 20,
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
                            onTap: () async {
                              if (selectedTeamLeader != null) {
                                String res = await appMethod.updateTeamLeader(
                                    projectID: widget.post[projId],
                                    updatedTeamLeader: selectedTeamLeader!);
                                if (res == successful) {
                                  showSuccessDialog(
                                      context, "Update Successful", res);
                                } else {
                                  showErrorDialog(
                                      context, "Failed to update", res);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Select Team Leader");
                              }
                            },
                            borderRadius: BorderRadius.circular(14.0),
                            child: Center(
                              child: Text(
                                'Save',
                                style: heading5.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
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

  Widget teamLeaderDropDownList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(usersData)
          .where(empType, isEqualTo: "Team Leader")
          .snapshots(),
      builder: (context, documentsnapshot) {
        if (!documentsnapshot.hasData) {
          return const Text("Please wait...");
        } else {
          List<DropdownMenuItem> teamLeaderList = [];
          for (int i = 0; i < documentsnapshot.data!.docs.length; i++) {
            DocumentSnapshot docsnap = documentsnapshot.data!.docs[i];
            teamLeaderList.add(
              DropdownMenuItem(
                child: Text(
                  docsnap.get(empName),
                  style: regular16pt,
                ),
                value: docsnap.get(empId),
              ),
            );
          }
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: textWhiteGrey,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<dynamic>(
                elevation: 0,
                items: teamLeaderList,
                value: selectedTeamLeader,
                onChanged: (val) {
                  setState(() {
                    selectedTeamLeader = val;
                  });
                },
                isExpanded: false,
                hint: Text(
                  "Assign Team Leader",
                  style: regular12pt,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
