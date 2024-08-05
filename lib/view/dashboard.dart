import 'dart:io';

import 'package:bedrockequipments/view/attendance_history.dart';
import 'package:bedrockequipments/view/loginpage.dart';
import 'package:bedrockequipments/view/timesheet.dart';
import 'package:bedrockequipments/widgets/pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DashbordPage extends StatefulWidget {
  const DashbordPage({super.key});

  @override
  State<DashbordPage> createState() => _DashbordPageState();
}

class _DashbordPageState extends State<DashbordPage> {
  Future<Directory?>? _externalDocumentsDirectory;
  List<CategoryMenu> categories = [
    CategoryMenu(
        iconData: "assets/images/ic_attendance.svg", name: "Attendance"),
    CategoryMenu(iconData: "assets/images/ic_timesheet.svg", name: "Timesheet"),
    // CategoryMenu(
    //     iconData: "assets/images/trusticon.png", name: "Ticket Allocation"),
    CategoryMenu(iconData: "assets/images/ic_logout.svg", name: "Logout"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFFffc700),
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFffc700),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          child: const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: ListTile(
              title: Text(
                'Karthi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Welcome back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage(
                  'assets/images/ic_avatar.png',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1.2),
          itemCount: categories.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Attendancehistory()),
                  );
                } else if (index == 1) {
                  !Platform.isAndroid
                      ? null
                      : _requestExternalStorageDirectory();
                } else {
                  Prefs.clear();
                  Prefs.remove("remove");
                  Prefs.setLoggedIn("IsLoggedIn", false);
                  // Navigator.pushReplacement<void, void>(
                  //   context,
                  //   MaterialPageRoute<void>(
                  //     builder: (BuildContext context) => const LoginPage(),
                  //   ),
                  // );
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false);
                }
              },
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(16),
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFffc700),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SvgPicture.asset(
                        categories[index].iconData.toString(),
                        color: Colors.white,
                      )),
                  const SizedBox(height: 4),
                  Text(
                    categories[index].name.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              ),
            );
          },
        )
      ]),
    );
  }

  void _requestExternalStorageDirectory() {
    setState(() {
      _externalDocumentsDirectory = getExternalStorageDirectory();
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TimesheetPage()),
    );
  }
}

class CategoryMenu {
  String? iconData;
  String? name;

  CategoryMenu({this.iconData, this.name});
}
