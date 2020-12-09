import 'package:flutter/material.dart';
import 'package:mobile/Utils/Constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize = Size.fromHeight(50.0);
  final BuildContext context;
  final String title;
  final bool isBack;

  CustomAppBar(this.context, this.title, this.isBack);

  Widget _backButton() {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Icon(
            Icons.keyboard_arrow_left,
            color: Constants.title,
            size: 40,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Widget back;
    if (isBack) {
      back = _backButton();
    } else {
      back = null;
    }
    return AppBar(
      centerTitle: true,
      leading: back,
      title: Text(
        title,
        style: TextStyle(color: Constants.title),
      ),
      backgroundColor: Constants.appBarBackground,
      automaticallyImplyLeading: true,
    );
  }
}
