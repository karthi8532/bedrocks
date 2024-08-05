import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static void hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String capitalize(String value) =>
      value.trim().length > 1 ? value.toUpperCase() : value;

  static void showSnackbar({context, message, backgroundColor}) {
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: message,
          backgroundColor: backgroundColor ?? Colors.red,
        ),
      );
    }
    Timer(const Duration(seconds: 4), () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });
  }

  // show dialog popup
  static Future showSingleDialogPopup(context, title, buttonname, onPressed) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title.toString(), maxLines: null),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    onPressed();
                  },
                  child: Text(buttonname.toString())),
            ],
          );
        });
  }

  // show confirmation dialog
  static Future showconfirmDialog(
      context, title, yesstring, nostring, onPressedYes, onPressedNo) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppUtils.buildNormalText(text: title, fontSize: 14),
          actions: <Widget>[
            TextButton(
                onPressed: onPressedYes,
                child: AppUtils.buildNormalText(text: yesstring)),
            TextButton(
                onPressed: onPressedNo,
                child: AppUtils.buildNormalText(text: nostring)),
          ],
        );
      },
    );
  }

  //Text
  static Widget buildHeaderText({final String? text}) {
    return Text(
      text.toString(),
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  static Widget buildNormalText(
      {@required text,
      color,
      double fontSize = 12,
      textAlign,
      fontWeight,
      letterSpacing,
      wordSpacing,
      fontFamily,
      maxLines,
      overflow,
      decoration,
      lineSpacing,
      fontStyle}) {
    return Text(
      text ?? '--',
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          decoration: decoration ?? TextDecoration.none,
          color: color ?? Colors.black,
          fontSize: fontSize ?? 12,
          fontWeight: fontWeight ?? FontWeight.w400,
          letterSpacing: letterSpacing ?? 0,
          wordSpacing: wordSpacing ?? 0.0,
          height: lineSpacing != null ? lineSpacing + 0.0 : null,
          fontStyle: fontStyle ?? FontStyle.normal),
    );
  }

  static iconWithText(
      {@required icons,
      @required text,
      MaterialColor? iconcolor,
      color,
      double fontSize = 12,
      textAlign,
      fontWeight,
      letterSpacing,
      wordSpacing,
      fontFamily,
      maxLines,
      overflow,
      decoration,
      lineSpacing,
      fontStyle}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icons,
          color: iconcolor ?? Colors.black,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text ?? '--',
          textAlign: textAlign ?? TextAlign.left,
          maxLines: maxLines,
          overflow: overflow,
          style: TextStyle(
              decoration: decoration ?? TextDecoration.none,
              color: color ?? Colors.black,
              fontSize: fontSize ?? 12,
              fontWeight: fontWeight ?? FontWeight.w400,
              letterSpacing: letterSpacing ?? 0,
              wordSpacing: wordSpacing ?? 0.0,
              height: lineSpacing != null ? lineSpacing + 0.0 : null,
              fontStyle: fontStyle ?? FontStyle.normal),
        )
      ],
    );
  }

  static void showBottomCupertinoDialog(BuildContext context,
      {@required String? title,
      @required btn1function,
      @required btn2function}) async {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
          title: Text(title.toString()),
          actions: [
            CupertinoActionSheetAction(
                onPressed: btn1function, child: const Text('Camera')),
            CupertinoActionSheetAction(
                onPressed: btn2function, child: const Text('Files'))
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          )),
    );
  }

  static pop(context) {
    Navigator.pop(context);
  }

  static Widget gethanger(BuildContext context) {
    return Center(
        child: Container(
      height: 5,
      width: MediaQuery.of(context).size.width / 6,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(100)),
    ));
  }
}
