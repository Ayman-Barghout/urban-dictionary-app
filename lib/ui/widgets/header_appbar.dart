import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/term_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/theme_bloc/theme_bloc.dart';

class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HeaderAppBar({
    super.key,
    required this.onInfoButtonPress,
    required this.child,
  });

  final VoidCallback onInfoButtonPress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210.0,
      padding: const EdgeInsets.only(bottom: 15.0),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).highlightColor,
            Theme.of(context).primaryColor,
          ],
          stops: const [
            0.0001,
            1.0,
          ],
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      onInfoButtonPress();
                    },
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) => DayNightSwitcherIcon(
                      isDarkModeEnabled:
                          state is ThemeChanged && state.isDarkTheme,
                      dayBackgroundColor:
                          Theme.of(context).colorScheme.secondary,
                      nightBackgroundColor:
                          Theme.of(context).colorScheme.secondary,
                      onStateChanged: (isDarkModeEnabled) {
                        BlocProvider.of<ThemeBloc>(context).add(ToggleTheme());
                      },
                    ),
                  ),
                ],
              ),
              BlocBuilder<TermBloc, TermState>(
                builder: (context, state) {
                  IconButton iconButton = IconButton(
                    icon: const Icon(
                      Icons.star_border,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {},
                  );
                  if (state is TermChanged) {
                    final bool isFav = state.term.isFavorite;
                    final IconData icon =
                        isFav ? Icons.star : Icons.star_border;
                    iconButton = IconButton(
                      onPressed: () {
                        BlocProvider.of<TermBloc>(context)
                            .add(ToggleFavorite(state.term));
                      },
                      icon: Icon(icon, color: Colors.white, size: 35),
                    );
                  }
                  return iconButton;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          BlocBuilder<TermBloc, TermState>(
            builder: (context, state) {
              late String text;
              if (state is InitialTermState) {
                text = 'Urban Dictionary';
              } else if (state is TermChanged) {
                text = state.term.term;
              } else if (state is TermChangeStarted) {
                text = state.term;
              }
              return Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 15.0),
            width: 250.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(25.0),
                right: Radius.circular(25.0),
              ),
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
