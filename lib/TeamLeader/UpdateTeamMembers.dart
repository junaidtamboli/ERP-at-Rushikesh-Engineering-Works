import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/Dialog.dart';

class UpdateTeamMembers extends StatefulWidget {
  final DocumentSnapshot post;
  UpdateTeamMembers({required this.post});
  @override
  _UpdateTeamMembersState createState() => _UpdateTeamMembersState();
}

class _UpdateTeamMembersState extends State<UpdateTeamMembers> {
  AppMethods appMethod = FirebaseMethods();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var selectedTeamMembers = [];
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
                      'Update Team Members',
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
                          .doc(widget.post[projManager])
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            "Something went wrong",
                            style: regular18pt.copyWith(color: textBlack),
                          );
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Text(
                            "Project Manager not found",
                            style: regular18pt.copyWith(color: textBlack),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Text(
                            "Assigned  Project Manager : ${data[empName]}",
                            style: regular18pt.copyWith(color: textBlack),
                          );
                        }

                        return const Text("loading");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Current Team Members : ",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    TeamMembersListWidget(),
                    const SizedBox(
                      height: 15,
                    ),
                    teamMembersDropDownList(),
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
                              String res = await appMethod.updateTeamMembers(
                                projectID: widget.post[projId],
                                teamMembers: selectedTeamMembers,
                              );
                              if (res == successful) {
                                showSuccessDialog(context, "Successful", res);
                              } else {
                                showErrorDialog(context, "Update Failed", res);
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

  Widget TeamMembersListWidget() {
    return StreamBuilder(
      stream: firestore
          .collection(usersData)
          .where(empId, whereIn: widget.post[projMembers])
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text(
            "Something Went wrong",
            style: regular18pt,
          );
        } else if (!snapshot.hasData) {
          return Text(
            "Team Members not yet assigned",
            style: regular18pt,
          );
        } else if (snapshot.hasData) {
          return ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: snapshot.data!.docs.map((document) {
              return Text(
                document[empName],
                style: regular16pt,
              );
            }).toList(),
          );
        } else {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
      },
    );
  }

  Widget teamMembersDropDownList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(usersData)
          .where(empDept, isEqualTo: "Other")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text("Please wait...");
        } else {
          List<MultiSelectItem> clientList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            DocumentSnapshot snap = snapshot.data!.docs[i];
            clientList.add(
              MultiSelectItem(
                snap.get(empId),
                snap.get(empName),
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
              child: MultiSelectDialogField(
                searchable: true,
                onConfirm: (val) {
                  selectedTeamMembers = val;
                },
                dialogWidth: MediaQuery.of(context).size.width * 0.7,
                items: clientList,
                initialValue: selectedTeamMembers,
              ),
            ),
          );
        }
      },
    );
  }
}
