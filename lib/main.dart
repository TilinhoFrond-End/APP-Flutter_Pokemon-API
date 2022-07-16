import 'package:flutter/material.dart';
import 'package:projeto_poke/view/app_widgets.dart';

void main() async{
  await initialization(null);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {

  await Future.delayed(Duration(seconds: 3));
}


