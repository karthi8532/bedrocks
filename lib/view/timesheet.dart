import 'dart:convert';
import 'dart:io';

import 'package:bedrockequipments/service/apiservice.dart';
import 'package:bedrockequipments/service/appconstants.dart';
import 'package:bedrockequipments/widgets/app_utils.dart';
import 'package:bedrockequipments/widgets/custom_button.dart';
import 'package:bedrockequipments/widgets/pref.dart';
import 'package:bedrockequipments/widgets/sharedprefconstants.dart';
import 'package:bedrockequipments/widgets/text_fields.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class TimesheetPage extends StatefulWidget {
  const TimesheetPage({super.key});

  @override
  State<TimesheetPage> createState() => _TimesheetPageState();
}

class _TimesheetPageState extends State<TimesheetPage> {
  TextEditingController customnamecontroller = TextEditingController();
  TextEditingController rentalOrderNoController = TextEditingController();
  TextEditingController hourMeterReadingController = TextEditingController();

  TextEditingController startMeterReadingController = TextEditingController();
  TextEditingController endMeterReadingController = TextEditingController();
  TextEditingController totalMeterReadingController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController breakingHoursController = TextEditingController();
  TextEditingController idleHoursController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  bool loading = false;
  int currentStep = 0;
  bool isCompleted = false;
  final int _selection = 0;
  String techpath = "";
  String cuspath = "";
  String vechileId = "";
  String vechileNumber = "";

