import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rushikesh_engg/Firebase/appData.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/HR/Manage_Employees/Create_Emp_Profile.dart';
import 'package:rushikesh_engg/theme.dart';

class SelectedCandidates extends StatefulWidget {
  @override
  _SelectedCandidatesState createState() => _SelectedCandidatesState();
}

class _SelectedCandidatesState extends State<SelectedCandidates> {
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
                      'Selected Candidates',
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
                CandidateListPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CandidateListPage extends StatefulWidget {
  @override
  _CandidateListPagePageState createState() => _CandidateListPagePageState();
}

class _CandidateListPagePageState extends State<CandidateListPage> {
  late Future data;
  @override
  void initState() {
    super.initState();
    data = getData();
  }

  Future getData() async {
    var fireStore = FirebaseFirestore.instance;
    QuerySnapshot qn = await fireStore
        .collection(candidatesData)
        .where(candidateStatus, isEqualTo: candidateStatusList.last)
        .get();
    return qn.docs;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateEmpProfile(
                  post: post,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => navigateToDetail(snapshot.data[index]),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8.0),
                          // ignore: unnecessary_new
                          child: new Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            // elevation: 10.0,
                            // ignore: unnecessary_new
                            child: new Container(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            'ID: ' +
                                                snapshot.data[index]
                                                    [candidateId],
                                            style: regular16pt.copyWith(
                                                color: textBlack)),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Name: ' +
                                              snapshot.data[index]
                                                  [candidateName],
                                          style: regular16pt.copyWith(
                                              color: textBlack),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Email: ' +
                                              snapshot.data[index]
                                                  [candidateEmail],
                                          style: regular16pt.copyWith(
                                              color: textBlack),
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
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
