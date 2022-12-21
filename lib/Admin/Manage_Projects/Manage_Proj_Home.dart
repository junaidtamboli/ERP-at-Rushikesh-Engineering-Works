import 'package:flutter/material.dart';
import 'package:rushikesh_engg/Admin/Manage_Projects/Add_New_Proj.dart';
import 'package:rushikesh_engg/Admin/Manage_Projects/View_All_Proj.dart';
import 'package:rushikesh_engg/theme.dart';

class Manage_Proj_HomePage extends StatefulWidget {
  @override
  Manage_Proj_HomePageState createState() => new Manage_Proj_HomePageState();
}

class Manage_Proj_HomePageState extends State<Manage_Proj_HomePage> {
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
                      "Admin,",
                      style: heading2.copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Manage Projects",
                      style: heading2.copyWith(color: Colors.black),
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
      title: "Add New Project",
      img: "assets/images/new_project_icon.png",
      seqNo: 1);

  Items item2 = new Items(
    title: "View All Projects",
    img: "assets/images/project_icon.png",
    seqNo: 2,
  );

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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddNewProj()));
      break;

    case 2:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllProjects()));
      break;

    default:
  }
}
