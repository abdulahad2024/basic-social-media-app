import 'package:flutter/material.dart';

import '../../../../../utils/theme/app_colors.dart';

class BuildAction extends StatelessWidget {
  const BuildAction({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration:  BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: 25.0,
        onPressed: onPressed,
      ),
    );
  }
}
