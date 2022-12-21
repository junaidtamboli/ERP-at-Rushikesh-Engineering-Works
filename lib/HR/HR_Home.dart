import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/Firebase/app_tools.dart';
import 'package:rushikesh_engg/HR/Manage_Employees/Manage_Employees_Home.dart';
import 'package:rushikesh_engg/HR/Manage_Recruitment/Manage_Recruitment_Home.dart';
import 'package:rushikesh_engg/HR/Mark_Attendance.dart';
import 'package:rushikesh_engg/HR/ViewAttendance.dart';
import 'package:rushikesh_engg/login_page.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/myBottomSheet.dart';

class HR_Manager_HomePage extends StatefulWidget {
  @override
  HR_Manager_HomePageState createState() => HR_Manager_HomePageState();
}

class HR_Manager_HomePageState extends State<HR_Manager_HomePage> {
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
                      "Welcome, HR Manager",
                      style: heading2.copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Home",
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
                IconButton(
                  onPressed: () async {
                    bottomSheet(
                      context,
                      await getStringDataLocally(key: empId),
                    );
                  },
                  alignment: Alignment.topCenter,
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                  ),
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
    title: "Manage Recruitment",
    img: "assets/images/recruitment_icon.png",
    seqNo: 1,
  );

  Items item2 = new Items(
    title: "Manage Employees",
    img: "assets/images/employee_icon.png",
    seqNo: 2,
  );
  Items item3 = new Items(
    title: "Mark Attendance",
    img: "assets/images/attendance_icon.png",
    seqNo: 3,
  );
  Items item4 = new Items(
    title: "View Attendance",
    img: "assets/images/attendance_icon.png",
    seqNo: 4,
  );
  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];
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
        context,
        MaterialPageRoute(
          builder: (context) => Manage_Recruitment_HomePage(),
        ),
      );
      break;

    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Manage_Employee_HomePage(),
        ),
      );
      break;

    case 3:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MarkManagerAttedance(),
        ),
      );
      break;

    case 4:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewAttendance(),
        ),
      );
      break;
    default:
  }
}
