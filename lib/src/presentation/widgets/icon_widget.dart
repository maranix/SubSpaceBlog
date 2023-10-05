import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    this.icon,
    this.onPressed,
  });

  final IconData? icon;
  final VoidCallback? onPressed;

  factory IconWidget.svgAsset({Key? key, required String assetName}) => _SvgIconWidget(
        key: key,
        asset: assetName,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        splashRadius: 24.0,
        onPressed: () {},
        icon: Icon(
          icon,
        ),
      ),
    );
  }
}

class _SvgIconWidget extends IconWidget {
  const _SvgIconWidget({
    super.key,
    required this.asset,
  });

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SvgPicture.asset(asset),
    );
  }
}
