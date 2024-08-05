import 'dart:convert';
import 'dart:io';
import 'package:bedrockequipments/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:bedrockequipments/service/appconstants.dart';
import 'package:bedrockequipments/widgets/app_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final GlobalKey<SfSignaturePadState> _customersignaturePadKey = GlobalKey();
  final GlobalKey<SfSignaturePadState> _techniciansignaturePadKey = GlobalKey();
  List<String> files = [];
  bool loading = false;
  String techpath = "";
  String cuspath = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [signatureWidget()],
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
        CustomButton(
            onPressed: () {
              _savebothImage();
            },
            name: "Submit",
            circularvalue: 30)
      ],
    );
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
      files.clear();
      techpath = file.path;
      cuspath = file1.path;

      files.add(file.path);
      //files.add(file1.path);

      postData();
    } else {
      print('Failed to access external storage directory.');
    }
  }

  Future postData() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://mobapp.nijatech.com:3000/upload/"));
    //request.fields.addAll({'docType': 'Passport', 'docCountry': 'Italy'});
    for (int i = 0; i < files.length; i++) {
      request.files.add(await http.MultipartFile.fromPath('files', files[i]));
      print(files[i]);
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 201) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }

  Future uploadfiles() async {
    setState(() {
      loading = true;
    });
    Uri url;
    url = Uri.parse(AppConstants.LIVE_URL + AppConstants.uploadfiles);

    var request = http.MultipartRequest('POST', url);
    for (int i = 0; i < files.length; i++) {
      request.files.add(await http.MultipartFile.fromPath('files', files[i]));
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
        print(camfilepath);
        //response.stream.
      } else {
        print(response.reasonPhrase);
      }
    });
    setState(() {
      loading = false;
    });
  }
}
