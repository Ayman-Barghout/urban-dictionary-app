import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/term_bloc/bloc.dart';

import 'package:urban_dict_slang/ui/shared/text_styles.dart' as textStyles;
import 'package:urban_dict_slang/ui/shared/app_colors.dart' as appColors;

class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HeaderAppBar({Key key, this.onInfoButtonPress, this.child})
      : super(key: key);

  final Function onInfoButtonPress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
              BlocBuilder<TermBloc, TermState>(builder: (context, state) {
                IconButton iconButton = IconButton(
                  icon: Icon(Icons.star_border, color: Colors.white, size: 35),
                  onPressed: () {},
                );
                if (state is TermChanged) {
                  if (state.term != null) {
                    bool isFav = state.term.isFavorite;
                    IconData icon = isFav ? Icons.star : Icons.star_border;
                    iconButton = IconButton(
                      onPressed: () {
                        BlocProvider.of<TermBloc>(context)
                            .add(ToggleFavorite(state.term));
                      },
                      icon: Icon(icon, color: Colors.white, size: 35),
                    );
                  }
                }
                return iconButton;
              }),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          BlocBuilder<TermBloc, TermState>(
            builder: (context, state) {
              String text;
              if (state is InitialTermState) {
                text = 'Urban Dictionary';
              } else if (state is TermChanged) {
                text = state.term.term;
              }
              return Text(
                text,
                textAlign: TextAlign.center,
                style: textStyles.termHeaderStyle,
              );
            },
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
  Size get preferredSize => const Size.fromHeight(155.0);
}
