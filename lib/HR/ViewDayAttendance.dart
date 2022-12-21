import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';

class DayAttendance extends StatefulWidget {
  final DocumentSnapshot post;
  DayAttendance({required this.post});
  @override
  _DayAttendanceState createState() => _DayAttendanceState();
}

class _DayAttendanceState extends State<DayAttendance> {
  AppMethods appMethod = FirebaseMethods();
  var presentEmpList = [];

  @override
  Widget build(BuildContext context) {
    presentEmpList = widget.post[presentEmp];
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
                      'Present Employees on ${widget.post[attendanceDate]}',
                      style: regular18pt,
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
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(usersData)
                      .where(empId, whereIn: presentEmpList)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: const CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: ListView(
                                children: snapshot.data!.docs.map((document) {
                                  return Container(
                                    padding: new EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                  'ID: ' + document[empId],
                                                  style: regular16pt.copyWith(
                                                      color: textBlack)),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                  'Name: ' + document[empName],
                                                  style: regular16pt.copyWith(
                                                      color: textBlack)),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                  'Email: ' +
                                                      document[empEmail],
                                                  style: regular16pt.copyWith(
                                                      color: textBlack)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
