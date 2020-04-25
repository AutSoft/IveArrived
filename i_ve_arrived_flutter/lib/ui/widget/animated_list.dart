import 'dart:async';

import 'package:animated_stream_list/animated_stream_list.dart';
import 'package:flutter/cupertino.dart';

class AutomaticAnimatedList<E> extends StatefulWidget {
  final Widget Function(E item, int index, BuildContext contex, Animation<double> animation) builder;
  final List<E> list;

  const AutomaticAnimatedList({Key key, this.builder, this.list}) : super(key: key);

  @override
  _AnimatedListState createState() => _AnimatedListState<E>();
}

class _AnimatedListState<E> extends State<AutomaticAnimatedList<E>> {
  StreamController<List<E>> streamController = StreamController<List<E>>();

  @override
  Widget build(BuildContext context) {
    streamController.add(widget.list);
    return AnimatedStreamList<E>(
      initialList: widget.list,
      streamList: streamController.stream,
      itemRemovedBuilder: widget.builder,
      itemBuilder: widget.builder,
    );
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
