import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/positions/presentation/screens/position_screen.dart';
import 'package:solutech_votify/features/positions/presentation/widgets/position_details.dart';
import 'package:solutech_votify/utils/extensions/go_router.dart';

import '../../domain/entities/position.dart';

class PositionCard extends StatelessWidget {
  final Position position;

  const PositionCard({
    super.key,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(PositionScreen.routePath.withParams({
          "id": position.id,
        }));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              position.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            PositionDetails(
              position: position,
            ),
          ],
        ),
      ),
    );
  }
}
