import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';

var tmpArray = [];
var list = [];

class MarkAttedance_TL extends StatefulWidget {
  @override
  _MarkAttedance_TLState createState() => _MarkAttedance_TLState();
}

class _MarkAttedance_TLState extends State<MarkAttedance_TL> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    tmpArray.clear();
    list.clear();
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
                      height: 30,
                    ),
                    Text(
                      'Mark Attedance',
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
                AttendancePageDesign(),
                SizedBox(
                  height: 10,
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
                          _AttendancePageDesignState().getCheckboxItems();
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
        ),
      ),
    );
  }
}

class Pair {
  final String id;
  final String name;
  bool? isPresent;

  Pair(this.id, this.name, this.isPresent);
}

class AttendancePageDesign extends StatefulWidget {
  @override
  _AttendancePageDesignState createState() => _AttendancePageDesignState();
}

class _AttendancePageDesignState extends State<AttendancePageDesign> {
  late Future data;

  AppMethods appMethods = FirebaseMethods();
  @override
  void initState() {
    super.initState();
    data = getData();
  }

  Future getData() async {
    var fireStore = FirebaseFirestore.instance;
    QuerySnapshot qn = await fireStore
        .collection(usersData)
        .where(empDept, isNotEqualTo: "Management")
        .get();

    qn.docs.forEach((element) {
      list.add(Pair(element[empId], element[empName], false));
    });

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              Pair pair = list.elementAt(index);
              return CheckboxListTile(
                title: Text(
                  pair.name,
                  style: regular12pt,
                ),
                subtitle: Text(pair.id),
                value: pair.isPresent,
                onChanged: (bool? value) {
                  setState(
                    () {
                      pair.isPresent = value;
                    },
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  getCheckboxItems() async {
    for (int i = 0; i < list.length; i++) {
      Pair pair = list.elementAt(i);
      print(pair.isPresent);
      if (pair.isPresent == true) {
        tmpArray.add(pair.id);
      }
    }
    String res = await appMethods.markAttendance(list: tmpArray);
    if (res == successful) {
      Fluttertoast.showToast(msg: "Attendance Mark Successfully");
      tmpArray.clear();
    } else {
      Fluttertoast.showToast(msg: "Error");
      tmpArray.clear();
    }
  }
}
