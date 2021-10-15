import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({Key? key, required this.itemName, required this.margin})
      : super(key: key);

  final String itemName;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: this.margin),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Text(this.itemName,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
