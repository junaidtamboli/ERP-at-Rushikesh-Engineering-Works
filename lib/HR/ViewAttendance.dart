import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/HR/Manage_Employees/EmpDetails_HR.dart';
import 'package:rushikesh_engg/HR/ViewDayAttendance.dart';
import 'package:rushikesh_engg/theme.dart';

class ViewAttendance extends StatefulWidget {
  @override
  _ViewAttendanceState createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

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
                      'View Attendance',
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
                AttendanceListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DayAttendance(
                  post: post,
                )));
  }

  Widget AttendanceListWidget() {
    return StreamBuilder(
      stream: firestore
          .collection(attendanceData)
          .orderBy(attendanceDate, descending: false)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text(
              "No data found",
              style: regular18pt,
            ),
          );
        } else if (snapshot.hasData) {
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((document) {
              return Container(
                padding: EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () => navigateToDetail(document),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Date: ' + document[attendanceDate],
                                style: regular16pt.copyWith(color: textBlack)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
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
}

// class AtttendanceListPage extends StatefulWidget {
//   @override
//   _AtttendanceListPageState createState() => _AtttendanceListPageState();
// }

// class _AtttendanceListPageState extends State<AtttendanceListPage> {
//   late Future data;
//   @override
//   void initState() {
//     super.initState();
//     data = getData();
//   }

//   Future getData() async {
//     var fireStore = FirebaseFirestore.instance;
//     QuerySnapshot qn = await fireStore
//         .collection(attendanceData)
//         .orderBy(attendanceDate, descending: false)
//         .get();
//     return qn.docs;
//   }

//   navigateToDetail(DocumentSnapshot post) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => DayAttendance(
//                   post: post,
//                 )));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: data,
//       builder: (context, AsyncSnapshot snapshot) {
//         if (!snapshot.hasData) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           return Row(
//             children: [
//               Expanded(
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height,
//                   child: ListView.builder(
//                     itemCount: snapshot.data.length,
//                     scrollDirection: Axis.vertical,
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () => navigateToDetail(snapshot.data[index]),
//                         child: Container(
//                           margin: EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 8.0),
//                           child: new Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(20.0))),
//                             // elevation: 10.0,
//                             child: new Container(
//                               padding: new EdgeInsets.all(12.0),
//                               child: new Column(
//                                 children: <Widget>[
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                         child: Text(
//                                             'Date : ' +
//                                                 snapshot.data[index]
//                                                     [attendanceDate],
//                                             style: regular16pt.copyWith(
//                                                 color: textBlack)),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }
