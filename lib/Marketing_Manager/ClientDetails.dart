import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';

class ClientDetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  ClientDetailPage({required this.post});
  @override
  _ClientDetailPageState createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  AppMethods appMethod = FirebaseMethods();
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
                      'Client Details',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name : ${widget.post[clientName]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "ID : ${widget.post[clientId]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Address : ${widget.post[clientAddress]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Country : ${widget.post[clientCountry]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "State : ${widget.post[clientState]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "City : ${widget.post[clientCity]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Contact No. : ${widget.post[clientContact]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Email ID : ${widget.post[clientEmail]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Fax No. : ${widget.post[clientFax]}",
                      style: regular18pt.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection(usersData)
                          .doc(widget.post[clientMarketingManager])
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            "Something went wrong",
                            style: regular18pt.copyWith(color: textBlack),
                          );
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Text(
                            "Project Manager not found",
                            style: regular18pt.copyWith(color: textBlack),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Text(
                            "Assigned  Marketing Manager : ${data[empName]}",
                            style: regular18pt.copyWith(color: textBlack),
                          );
                        }

                        return const Text("loading");
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
