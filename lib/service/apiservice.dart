import 'dart:convert';
import 'package:bedrockequipments/service/appconstants.dart';
import 'package:bedrockequipments/widgets/pref.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

import 'package:intl/intl.dart';

class Apiservice {
  static String mobilecurrentdate =
      DateFormat("yyyy-MM-dd").format(DateTime.now()); //2023-07-15";
  // static String mobilecurrentdatetime =
  //     DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()); //2023-07-15";

  static const int timeOutDuration = 35;

  static String sessiontoken = Prefs.getToken("Token").toString();
  static String empid = Prefs.getEmpID("empID")!.toString();

  static Future<http.Response> getlogin(String usename, String password) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.moblogindetails);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {"username": usename, "userpassword": password};
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> getemployeedetailsdata() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.getdata);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };

    var body = {"mobileusername": Prefs.getUserName("username").toString()};
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future uploadfiles(String filepath) async {
    var imagename1 = "";
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.uploadfiles);
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('files', filepath));

    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(value);
        imagename1 = list[0]["filename"];
      }
    });
    return imagename1;
  }

  static Future<http.Response> getleavestypesdata() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.leavetype);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "nsid": Prefs.getNsID('nsid'),
    };

    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> cancelleave(reason, uniqid) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.cancelleave);

    Map<String, String> headers = {"Content-Type": "application/json"};
    String mobilecurrentdatetime1 =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    var body = {
      "uniqid": uniqid,
      "iscancelledreason": reason,
      "iscancelleddate": mobilecurrentdatetime1
    };

    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> pullbackleave(reason, uniqid) async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.cancelpullbackleave);

    Map<String, String> headers = {"Content-Type": "application/json"};
    String mobilecurrentdatetime1 =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    var body = {
      "uniqid": uniqid,
      "ispullbackcancelledreason": reason,
      "ispullbackcancelleddate": mobilecurrentdatetime1
    };

    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  //ALL EMPLOYEE
  static Future<http.Response> getallemployee() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.viewallemployee);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "nsid": Prefs.getNsID('nsid'),
    };

    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> refreshtoken() async {
    var url =
        Uri.parse('${AppConstants.NETSUITE_LIVE_URL}script=3343&deploy=1');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };

    var response = await http
        .post(url, headers: headers)
        .timeout(const Duration(seconds: timeOutDuration));
    if (response.statusCode == 200) {
      Prefs.setTokenNetsuite(
          "accesstoken", jsonDecode(response.body)['access_token'].toString());
    }
    return response;
  }

  static Future<http.Response> sendotp(
      String mobileno, String countrycode, String countryName, int otp) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.mobgenerateotp);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "docdate": mobilecurrentdate.toString(),
      "countryCode": countrycode,
      "countryName": countryName,
      "mobileno": mobileno,
      "emailid": "",
      "otp": otp,
      "type": "",
      "createdby": mobileno,
      "mobcreatedDate": mobilecurrentdate
    };

    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> verifyotp(String mobileno, int otp) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.mobvalidateotp);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "mobileno": mobileno,
      "otp": otp,
    };

    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> postleave(dynamic json) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.applyleave);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    print(jsonEncode(json));
    return response;
  }

  static Future<http.Response> postletterrequest(dynamic json) async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.applyletterrequest);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> viewpostletterrequest() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.viewletterrequest);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var body = {
      "nsid": Prefs.getNsID('nsid'),
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }
  //  END OF LETTER REQUEST //

  //START ASSET REQUEST

  static Future<http.Response> postassetrequest(dynamic json) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.applyassetrequest);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> viewpostassetrequest() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.viewassetrequest);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var body = {
      "nsid": Prefs.getNsID('nsid'),
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  ///END ASSET REQUEST

//START DUTY TRAVEL
  static Future<http.Response> postdutytravelrequest(dynamic json) async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.applydutytravelrequest);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> viewtravelduty() async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.viewdutytraveldetails);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var body = {
      "nsid": Prefs.getNsID('nsid'),
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  ///END DUTY TRAVEL

  // START REIM

  static Future<http.Response> postreimbursementrequest(dynamic json) async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.applyreimrequestrequest);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> viewreimbursementrequest() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.viewreimdetails);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var body = {
      "nsid": Prefs.getNsID('nsid'),
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

//END REIM

  static Future<http.Response> refreshmobiletoken() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.moblogindetails);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };

    var response = await http
        .post(url, headers: headers)
        .timeout(const Duration(seconds: timeOutDuration));
    if (response.statusCode == 200) {
      Prefs.setToken("token", jsonDecode(response.body)['token'].toString());
    }
    return response;
  }

  static Future<http.Response> viewleave() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.viewleave);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var body = {
      "nsid": Prefs.getNsID('nsid'),
    };
    print(body);
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> updatemaster(dynamic json) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.updatemaster);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> updateprofiles(dynamic json) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.updateprofile);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http
        .post(url, body: jsonEncode(json), headers: headers)
        .timeout(const Duration(seconds: timeOutDuration));
    return response;
  }

  static Future<http.Response> postAttendance(dynamic json) async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.postdailyattendance);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http
        .post(url, body: jsonEncode(json), headers: headers)
        .timeout(const Duration(seconds: timeOutDuration));
    return response;
  }

  static Future<http.Response> postBioAttendance(dynamic json) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.addbioattendance);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http
        .post(url, body: jsonEncode(json), headers: headers)
        .timeout(const Duration(seconds: timeOutDuration));
    return response;
  }

  static Future<http.Response> updateAttendance(dynamic json) async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.updatebioattendance);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> viewcurrentdate() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.checkattendance);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "nsId": Prefs.getNsID('nsid'),
      "fromdate": Apiservice.mobilecurrentdate,
      "todate": Apiservice.mobilecurrentdate
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> viewattendancetimelog(String type) async {
    DateTime today = DateTime.now();
    String cdate = DateFormat("yyyy-MM-dd").format(today);

    // DateTime yesterday = today.subtract(const Duration(days: 60));
    // String ydate = DateFormat("yyyy-MM-dd").format(yesterday);

    var url = Uri.parse(
        AppConstants.LIVE_URL + AppConstants.getdailyAttendancetimelog);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "nsId": Prefs.getNsID('nsid'),
      "fromdate": cdate,
      "todate": cdate
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> viewattendancehistorylog() async {
    DateTime today = DateTime.now();
    String cdate = DateFormat("yyyy-MM-dd").format(today);

    DateTime yesterday = today.subtract(const Duration(days: 60));
    String ydate = DateFormat("yyyy-MM-dd").format(yesterday);

    var url = Uri.parse(
        AppConstants.LIVE_URL + AppConstants.viewbioattendancehistorylog);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "nsId": Prefs.getNsID('nsid'),
      // "fromdate": ydate,
      // "todate": cdate
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> postreqularization(dynamic json) async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.applyreqularization);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  //TIME SHEET

  static Future<http.Response> posttimesheet(dynamic json) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.applytimesheet);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    log(jsonEncode(json));
    return response;
  }

  static Future<http.Response> deletetimesheet(
      String headerid, String timesheetid) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.deletetimesheet);
    var body = {"headerid": headerid, "timesheetid": timesheetid};
    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> viewtimesheet(String choosedate) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.viewtimesheetnew);
    var body = {"nsId": Prefs.getNsID('nsid'), "choosendate": choosedate};
    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> viewjobtype() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.viewjobtypemaster);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response = await http.get(url, headers: headers).timeout(
          const Duration(seconds: timeOutDuration),
        );

    return response;
  }

  static Future<http.Response> viewjobcodename() async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.viewjobcodenamemaster);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response = await http.get(url, headers: headers).timeout(
          const Duration(seconds: timeOutDuration),
        );

    return response;
  }

  static Future<http.Response> viewrelationmasters() async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.viewrelationmaster);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response = await http.get(url, headers: headers).timeout(
          const Duration(seconds: timeOutDuration),
        );

    return response;
  }

  static Future<http.Response> onpostdutyresumption(dynamic json) async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.onpostdutyresumotion);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> updatepassword(dynamic json) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.onupdatepassword);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> getitemmasters() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.getitemmaster);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response = await http.get(url, headers: headers).timeout(
          const Duration(seconds: timeOutDuration),
        );
    return response;
  }

  static Future<http.Response> applymaterialrequest(dynamic json) async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.onpostmaterialrequest);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> viewmaterialreq() async {
    var url =
        Uri.parse(AppConstants.LIVE_URL + AppConstants.viewmaterialrequest);
    var body = {"nsId": Prefs.getNsID('nsid')};
    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> getencash() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.getallencash);
    var body = {"nsId": Prefs.getNsID('nsid')};
    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> postencashleave(dynamic json) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.applyencashleave);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    print(jsonEncode(json));
    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> viewencashleave() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.viewencashleave);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var body = {"nsId": Prefs.getNsID('nsid')};
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> viewbioattendance() async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.viewbioattendance);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    var body = {
      "nsId": Prefs.getNsID('nsid'),
      "currentdate": mobilecurrentdate
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    print(jsonEncode(body));
    return response;
  }

  static Future<http.Response> viewattendancebiohistory() async {
    DateTime today = DateTime.now();
    String cdate = DateFormat("yyyy-MM-dd").format(today);

    var url = Uri.parse(
        AppConstants.LIVE_URL + AppConstants.viewbioattendancehistory);

    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "nsId": Prefs.getNsID('nsid'),
      "docdate": cdate,
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> addtimesheet(dynamic json) async {
    var url = Uri.parse(AppConstants.LIVE_URL + AppConstants.addtimesheet);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      //'Authorization': 'Bearer ${Prefs.getToken('token')}'
    };
    print(jsonEncode(json));
    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }
}
