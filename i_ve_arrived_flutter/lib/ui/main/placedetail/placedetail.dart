import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceDetailPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My store"),),
      body: Center(
        child: Text("Hello store!"),
      ),
    );
  }
}