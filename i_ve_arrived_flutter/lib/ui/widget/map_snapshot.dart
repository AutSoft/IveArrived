import 'package:flutter/cupertino.dart';

class MapSnapshot extends StatelessWidget {
  final double lat;
  final double lng;
  final VoidCallback onPressed;

  const MapSnapshot({Key key, this.lat, this.lng, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.network(
        "https://maps.googleapis.com/maps/api/staticmap?"
            "center=${lat},${lng}&"
            "zoom=17&"
            "markers=color:red|${lat},${lng}&"
            "size=600x600&"
            "key=AIzaSyDrGXhVduV5TA3pr3WYjU8b8HAsTf5GZqQ",
        fit: BoxFit.cover,
      ),
    );
  }
}