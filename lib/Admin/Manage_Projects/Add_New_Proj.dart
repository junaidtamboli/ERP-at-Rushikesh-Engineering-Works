import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/widgets/Custom_Text_Field.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';

class AddNewProj extends StatefulWidget {
  @override
  _AddNewProjState createState() => _AddNewProjState();
}

class _AddNewProjState extends State<AddNewProj> {
  AppMethods appMethod = FirebaseMethods();
  TextEditingController proj_name = TextEditingController();
  TextEditingController proj_desc = TextEditingController();
  TextEditingController proj_start_date = TextEditingController();
  TextEditingController proj_end_date = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedClient;
  String? selectedProjectManager;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool isStartDateUpdated = false;

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
                      'Add New Project',
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        controller: proj_name,
                        hintText: 'Project Name',
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter project name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: proj_desc,
                        maxLineCount: 3,
                        hintText: 'Project Description',
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter project Description';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          onTap: () => _selectStartDate(context),
                          readOnly: true,
                          controller: proj_start_date,
                          decoration: InputDecoration(
                            label: Text(
                              "Start Date",
                              style: regular12pt,
                            ),
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isStartDateUpdated == true
                          ? Container(
                              decoration: BoxDecoration(
                                color: textWhiteGrey,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: TextFormField(
                                onTap: () => _selectEndDate(context),
                                readOnly: true,
                                controller: proj_end_date,
                                decoration: InputDecoration(
                                  label: Text(
                                    "Expected End Date",
                                    style: regular12pt,
                                  ),
                                  hintStyle: heading6.copyWith(color: textGrey),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                      clientDropDownList(),
                      const SizedBox(
                        height: 20,
                      ),
                      projectManagerDropDownList(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
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
                        onTap: () {
                          if (_formKey.currentState!.validate() &&
                              proj_start_date.text.isNotEmpty &&
                              proj_end_date.text.isNotEmpty &&
                              selectedClient!.isNotEmpty &&
                              selectedProjectManager!.isNotEmpty &&
                              proj_start_date.text != proj_end_date.text) {
                            addnewProject();
                          } else if (proj_start_date.text.isEmpty) {
                            Fluttertoast.showToast(msg: "Select Start date");
                          } else if (proj_end_date.text.isEmpty) {
                            Fluttertoast.showToast(msg: "Select end date");
                          } else if (selectedClient!.isEmpty) {
                            Fluttertoast.showToast(msg: "Select client");
                          } else if (selectedProjectManager!.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Select project manager");
                          } else if (proj_start_date.text ==
                              proj_end_date.text) {
                            Fluttertoast.showToast(
                                msg: "Start and end date can't be same");
                          }
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      setState(() {
        startDate = pickedDate;
        proj_start_date.text = formatter.format(pickedDate).toString();
        isStartDateUpdated = true;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: startDate,
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      setState(() {
        endDate = pickedDate;
        proj_end_date.text = formatter.format(pickedDate).toString();
      });
    }
  }

  Widget clientDropDownList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(clientsdata).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text("Please wait...");
        } else {
          List<DropdownMenuItem> clientList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            DocumentSnapshot snap = snapshot.data!.docs[i];
            clientList.add(
              DropdownMenuItem(
                child: Text(
                  snap.get(clientName),
                  style: regular16pt,
                ),
                value: snap.get(clientId),
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
                items: clientList,
                value: selectedClient,
                onChanged: (clientValue) {
                  setState(() {
                    selectedClient = clientValue;
                  });
                },
                isExpanded: false,
                hint: Text(
                  "Choose Client",
                  style: regular12pt,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget projectManagerDropDownList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(usersData)
          .where(empType, isEqualTo: "Project Manager")
          .snapshots(),
      builder: (context, documentsnapshot) {
        if (!documentsnapshot.hasData) {
          return const Text("Please wait...");
        } else {
          List<DropdownMenuItem> managerList = [];
          for (int i = 0; i < documentsnapshot.data!.docs.length; i++) {
            DocumentSnapshot docsnap = documentsnapshot.data!.docs[i];
            managerList.add(
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
                items: managerList,
                value: selectedProjectManager,
                onChanged: (projManagerValue) {
                  setState(() {
                    selectedProjectManager = projManagerValue;
                  });
                },
                isExpanded: false,
                hint: Text(
                  "Assign Project Manager",
                  style: regular12pt,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  addnewProject() async {
    String res = await appMethod.createNewProject(
      proj_name: proj_name.text,
      proj_desc: proj_desc.text,
      proj_start_date: proj_start_date.text,
      proj_end_date: proj_end_date.text,
      proj_client: selectedClient.toString(),
      proj_manager: selectedProjectManager.toString(),
    );
    if (res == successful) {
      Fluttertoast.showToast(msg: "Project Created");
    } else {
      Fluttertoast.showToast(msg: "Failed to create project");
    }
  }
}

Widget myTextField(
    String hintText, TextEditingController controller, int maxLines) {
  return Container(
    decoration: BoxDecoration(
      color: textWhiteGrey,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        label: Text(
          hintText,
          style: regular12pt,
        ),
        hintStyle: heading6.copyWith(color: textGrey),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
