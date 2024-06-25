import 'package:flutter/material.dart';

import 'package:clock_app/core/constants/color.dart';

class ActiveIcon extends StatelessWidget {
  final IconData icon;
  const ActiveIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(
          height: 3,
        ),
        Container(
          width: 20,
          height: 3,
          decoration: BoxDecoration(
            color: ColorPalette.primary,
            borderRadius: BorderRadius.circular(15),
          ),
        )
      ],
    );
  }
}
