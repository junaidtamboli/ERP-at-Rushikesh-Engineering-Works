import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/HR/Manage_Recruitment/CandidateDetails.dart';
import 'package:rushikesh_engg/theme.dart';

class AllCandidates extends StatefulWidget {
  @override
  _AllCandidatesState createState() => _AllCandidatesState();
}

class _AllCandidatesState extends State<AllCandidates> {
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
                      'All Candidates',
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
                CandidateListWidget(),
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
            builder: (context) => CandidateDetailPage(
                  post: post,
                )));
  }

  Widget CandidateListWidget() {
    return StreamBuilder(
      stream: firestore.collection(candidatesData).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
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
            physics: const ClampingScrollPhysics(),
            children: snapshot.data!.docs.map((document) {
              return Container(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () => navigateToDetail(document),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('ID: ' + document[candidateId],
                                style: regular16pt.copyWith(color: textBlack)),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Name: ' + document[candidateName],
                                style: regular16pt.copyWith(color: textBlack)),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Email: ' + document[candidateEmail],
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
