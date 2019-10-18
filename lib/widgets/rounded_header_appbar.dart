import 'package:flutter/material.dart';

class RoundedBottomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const RoundedBottomAppBar(
      {Key key,
      this.term,
      this.bookmarkIcon,
      this.searchBox,
      this.onSearch,
      this.onBookmarkPress,
      this.onBackbuttonPress})
      : super(key: key);

  final IconData bookmarkIcon;
  final Function onSearch;
  final Function onBackbuttonPress;
  final Function onBookmarkPress;
  final String term;
  final Widget searchBox;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox.fromSize(
          size: preferredSize,
          child: LayoutBuilder(
            builder: (context, constraint) {
              final width = constraint.maxWidth * 8;
              return ClipRect(
                child: OverflowBox(
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  child: SizedBox(
                      width: width,
                      height: width,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: (width / 2 - preferredSize.height / 2),
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54, blurRadius: 10.0),
                              ]),
                        ),
                      )),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 20.0,
          right: 20.0,
          child: IconButton(
            onPressed: onBookmarkPress,
            icon: Icon(bookmarkIcon),
          ),
        ),
        Positioned(
          top: 20.0,
          left: 20.0,
          child: IconButton(
            onPressed: onBackbuttonPress,
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        Positioned(
          bottom: 30.0,
          right: 100.0,
          child: Text(term),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(200.0);
}
