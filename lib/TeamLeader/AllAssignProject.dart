import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rushikesh_engg/Firebase/appData.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/TeamLeader/ProjectDetails_TL.dart';
import 'package:rushikesh_engg/theme.dart';

class AllProjects_TeamLeader extends StatefulWidget {
  @override
  _AllProjects_TeamLeaderState createState() => _AllProjects_TeamLeaderState();
}

class _AllProjects_TeamLeaderState extends State<AllProjects_TeamLeader> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectDetailPage_TL(
          post: post,
        ),
      ),
    );
  }

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
                      'All Projects',
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
                  height: 25,
                ),
                Text(
                  "Ongoing Projects",
                  style: regular20pt,
                ),
                const SizedBox(
                  height: 10,
                ),
                ongoingProjectWidget(),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Deployed Projects",
                  style: regular20pt,
                ),
                const SizedBox(
                  height: 10,
                ),
                deployedProjectWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ongoingProjectWidget() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(projectsdata)
          .where(projStatus, isNotEqualTo: projectStatusList.last)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: const CircularProgressIndicator());
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
            physics: const ClampingScrollPhysics(),
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
                            child: Text('ID: ' + document[projId],
                                style: regular16pt.copyWith(color: textBlack)),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Name: ' + document[projName],
                                style: regular16pt.copyWith(color: textBlack)),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection(clientsdata)
                                  .doc(document[projClient])
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Something went wrong");
                                }

                                if (snapshot.hasData &&
                                    !snapshot.data!.exists) {
                                  return const Text("Project Client not found");
                                }

                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;
                                  return Text(
                                    "Client Name: ${data[clientName]}",
                                    style: regular18pt.copyWith(
                                        color: Colors.blueAccent),
                                  );
                                }

                                return const Text("loading");
                              },
                            ),
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
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }

  Widget deployedProjectWidget() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(projectsdata)
          .where(projStatus, isEqualTo: projectStatusList.last)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
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
            physics: const ClampingScrollPhysics(),
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
                            child: Text('ID: ' + document[projId],
                                style: regular16pt.copyWith(color: textBlack)),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Name: ' + document[projName],
                                style: regular16pt.copyWith(color: textBlack)),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection(clientsdata)
                                  .doc(document[projClient])
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Something went wrong");
                                }

                                if (snapshot.hasData &&
                                    !snapshot.data!.exists) {
                                  return const Text("Project Client not found");
                                }

                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;
                                  return Text(
                                    "Client Name: ${data[clientName]}",
                                    style: regular18pt.copyWith(
                                        color: Colors.blueAccent),
                                  );
                                }

                                return const Text("loading");
                              },
                            ),
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
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}
