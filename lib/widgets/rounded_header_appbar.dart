import 'package:flutter/material.dart';

import 'package:urban_dict_slang/utils/styles.dart' as customStyles;
import 'package:urban_dict_slang/widgets/rounded_search_field.dart';

class RoundedHeaderAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const RoundedHeaderAppBar(
      {Key key,
      this.term,
      this.bookmarkIcon,
      this.onSearch,
      this.onBookmarkPress,
      this.onBackbuttonPress})
      : super(key: key);

  final IconData bookmarkIcon;
  final Function onSearch;
  final Function onBackbuttonPress;
  final Function onBookmarkPress;
  final String term;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: double.infinity,
      decoration: ShapeDecoration(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(150.0, 20.0),
            bottomRight: Radius.elliptical(150.0, 20.0),
          ),
        ),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[300], Colors.blue[500]],
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
            child: RoundedSearchField(onSearch: onSearch),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150.0);
}
