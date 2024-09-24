import 'package:flutter/material.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Theme.of(context).platform == TargetPlatform.iOS
          ? const Icon(Icons.arrow_back_ios_new)
          : const Icon(Icons.arrow_back),
    );
  }
}
