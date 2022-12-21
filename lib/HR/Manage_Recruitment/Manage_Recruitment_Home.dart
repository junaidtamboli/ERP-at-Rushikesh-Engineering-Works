import 'package:flutter/material.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/HR/Manage_Recruitment/Create_Candidate_Profile.dart';
import 'package:rushikesh_engg/HR/Manage_Recruitment/ViewAllCandidates.dart';
import 'package:rushikesh_engg/theme.dart';

class Manage_Recruitment_HomePage extends StatefulWidget {
  @override
  Manage_Recruitment_HomePageState createState() =>
      Manage_Recruitment_HomePageState();
}

class Manage_Recruitment_HomePageState
    extends State<Manage_Recruitment_HomePage> {
  AppMethods appMethods = FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: 70),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Manage Recruitment",
                      style: heading2.copyWith(color: Colors.black),
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
              ],
            ),
          ),
          SizedBox(height: 40),
          GridDashboard()
        ],
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
    title: "Create Candidate Profile",
    img: "assets/images/add_new_emp_icon.png",
    seqNo: 1,
  );

  Items item2 = new Items(
      title: "View All Candidates",
      img: "assets/images/employee_icon.png",
      seqNo: 2);
  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2];
    var color = 0x4f86f7;
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return GestureDetector(
            onTap: () => navigation(data.seqNo, context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(data.img, width: 50, height: 50),
                  SizedBox(height: 14),
                  Text(
                    data.title,
                    style: regular16pt.copyWith(color: textBlack),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Items {
  String title;
  String img;
  int seqNo;
  Items({required this.title, required this.img, required this.seqNo});
}

navigation(int val, BuildContext context) {
  switch (val) {
    case 1:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Add_New_Candidate()));
      break;

    case 2:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllCandidates()));
      break;
    default:
  }
}
