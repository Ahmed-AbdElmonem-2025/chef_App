import 'package:flutter/material.dart';

navigateTopush({required context,required wiget}) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return wiget;
    },
  ));
}
