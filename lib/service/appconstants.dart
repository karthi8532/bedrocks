import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppConstants {
  //static const String LIVE_URL = 'http://192.168.0.102:3002/';
  static const String LIVE_URL = 'https://mobapp.nijatech.com:3000/';
  static const String NETSUITE_LIVE_URL =
      'https://2772245.restlets.api.netsuite.com/app/site/hosting/restlet.nl?';

  //https://mobapp.nijatech.com/

  static String TOTALTIMESHEETHOURSPERDAY = "10";
  static const String SESSIONTOKEN = 'Token';
  static const String SESSIONLOGGEDIN = "LoggedIn";

  static const String uploadfiles = 'upload';
  static const String moblogindetails = 'employee/login';

  static const String mobgenerateotp = 'employee/generateotp';
  static const String mobvalidateotp = 'employee/validateotp';

  //LETTER REQUEST
  static const String applyletterrequest = 'employee/applyletterrequest';
  static const String viewletterrequest = 'employee/viewletterdetails';

  //APPLY ASSET
  static const String applyassetrequest = 'employee/applyassetrequest';
  static const String viewassetrequest = 'employee/viewassetdetails';

  //REIMBURSEMENT
  static const String applyreimrequestrequest = 'employee/applyreimrequest';
  static const String viewreimdetails = 'employee/viewreimdetails';

  //DUTY TRAVEL

  static const String applydutytravelrequest =
      'employee/applydutytravelrequest';
  static const String viewdutytraveldetails = 'employee/viewdutytraveldetails';

  //LEAVE
  static const String applyleave = 'employee/applyleave';
  static const String viewleave = 'employee/viewleave';
  static const String leavetype = 'employee/viewleavetype';
  static const String getdata = 'employee/getdetails';
  static const String cancelleave = 'employee/cancelleave';
  static const String cancelpullbackleave = 'employee/cancelpullbackleave';

  //ENCASH LEAVE

  static const String applyencashleave = 'employee/applyencashleave';
  static const String viewencashleave = 'employee/viewencashleave';

  //PROFILE
  static const String updatemaster = 'employee/updatemasters';
  static const String viewallemployee = 'employee/viewallemployee';
  static const String updateprofile = 'employee/addmastersmobile';

  //ATTENDANCE
  static const String postdailyattendance = 'employee/addDailyAttendance';
  static const String updatedailyattendance = 'employee/UpdateDailyAttendance';
  static const String checkattendance = 'employee/getdailyAttendanceId';
  static const String getdailyAttendancetimelog =
      'employee/getdailyAttendancetimelog';
  static const String getallattendanceHistory =
      "employee/getallattendanceHistory";

  //REGULARIZATION
  static const String applyreqularization = 'employee/applyreqularization';

  // TIME SHEET
  //static const String applytimesheet = 'employee/applytimesheet';
  static const String applytimesheet = 'employee/addupdatetimesheet';
  static const String viewtimesheet = 'employee/viewtimesheet';
  static const String viewtimesheetnew = 'employee/viewtimesheetnew';
  static const String deletetimesheet = 'employee/deletetimesheet';

  static const String viewjobtypemaster = 'employee/viewjobtypemaster';
  static const String viewjobcodenamemaster = 'employee/viewjobcodenamemaster';

  //ONDUTY RESUMPTION

  static const String onpostdutyresumotion = 'employee/applydutyresumption';

  //UPDATE PASSWORD
  static const String onupdatepassword = 'employee/updatepassword';

  //MASTER

  static const String viewrelationmaster = 'employee/viewrelationmaster';
  static const String getitemmaster = 'employee/getitemmaster';

  //Material
  static const String onpostmaterialrequest = 'employee/applymaterialrequest';
  static const String viewmaterialrequest = 'employee/viewmaterialrequest';
  static const String getallencash = 'employee/getencashmaster';
  static const String viewbioattendance = 'employee/checkbioattendance';
  static const String addbioattendance = 'employee/addbioattendance';
  static const String updatebioattendance = 'employee/updatebioattendance';

  static const String viewbioattendancehistory =
      'employee/viewbioattendancehistory';

  static const String viewbioattendancehistorylog = 'mobile/viewbioattendance';

  static const String addtimesheet = '/mobile/customaddtimesheet';

  static const int holidayscriptid = 244;
  static const int holidaydeployid = 1;

  static const int leavescriptid = 245;
  static const int leavedeployid = 1;

  static const int letterscriptid = 247;
  static const int lettereployid = 1;

  static const int assettypescriptid = 228;
  static const int assettypedeployid = 1;

  static const int assetnamescriptid = 226;
  static const int assetnamedeployid = 1;

  static const int timsheetapproversciptid = 253;
  static const int timsheetapproverdeployid = 1;

  static const int traveltypesciptid = 257;
  static const int traveltypedeployid = 1;

  static const int travelmodesciptid = 250;
  static const int travelmodedeployid = 1;

  static const int claimtypescriptid = 229;
  static const int claimtypedeployid = 1;

  static const int empskillscriptid = 233;
  static const int empskilldeployid = 1;

  static const int empdocumentscriptid = 237;
  static const int empdocumentdeployid = 1;

  static const int empeducationscriptid = 232;
  static const int empeducationdeployid = 1;

  static const int emprelationscriptid = 230;
  static const int emprelationdeployid = 1;

  static const int empsalaryscriptid = 251;
  static const int empsalarydeployid = 1;

  static List<Color> colorArray = [
    const Color(0xFF1ea4a9),
    const Color(0xFF5697db),
    const Color(0xFFeb3f55),
    const Color(0xFFF39F5A),
    const Color(0xFF5B0888),
    const Color(0xFF618264),
    const Color(0xFF80B300),
    const Color(0xFF00B3E6),
    const Color(0xFF1ea4a9),
    const Color(0xFF5697db),
  ];

  static List<Color> containercolorArray = const [
    Color(0xFFF875AA),
    Color(0xFF00B3E6),
    Color(0xFFB931FC),
    Color(0xFF5697db),
    Color(0xFFeb3f55),
    Color(0xFF5B0888),
    Color(0xFF5697db),
    Color(0xFFF4CE14),
    Color(0xFFD83F31),
  ];

  static List<Color> lightcolorArray = [
    const Color(0xFF1ea4a9),
    const Color(0xFF5697db),
    const Color(0xFFeb3f55),
    const Color(0xFFF39F5A),
    const Color(0xFF8e18cd),
    const Color(0xFF618264),
  ];

  static List<Color> darkcolorArray = const [
    Color(0xFF1963b3),
    Color(0xff093e77),
    Color(0xFF841020),
    Color(0xFFcd6a18),
    Color(0xFF5B0888),
    Color(0xff0f7017)
  ];

  static convertdateformat(from) {
    if (from.toString().isNotEmpty) {
      String concatefrom = '$from 00:00:00';

      DateTime dt1 = DateTime.parse(concatefrom);

      var convertiondate = DateFormat.yMMMEd().format(dt1);
      return convertiondate.toString();
    } else {
      return;
    }
  }

  static convertdateformat1(from) {
    if (from.toString().isNotEmpty) {
      String concatefrom = '$from';

      DateTime dt1 = DateTime.parse(concatefrom);

      var convertiondate = DateFormat.yMMMMEEEEd().format(dt1);
      return convertiondate.toString();
    } else {
      return;
    }
  }

  static changeddmmyyformat(datetime) {
    return DateFormat("dd-MM-yyyy").format(DateTime.parse(datetime));
  }

  static changeyymmddhoursformat(datetime) {
    //     String concatefrom = '$datetime 00:00:00';
    //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // final String formatted = formatter.format(concatefrom);
    //return DateFormat("yyyy-MM-dd").format(DateTime.parse(datetime));

    var inputFormat = DateFormat('dd/MM/yyyy');
    var date1 = inputFormat.parse(datetime);

    var outputFormat = DateFormat('yyyy-MM-dd');
    var date2 = outputFormat.format(date1);
    return date2;
  }

  // netsuite

  static launchUrl(url, {bool isNewTab = true}) async {
    if (Platform.isAndroid) {
      if (!await launchUrl(
        url,
      )) {
        throw Exception('Could not launch $url');
      }
    } else if (Platform.isIOS) {
      if (!await launchUrl(
        url,
      )) {
        throw Exception('Could not launch $url');
      }
    }
  }
}
