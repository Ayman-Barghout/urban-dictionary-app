import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TappableText extends StatelessWidget {
  const TappableText({
    super.key,
    required this.onTap,
    required this.rawText,
    required this.type,
  });

  final ValueChanged<String> onTap;
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
                  ? Theme.of(context).textTheme.bodyLarge
                  : Theme.of(context).textTheme.labelSmall,
            );
          } else {
            return TextSpan(
              text: word,
              style: type == 'definition'
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.bodySmall,
            );
          }
        }).toList(),
      ),
    );
  }
}
