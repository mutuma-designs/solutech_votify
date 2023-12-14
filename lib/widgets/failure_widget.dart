import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:solutech_votify/utils/utils.dart';

class FailureWidget extends StatelessWidget {
  final Failure failure;
  const FailureWidget(this.failure, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        failure.toMessage(context),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.red,
            ),
      ),
    );
  }
}
