import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class DoneButton extends StatefulWidget {
  const DoneButton({Key? key}) : super(key: key);

  @override
  State<DoneButton> createState() => _DoneButtonState();
}

class _DoneButtonState extends State<DoneButton> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){

    }, child: Container(
      width: MediaQuery.of(context).size.width,
        color: CustomTheme.darkGrey,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: Text("Done".toUpperCase(), style: TextStyle(fontSize: 30),))));
  }
}
