import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/Dialog.dart';

var tmpArray = [];
var list = [];

class MarkManagerAttedance extends StatefulWidget {
  @override
  _MarkManagerAttedanceState createState() => _MarkManagerAttedanceState();
}

class _MarkManagerAttedanceState extends State<MarkManagerAttedance> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AppMethods appMethods = FirebaseMethods();
  _AttendancePageDesignState __attendancePageDesignState =
      _AttendancePageDesignState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tmpArray.clear();
    list.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Mark Manager\'s Attedance',
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
                AttendancePageDesign(),
                const SizedBox(
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
                        onTap: () =>
                            __attendancePageDesignState.getCheckboxItems(),
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
                const SizedBox(
                  height: 20,
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
        .where(empDept, isEqualTo: "Management")
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
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
      showSuccessDialog(context, "Attendance Mark Successfully", res);
    } else {
      showErrorDialog(context, "Failed to mark attendance", res);
    }
    tmpArray.clear();
  }
}
