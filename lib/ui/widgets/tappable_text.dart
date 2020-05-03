import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class TappableText extends StatelessWidget {
  const TappableText({Key key, this.onTap, this.rawText, this.type})
      : super(key: key);

  final Function onTap;
  final String rawText;
  final String type;

  @override
  Widget build(BuildContext context) {
    final List<String> splitDef =
        rawText.split(RegExp(r'(\s+(?=[\[\]]*(?:\[|\]))|])+'));
    return RichText(
      text: TextSpan(
        children: splitDef.map((word) {
          if (word.isEmpty) return const TextSpan(text: '');
          if (word[0] == '[') {
            return TextSpan(
              text: splitDef[0] == word
                  ? word.replaceFirst('[', '')
                  : word.replaceFirst('[', ' '),
              recognizer: TapGestureRecognizer()
                ..onTap = () => onTap(word.replaceFirst('[', '')),
              style: type == 'definition'
                  ? Theme.of(context).textTheme.body2
                  : Theme.of(context).textTheme.overline,
            );
          } else {
            return TextSpan(
              text: word,
              style: type == 'definition'
                  ? Theme.of(context).textTheme.body1
                  : Theme.of(context).textTheme.caption,
            );
          }
        }).toList(),
      ),
    );
  }
}
