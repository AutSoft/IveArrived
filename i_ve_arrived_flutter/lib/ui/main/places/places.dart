import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_ve_arrived/main.dart';
import 'package:i_ve_arrived/ui/main/placedetail/placedetail.dart';
import 'package:mobx/mobx.dart';

part 'places.g.dart';

class PlacesStore = _PlacesStore with _$PlacesStore;

abstract class _PlacesStore with Store {}

class PlacesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stores"),),
      body: GridView.count(

        crossAxisCount: 2,
        children: <Widget>[
          PlaceWidget(),
          PlaceWidget(),
          PlaceWidget(),
        ],
      ),
    );
  }
}

class PlaceWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        child: Center(
          child: Text("Cég"),
        ),
        onPressed: (){
          Navigator.of(context).push(route(() => PlaceDetailPage()));
        },
      ),
    );
  }
}
