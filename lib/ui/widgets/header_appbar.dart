import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/viewmodels/widgets/favorite_button_model.dart';

import 'package:urban_dict_slang/ui/shared/text_styles.dart' as textStyles;
import 'package:urban_dict_slang/ui/shared/app_colors.dart' as appColors;
import 'package:urban_dict_slang/ui/views/base_widget.dart';

class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HeaderAppBar({Key key, this.term, this.onInfoButtonPress, this.child})
      : super(key: key);

  final Function onInfoButtonPress;
  final String term;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Term term = Provider.of<Term>(context);
    return Container(
      height: 210.0,
      padding: EdgeInsets.only(bottom: 15.0),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [appColors.primaryColorLight, appColors.primaryColor],
            stops: [0.0001, 1.0]),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: onInfoButtonPress,
                icon: Icon(Icons.info_outline, color: Colors.white, size: 35),
              ),
              BaseWidget<FavoriteButtonModel>(
                  model:
                      FavoriteButtonModel(termRepository: Provider.of(context)),
                  builder: (context, model, child) {
                    if (term == null)
                      return IconButton(
                        icon: Icon(Icons.star_border,
                            color: Colors.white, size: 35),
                        onPressed: () {},
                      );
                    return IconButton(
                      onPressed: () =>
                          model.toggleFavorite(Provider.of<Term>(context)),
                      icon: Icon(
                          term.isFavorite ? Icons.star : Icons.star_border,
                          color: Colors.white,
                          size: 35),
                    );
                  }),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            term == null ? 'Urban Dictionary' : term.term,
            textAlign: TextAlign.center,
            style: textStyles.termHeaderStyle,
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
