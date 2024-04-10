import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataWidget extends StatefulWidget {
  const NoDataWidget({super.key});

  @override
  State<NoDataWidget> createState() => _NoDataWidgetState();
}

class _NoDataWidgetState extends State<NoDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(widthFactor: 2,heightFactor: 2,
            alignment: Alignment.center,
            child: Icon(Icons.crisis_alert_rounded,size: 50,color: Colors.red,),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'No Found Data',
              style:
              GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
