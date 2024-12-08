 import 'package:flutter/material.dart';

void showSnackBarItem(String message,context,bool forSuccessOrFailure){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
     backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
     ));
  }