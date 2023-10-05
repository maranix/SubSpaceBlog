import 'package:flutter/material.dart';

class ToggleFavouriteButtonWidget extends StatelessWidget {
  const ToggleFavouriteButtonWidget({
    required this.onPressed,
    this.isLiked = false,
    super.key,
  });

  final VoidCallback onPressed;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      icon: isLiked ? const Icon(Icons.favorite_rounded) : const Icon(Icons.favorite_outline_rounded),
      color: isLiked ? Colors.red : null,
      onPressed: onPressed,
    );
  }
}
