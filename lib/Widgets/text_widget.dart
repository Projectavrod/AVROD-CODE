

// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, camel_case_types


import 'package:flutter/material.dart';

class Text_Widget extends StatelessWidget {
  String? text;
  FontWeight? fontWeight;
  Color? color;
  double? fontSize;
  double? height;
  int? maxLine;
  bool? overFlow;
  bool? isItalic;
  bool? isLocal;
  TextDecoration? textDecoration;

  TextAlign? textAlign;
  FontStyle? fstyle;

  bool? static;

  Text_Widget(
     this.text,
      { this.color,
         this.fontWeight,
         this.fontSize,
        this.overFlow,
        this.maxLine,
        this.isLocal,
        this.height,
        this.textDecoration,
        this.textAlign,
        this.isItalic,
        this.static,
        this.fstyle});


  @override
  Widget build(BuildContext context) {

            return
              Text(
                textAlign: textAlign,
                 ((text == 'null' || text==null) ? '' : text!),
                maxLines: maxLine ,
                overflow: (overFlow == true) ? TextOverflow.ellipsis : null,
                style:
                TextStyle(
                  fontStyle: (isItalic == true) ? FontStyle.italic : null,
                  // textStyle: TextStyle(fontStyle: fstyle),
                  height: height,
                  decoration: textDecoration,
                  fontWeight: fontWeight,

                  ///Semibold.. ///Medium....///Large....
                  color: color,
                  fontSize: fontSize,
                )
              );


  }
}
