import 'package:flutter/material.dart';

class RadioTile extends StatefulWidget {
  final String text;
  final String title;

  const RadioTile({super.key, required this.text, required this.title});

  @override
  State<RadioTile> createState() => _RadioTileState();
}

class _RadioTileState extends State<RadioTile> {
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Color(0xffEFEF93),
        borderRadius: BorderRadius.circular(36),
        // border: Border.all(width: 1.0, color: Colors.grey)
      ),
      child: RadioListTile(
          visualDensity: const VisualDensity(horizontal: -2.0, vertical: -2.0),
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(widget.title),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Colors.red,
                width: 1.0,
                strokeAlign: 1.0,
              )),
          value: widget.text,
          // toggleable: true,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          }),
    );
  }
}