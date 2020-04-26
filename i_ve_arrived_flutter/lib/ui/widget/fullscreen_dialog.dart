import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullscreenDialog extends StatelessWidget {
  final Widget Function(BuildContext) builder;

  const FullscreenDialog({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 74),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(43),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: builder(context),
          ),
        ),
      ),
    );
  }
}
