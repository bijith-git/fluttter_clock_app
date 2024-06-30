import 'package:flutter/material.dart';

class DialButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;

  const DialButton({super.key, this.label, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: label != null
              ? Text(
                  label ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white, fontSize: 20),
                )
              : Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
