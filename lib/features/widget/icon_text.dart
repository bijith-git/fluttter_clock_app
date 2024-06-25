import 'package:flutter/material.dart';

class IconedText extends StatelessWidget {
  final Widget? icon;
  final IconData? iconData;
  final String text;
  final TextStyle? textStyle;
  const IconedText({
    super.key,
    this.icon,
    this.iconData,
    required this.text,
    this.textStyle,
  }) : assert(icon == null || iconData == null);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon ?? Icon(iconData),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: textStyle ?? Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
