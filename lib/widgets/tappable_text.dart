import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class TappableText extends StatelessWidget {
  const TappableText({Key key, this.onTap, this.rawText, this.type})
      : super(key: key);

  final Function onTap;
  final String rawText;
  final String type;

  @override
  Widget build(BuildContext context) {
    List<String> splitDef =
        rawText.split(RegExp(r'(\s+(?=[\[\]]*(?:\[|\]))|])+'));
    return RichText(
      text: TextSpan(
        children: splitDef.map((word) {
          if (word.length == 0) return TextSpan(text: '');
          if (word[0] == '[') {
            return TextSpan(
              text: splitDef[0] == word
                  ? word.replaceFirst('[', '')
                  : word.replaceFirst('[', ' '),
              recognizer: TapGestureRecognizer()
                ..onTap = () => onTap(word.replaceFirst('[', '')),
              style: type == 'definition'
                  ? customStyles.tapDefinitionTextStyle
                  : customStyles.tapExampleTextStyle,
            );
          } else {
            return TextSpan(
              text: word,
              style: type == 'definition'
                  ? customStyles.definitionTextStyle
                  : customStyles.exampleTextStyle,
            );
          }
        }).toList(),
      ),
    );
  }
}
