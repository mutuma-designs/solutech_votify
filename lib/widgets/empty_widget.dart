import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/images.dart';

class EmptyWidget extends StatelessWidget {
  final String message;
  const EmptyWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Images.smilingFolder,
            width: 250,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
