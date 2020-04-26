import 'package:flutter/material.dart';

Color parseColor(String value){
  if (value[0] == "#"){
    value = value.substring(1);
  }
  var r = int.parse(value.substring(0, 2), radix: 16);
  var g = int.parse(value.substring(2, 4), radix: 16);
  var b = int.parse(value.substring(4), radix: 16);
  return Color.fromRGBO(r, g, b, 1);
}