import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rushikesh_engg/Admin/Manage_Emp/EmpDetails.dart';
import 'package:rushikesh_engg/Admin/Manage_Projects/Proj_Details.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';

class AllProjects extends StatefulWidget {
  @override
  _AllProjectsState createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {
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
                      'All Projects',
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
                ProjectListWidget(),
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
        builder: (context) => ProjectDetailPage(
          post: post,
        ),
      ),
    );
  }

  Widget ProjectListWidget() {
    return StreamBuilder(
      stream: firestore.collection(projectsdata).snapshots(),
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
            physics: ClampingScrollPhysics(),
            children: snapshot.data!.docs.map((document) {
              return Container(
                padding: new EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () => navigateToDetail(document),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Project ID: ' + document[projId],
                                style: regular16pt.copyWith(color: textBlack)),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Project Name: ' + document[projName],
                                style: regular16pt.copyWith(color: textBlack)),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Client Name: ' + document[projClient],
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

// class ProjectListPage extends StatefulWidget {
//   @override
//   _ProjectListPageState createState() => _ProjectListPageState();
// }

// class _ProjectListPageState extends State<ProjectListPage> {
//   late Future data;
//   @override
//   void initState() {
//     super.initState();
//     data = getData();
//   }

//   Future getData() async {
//     var fireStore = FirebaseFirestore.instance;
//     QuerySnapshot qn = await fireStore.collection(projectsdata).get();
//     return qn.docs;
//   }

//   navigateToDetail(DocumentSnapshot post) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ProjectDetailPage(
//           post: post,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: data,
//       builder: (context, AsyncSnapshot snapshot) {
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               "Something Went Wrong",
//               style: regular18pt,
//             ),
//           );
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
//                                             'ID: ' +
//                                                 snapshot.data[index][projId],
//                                             style: regular16pt.copyWith(
//                                                 color: textBlack)),
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                         child: Text(
//                                           'Title: ' +
//                                               snapshot.data[index][projName],
//                                           style: regular16pt.copyWith(
//                                               color: textBlack),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                         child: Text(
//                                           'Client Name: ' +
//                                               snapshot.data[index][projClient],
//                                           style: regular16pt.copyWith(
//                                               color: textBlack),
//                                         ),
//                                       ),
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
