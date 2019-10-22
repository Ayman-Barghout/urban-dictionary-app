import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/term_provider.dart';
import 'package:urban_dict_slang/widgets/rounded_search_field.dart';
import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class SearchView extends StatelessWidget {
  const SearchView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TermProvider termProvider = Provider.of<TermProvider>(context);
    return Container(
        child: Column(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              color: Colors.blue,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Urban Dictionary',
                        style: customStyles.termHeaderTextStyle),
                    SizedBox(
                      height: 40.0,
                    ),
                    RoundedSearchField(
                      onSearch: (value) {
                        termProvider.updateTerm(value);
                        Navigator.of(context).pushNamed('/result');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    ));
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
