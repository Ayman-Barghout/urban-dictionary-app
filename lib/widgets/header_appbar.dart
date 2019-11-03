import 'package:flutter/material.dart';

import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HeaderAppBar(
      {Key key,
      this.term,
      this.bookmarkIcon,
      this.onBookmarkPress,
      this.onBackbuttonPress,
      this.child})
      : super(key: key);

  final IconData bookmarkIcon;
  final Function onBackbuttonPress;
  final Function onBookmarkPress;
  final String term;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [customStyles.primaryColorLight, customStyles.primaryColor],
            stops: [0.0001, 1.0]),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: onBackbuttonPress,
                icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 35),
              ),
              IconButton(
                onPressed: onBookmarkPress,
                icon: Icon(bookmarkIcon, color: Colors.white, size: 35),
              ),
            ],
          ),
          Text(
            term,
            textAlign: TextAlign.center,
            style: customStyles.termHeaderTextStyle,
          ),
          Container(
            margin: EdgeInsets.only(top: 15.0),
            width: 250.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(25.0), right: Radius.circular(25.0)),
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150.0);
}