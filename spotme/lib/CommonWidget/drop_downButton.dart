import 'package:flutter/material.dart';
import 'package:spotme/utils/LocalImages.dart';
import 'package:spotme/utils/TextStyle.dart';

/// Flutter code sample for [DropdownButton].


class DropdownButtonCustom extends StatefulWidget {
  void Function(String) callBack;
  String hint;
  List<String> list;
  DropdownButtonCustom({super.key,required this.callBack,required this.hint,required this.list});

  @override
  _DropdownButtonCustomState createState() => _DropdownButtonCustomState();
}

class _DropdownButtonCustomState extends State<DropdownButtonCustom> {
  String? dropdownValue = null;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Image.asset(LocalImages.dropDown),
      elevation: 16,
      underline: Divider(height: 0,thickness: 0,color: Colors.transparent,),
      style: AppTextStyle.drop_down,
      hint: Text(widget.hint,style: AppTextStyle.drop_down,),
        iconSize:24,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        // Call the callback function with the selected option
        widget.callBack( value ?? "");

      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
