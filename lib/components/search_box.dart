import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constantes.dart';

class SearchBox extends StatefulWidget {
  SearchBox({
    Key key,
    this.onSubmitted,
    this.text,
  }) : super(key: key);

  final ValueChanged<String> onSubmitted;
  final TextEditingController text;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  void textController() {
    if (widget.text != null) {
      widget.text.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 5, // 5 top and bottom
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        textInputAction: TextInputAction.previous,
        controller: widget.text,
        onSubmitted: widget.onSubmitted,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: SvgPicture.asset("assets/icons/search.svg"),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