  final GlobalKey<SfSignaturePadState> _customersignaturePadKey = GlobalKey();
  final GlobalKey<SfSignaturePadState> _techniciansignaturePadKey = GlobalKey();
  List<String> files = [];
  List<Step> stepList() => [
        Step(
          title: const Text('Entry'),
          content: timesheettext(),
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
        ),
        Step(
          title: const Text('Signature'),
          content: signatureWidget(),
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
        ),
        Step(
          title: const Text('Finish'),
          content: finishWidgetdetails(),
          state: currentStep == 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00ffffff),
        //   title: const Text(
        //     'Timesheet',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   iconTheme: const IconThemeData(color: Colors.white),
        //   actions: const [Icon(Icons.save, color: Colors.white)],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppUtils.buildNormalText(
            text: "Time Sheet Entry", color: Colors.black, fontSize: 20),
      ),

      backgroundColor: Colors.white,
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [timesheettext(size)],
      //   ),
      // ),
      body: !loading
          ? Theme(
              data: Theme.of(context).copyWith(
                  colorScheme:
                      const ColorScheme.light(primary: Color(0xFFffc700))),
              child: isCompleted
                  ? successWidget()
                  : Stepper(
                      type: StepperType.horizontal,
                      steps: stepList(),
                      currentStep: currentStep,
                      onStepContinue: () async {
                        final isLastStep = currentStep == stepList().length - 1;
                        if (isLastStep) {
                          List<Path> custompaths = _customersignaturePadKey
                              .currentState!
                              .toPathList();
                          List<Path> techpaths = _techniciansignaturePadKey
                              .currentState!
                              .toPathList();
                          if (custompaths.isEmpty) {
                            AppUtils.showSingleDialogPopup(
                                context,
                                "Please get Customer Signature",
                                "Ok",
                                onexitpopup);
                          } else if (techpaths.isEmpty) {
                            AppUtils.showSingleDialogPopup(
                                context,
                                "Please Sign Your Signature",
                                "Ok",
                                onexitpopup);
                          } else {
                            _savebothImage();
                          }
                        } else {
                          setState(() {
                            currentStep += 1;
                          });
                        }
                      },
                      onStepTapped: (step) =>
                          setState(() => currentStep = step),
                      onStepCancel: currentStep == 0
                          ? null
                          : () => setState(() => currentStep -= 1),
                      controlsBuilder: (context, details) {
                        final isLastStep = currentStep == stepList().length - 1;
                        return Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                      onPressed: details.onStepCancel,
                                      child: const Text('Back'))),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFFffc700)),
                                      onPressed: details.onStepContinue,
                                      child: Text(
                                        isLastStep ? "Confirm" : 'Next',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ))),
                            ],
                          ),
                        );
                      },
                    ),
            )
          : const Center(
              child: CupertinoActivityIndicator(
                  radius: 30.0, color: Color(0xFFffc700)),
            ),
      //persistentFooterButtons: [signInButton(size)],
    );
  }

  Widget timesheettext() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: true,
            ),
            items: const ["1001", "1002", "1003", "1004"],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Color(0xFFffc700), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Color(0xFFffc700), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Color(0xFFffc700), width: 1),
                  ),
                  labelText: "Choose Vechicle No",
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            onChanged: (val) {
              vechileId = val.toString();
              vechileNumber = val.toString();
            },
            selectedItem: "1001",
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Enter Customer Name',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          custom_TextField(
            controller: customnamecontroller,
            text: "",
            backGround: Colors.grey.shade400,
            color: Colors.grey.shade400,
            icon: CupertinoIcons.person_alt_circle,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Rental Order No',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          custom_TextField(
            controller: rentalOrderNoController,
            text: "",
            backGround: Colors.black,
            color: Colors.black,
            icon: Icons.numbers,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Hour/Meter Reading',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: custom_TextField(
                  hintText: "Stat",
                  controller: startMeterReadingController,
                  text: "",
                  backGround: Colors.black,
                  isnumbers: true,
                  color: Colors.black,
                  icon: CupertinoIcons.clock,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 3,
                child: custom_TextField(
                  controller: endMeterReadingController,
                  text: "",
                  isnumbers: true,
                  backGround: Colors.black,
                  color: Colors.black,
                  icon: CupertinoIcons.clock,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 3,
                child: custom_TextField(
                  isreadonly: true,
                  controller: totalMeterReadingController,
                  text: "",
                  backGround: Colors.black,
                  color: Colors.black,
                  icon: CupertinoIcons.clock,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Start Time',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          custom_TextField(
            isnumbers: true,
            controller: startTimeController,
            text: "",
            backGround: Colors.black,
            color: Colors.black,
            icon: CupertinoIcons.alarm_fill,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'End Time',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          custom_TextField(
            isnumbers: true,
            controller: endTimeController,
            text: "",
            backGround: Colors.black,
            color: Colors.black,
            icon: CupertinoIcons.alarm_fill,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Breaking Hours',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          custom_TextField(
            controller: breakingHoursController,
            text: "",
            backGround: Colors.black,
            color: Colors.black,
            icon: CupertinoIcons.settings,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Idle Hours',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          custom_TextField(
            controller: idleHoursController,
            text: "",
            backGround: Colors.black,
            color: Colors.black,
            icon: CupertinoIcons.settings,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget signInButton(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 16,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color(0xFFFFB22C)),
      child: Text(
        'Sign in',
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget signatureWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppUtils.buildNormalText(text: "Customer Signature", fontSize: 16),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 3,
          width: MediaQuery.of(context).size.height / 3,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            dashPattern: const [10, 4],
            strokeCap: StrokeCap.square,
            color: Colors.grey,
            child: SfSignaturePad(
              key: _customersignaturePadKey,
              backgroundColor: Colors.yellow[50],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _customersignaturePadKey.currentState?.clear();
          },
          child: const Text("Clear"),
        ),
        const SizedBox(
          height: 10,
        ),
        AppUtils.buildNormalText(text: "Technician Signature", fontSize: 16),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 3,
          width: MediaQuery.of(context).size.height / 3,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            dashPattern: const [10, 4],
            strokeCap: StrokeCap.square,
            color: Colors.grey,
            child: SfSignaturePad(
              key: _techniciansignaturePadKey,
              backgroundColor: Colors.yellow[50],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _techniciansignaturePadKey.currentState?.clear();
          },
          child: const Text("Clear"),
        ),
      ],
    );
  }

  Widget finishWidgetdetails() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Remarks',
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: remarksController,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Remarks",
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.black26, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget successWidget() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          AppUtils.buildNormalText(
            text: "User Added Successfully!",
            fontSize: 16,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  isCompleted = false;
                  currentStep = 0;
                });
              },
              child: const Text('OK'))
        ],
      ),
    );
  }

  void onexitpopup() {
    Navigator.of(context).pop();
  }

  void _savebothImage() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    var formatteddate = formatter.format(now);

    final cusdata =
        await _customersignaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await cusdata.toByteData(format: ui.ImageByteFormat.png);

    final cusdata1 =
        await _techniciansignaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes1 = await cusdata1.toByteData(format: ui.ImageByteFormat.png);

    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
      String appDocPath = directory!.path;
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    }

    if (directory != null) {
      File file =
          File('${'${directory.path}/customer_signature-$formatteddate'}.png');
      File file1 = File(
          '${'${directory.path}/technician_signature-$formatteddate'}.png');
      await file.writeAsBytes(bytes!.buffer.asUint8List());
      await file1.writeAsBytes(bytes1!.buffer.asUint8List());

      techpath = file.path;
      cuspath = file1.path;
      files.clear();
      files.add(techpath);
      files.add(cuspath);

      uploadfiles();
    } else {
      print('Failed to access external storage directory.');
    }
  }

  Future uploadfiles() async {
    try {
      setState(() {
        loading = true;
      });
      Uri url;
      url = Uri.parse(AppConstants.LIVE_URL + AppConstants.uploadfiles);

      var request = http.MultipartRequest('POST', url);
      for (int i = 0; i < files.length; i++) {
        request.files.add(await http.MultipartFile.fromPath('files', files[i]));
        print(jsonEncode(files[i]));
      }

      http.StreamedResponse response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        setState(() {
          loading = false;
        });
        if (response.statusCode == 200) {
          var imagename2 = "";
          List<dynamic> list = json.decode(value);
          imagename2 = list[0]["filename"];
          var camfilepath = list[0]["path"];
          print(imagename2);

          //submittowipandclose();
        } else {
          print('image not upload');
          print(response.reasonPhrase);
          //  submittowipandclose();
        }
      });
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e.toString());
    }
  }

  void submittowipandclose() {
    //getunassigntickets
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    var formatteddate = formatter.format(now);
    var body = {
      "requestapplicationno":
          "${Prefs.getEmpID("empID")!.toString()} - $formatteddate",
      "vechicleid": vechileId,
      "vechicleNo": vechileNumber,
      "customerCode": customnamecontroller.text.toString(),
      "customerName": customnamecontroller.text.toString(),
      "rentalOrderNo": rentalOrderNoController.text,
      "hoursmeterreadingStart": startMeterReadingController.text,
      "hoursmeterreadingEnd": endMeterReadingController.text,
      "hoursmeterreadingTotal": totalMeterReadingController.text,
      "startTime": startTimeController.text,
      "endTime": endTimeController.text,
      "breakingHours": breakingHoursController.text,
      "idleHours": idleHoursController.text,
      "customersign": cuspath,
      "techsign": techpath,
      "remarks": remarksController.text,
      "createdby": Prefs.getEmpID(SharefprefConstants.sharedempId),
      "createdbyName": Prefs.getFullName(
        SharefprefConstants.shareFullName,
      ),
      "createdDate": formatteddate
    };
    setState(() {
      loading = true;
    });
    Apiservice.addtimesheet(body).then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'], "Ok", onrefreshscreen);
        } else {
          AppUtils.showSingleDialogPopup(
              context, jsonDecode(response.body)['message'], "Ok", onexitpopup);
        }
      } else {
        throw Exception(
            jsonDecode(response.body)['message'][0]['sqlMessage'].toString());
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", onexitpopup);
    });
  }

  void onrefreshscreen() {
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
