import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/Admin/Manage_Clients/Manage_Clients_Home.dart';
import 'package:rushikesh_engg/Admin/Manage_Emp/Manage_Emp_Home.dart';
import 'package:rushikesh_engg/Admin/Manage_Projects/Manage_Proj_Home.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/Firebase/app_tools.dart';
import 'package:rushikesh_engg/Marketing_Manager/Add_New_Client.dart';
import 'package:rushikesh_engg/Marketing_Manager/Send_News_Letters.dart';
import 'package:rushikesh_engg/Marketing_Manager/ViewAllClients.dart';
import 'package:rushikesh_engg/login_page.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/myBottomSheet.dart';

class Marketing_Manager_HomePage extends StatefulWidget {
  @override
  Marketing_Manager_HomePageState createState() =>
      Marketing_Manager_HomePageState();
}

class Marketing_Manager_HomePageState
    extends State<Marketing_Manager_HomePage> {
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
                      "Welcome, Marketing Manager",
                      style: heading2.copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Home",
                      style: heading2.copyWith(color: Colors.black),
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
          //TODO Grid Dashboard
          GridDashboard()
        ],
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
    title: "Add New Client",
    img: "assets/images/new_client.png",
    seqNo: 1,
  );

  Items item2 = Items(
      title: "View All Clients",
      img: "assets/images/client_icon.png",
      seqNo: 2);
  Items item3 = Items(
      title: "Manage News Letters",
      img: "assets/images/news_letter.png",
      seqNo: 3);
  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3];
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
          context, MaterialPageRoute(builder: (context) => AddNewClient()));
      break;

    case 2:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllClients()));
      break;

    case 3:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SendNewsLetters()));
      break;
    default:
  }
}
