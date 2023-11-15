import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';

class CustomRotation extends StatefulWidget {
  const CustomRotation({super.key});

  @override
  _MyRotatingImageState createState() => _MyRotatingImageState();
}

class _MyRotatingImageState extends State<CustomRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Adjust the duration as needed
    )..repeat(); // This makes the rotation continuous
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return RotationTransition(
      turns: _controller,
      child: Image.asset(
        AssetsConstants.appLogo,
        width: size.width * 0.2,
        height: size.height * 0.2,
      ),
    );
  }
}
