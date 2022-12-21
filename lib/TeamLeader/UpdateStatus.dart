import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rushikesh_engg/Firebase/appData.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/Dialog.dart';

class UpdateProjectStatus extends StatefulWidget {
  final DocumentSnapshot post;
  UpdateProjectStatus({required this.post});
  @override
  _UpdateProjectStatusState createState() => _UpdateProjectStatusState();
}

class _UpdateProjectStatusState extends State<UpdateProjectStatus> {
  AppMethods appMethod = FirebaseMethods();
  String? status;
  final _formKey = GlobalKey<FormState>();
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
                      'Update Project Status',
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
                        "Current Status : ${widget.post[projStatus]}",
                        style: regular18pt.copyWith(color: textBlack),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            value: status,
                            items: projectStatusList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                status = newValue!;
                              });
                            },
                          ),
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
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  String res =
                                      await appMethod.updateProjectStatus(
                                    projectID: widget.post[projId],
                                    status: status!,
                                  );
                                  if (res == successful) {
                                    showSuccessDialog(context,
                                        "Status Updated Successful", res);
                                  } else {
                                    showErrorDialog(
                                        context, "Status update failed", res);
                                  }
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
