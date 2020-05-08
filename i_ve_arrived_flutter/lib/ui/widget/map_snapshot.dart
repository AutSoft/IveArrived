import 'package:flutter/cupertino.dart';

class MapSnapshot extends StatelessWidget {
  final String address;
  final VoidCallback onPressed;

  const MapSnapshot({Key key, this.onPressed, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.network(
        "https://maps.googleapis.com/maps/api/staticmap?"
            "center=${Uri.encodeFull(address)}&"
            "zoom=17&"
            "markers=color:0x53b557|${Uri.encodeFull(address)}&"
            "size=600x600&"
            "style=feature:poi|visibility:off&"
            "maptype=roadmap",
        fit: BoxFit.cover,
      ),
    );
  }
}