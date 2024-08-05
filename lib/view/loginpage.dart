import 'dart:convert';

import 'package:bedrockequipments/model/loginmodel.dart';
import 'package:bedrockequipments/service/apiservice.dart';
import 'package:bedrockequipments/view/dashboard.dart';
import 'package:bedrockequipments/widgets/app_utils.dart';
import 'package:bedrockequipments/widgets/pref.dart';
import 'package:bedrockequipments/widgets/sharedprefconstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  LoginModel loginModel = LoginModel();
  @override
  void dispose() {
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: !loading
          ? SafeArea(
              child: Column(
                children: [
                  //to give space from top
                  const Expanded(
                    flex: 1,
                    child: Center(),
                  ),

                  //page content here
                  Expanded(
                    flex: 9,
                    child: buildCard(size),
                  ),
                ],
              ),
            )
          : const Center(
              child: CupertinoActivityIndicator(
                  radius: 30.0, color: Color(0xFFffc700)),
            ),
    );
  }

  Widget buildCard(Size size) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //header text
            Text(
              'Login Account',
              style: GoogleFonts.inter(
                fontSize: 24.0,
                color: const Color(0xFF15224F),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              'Discover your social & Try to Login',
              style: GoogleFonts.poppins(
                fontSize: 14.0,
                color: const Color(0xFF969AA8),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.04,
            ),

            //logo section
            // logo(size.height / 8, size.height / 8),
            // SizedBox(
            //   height: size.height * 0.03,
            // ),
            // richText(24),
            // SizedBox(
            //   height: size.height * 0.05,
            // ),

            //email & password section
            emailTextField(size),
            SizedBox(
              height: size.height * 0.02,
            ),
            passwordTextField(size),
            SizedBox(
              height: size.height * 0.03,
            ),

            //sign in button
            signInButton(size),
            SizedBox(
              height: size.height * 0.04,
            ),

            //footer section. sign up text here
            footerText(),
          ],
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/images/logo.png',
      height: height_,
      width: width_,
    );
  }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          color: const Color(0xFF50C878),
          letterSpacing: 2.000000061035156,
        ),
        children: const [
          TextSpan(
            text: 'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'PAGE',
            style: TextStyle(
              color: Color(0xFFFE9879),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget emailTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 14,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFffc700),
        ),
      ),
      child: TextField(
        controller: usernamecontroller,
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF15224F),
        ),
        maxLines: 1,
        cursorColor: const Color(0xFF15224F),
        decoration: InputDecoration(
            icon: const Icon(CupertinoIcons.person_alt_circle,
                color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            labelText: 'User Name',
            labelStyle: GoogleFonts.poppins(
              fontSize: 12.0,
              color: const Color(0xFF969AA8),
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget passwordTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 14,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFffc700),
        ),
      ),
      child: TextField(
        controller: passwordcontroller,
        style: GoogleFonts.aBeeZee(
          fontSize: 16.0,
          color: const Color(0xFF15224F),
        ),
        maxLines: 1,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        cursorColor: const Color(0xFF15224F),
        decoration: InputDecoration(
            icon: const Icon(CupertinoIcons.lock_circle, color: Colors.black38),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            labelText: 'Password',
            labelStyle: GoogleFonts.poppins(
              fontSize: 12.0,
              color: const Color(0xFF969AA8),
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget signInButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (usernamecontroller.text.isEmpty) {
          AppUtils.showSingleDialogPopup(
              context, "Enter user Name", "Ok", onexitpopup);
        } else if (passwordcontroller.text.isEmpty) {
          AppUtils.showSingleDialogPopup(
              context, "Enter password", "Ok", onexitpopup);
        } else {
          getlogin();
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: size.height / 14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: const Color(0xFFffc700),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C2E84).withOpacity(0.2),
              offset: const Offset(0, 15.0),
              blurRadius: 60.0,
            ),
          ],
        ),
        child: Text(
          'Sign in',
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget footerText() {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: 12.0,
          color: const Color(0xFFffc700),
        ),
        children: const [
          TextSpan(
            text: 'Don’t have an account ?',
          ),
          TextSpan(
            text: ' ',
            style: TextStyle(
              color: Color(0xFFFF5844),
            ),
          ),
          TextSpan(
            text: 'Sign up',
            style: TextStyle(
              color: Color(0xFFFF5844),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  void getlogin() async {
    setState(() {
      loading = true;
    });
    Apiservice.getlogin(usernamecontroller.text, passwordcontroller.text)
        .then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          loginModel = LoginModel.fromJson(jsonDecode(response.body));
          if (loginModel.message!.mobileaccess.toString() == "false") {
            AppUtils.showSingleDialogPopup(
                context,
                "You Are Not Authorised Mobile User. Please Contact Your Administrator!.",
                "Ok",
                onexitpopup);
          } else {
            addsharedpref(loginModel);
          }
        } else {
          AppUtils.showSingleDialogPopup(
              context, jsonDecode(response.body)['message'], "Ok", onexitpopup);
        }
      } else {
        throw Exception(jsonDecode(response.body)['message'].toString());
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", onexitpopup);
    });
  }

  void onexitpopup() {
    Navigator.of(context).pop();
  }

  Future addsharedpref(LoginModel model) async {
    await Prefs.setLoggedIn(SharefprefConstants.sharefloggedin, true);
    await Prefs.setFullName(
        SharefprefConstants.shareFullName,
        '${model.message!.firstName.toString()} '
        ' ${model.message!.middleName.toString()} '
        ' ${model.message!.lastName.toString()}');
    await Prefs.setEmpID(
        SharefprefConstants.sharedempId, model.message!.employeeId!.toString());
    await Prefs.setUniqId(
        SharefprefConstants.shareduniqId, model.message!.sId.toString());
    await Prefs.setUserName(SharefprefConstants.shareduserName,
        model.message!.mobileusername.toString());
    await Prefs.setToken(
        SharefprefConstants.sharedToken, model.token!.toString());
    await Prefs.setDesignation(SharefprefConstants.shareddesignation,
        model.message!.designation.toString());

    await Prefs.setNsID(
        SharefprefConstants.sharednsid, model.message!.nsId!.toInt() ?? 0);

    await Prefs.setShiftName(SharefprefConstants.sharedshiftName,
        "GENERAL SHIFT (10:00 AM - 06:30 PM)");
    await Prefs.setShiftFromTime(
        SharefprefConstants.sharedShiftFromTime, "10:00 AM");
    await Prefs.setShiftToTime(
        SharefprefConstants.sharedShiftToTime, "06:30 PM");

    await Prefs.setImageURL(
        (model.message!.userImg!.imgUrl.toString() == "-")
            ? ""
            : SharefprefConstants.sharedImgUrl,
        model.message!.userImg!.imgUrl.toString());

    await Prefs.setMobileNo(
        SharefprefConstants.sharedMobNo, model.message!.phone.toString());

    await Prefs.setWorkRegion(SharefprefConstants.sharedWorkregion,
        model.message!.workregioncountry.toString());

    await Prefs.setLinemanager(
        SharefprefConstants.sharedLineManager,
        model.message!.linemanager.toString() == "null"
            ? "-"
            : model.message!.linemanager.toString());

    await Prefs.setSupervisor(
        SharefprefConstants.sharedsupervisor,
        model.message!.supervisor.toString() == "null"
            ? "-"
            : model.message!.supervisor.toString());

    await Prefs.sethod(
        SharefprefConstants.sharedhod,
        model.message!.hod.toString() == "null"
            ? "-"
            : model.message!.hod.toString());

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const DashbordPage()),
        (Route<dynamic> route) => false);
  }
}
