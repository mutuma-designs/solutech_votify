import 'package:flutter/material.dart';
import 'package:solutech_votify/utils/extensions/context.dart';

import '../../../../config/images.dart';
import '../../../elections/domain/entities/election.dart';
import '../widgets/manual_verification_form.dart';

class VerificationScreen extends StatelessWidget {
  static const String routePath = '/verification';
  final Election election;
  const VerificationScreen({
    super.key,
    required this.election,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
              ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Images.nfcCard, // Replace with your NFC card image path
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            const Text(
              'Place Membership card on the device',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap the card to initiate verification process',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ensure NFC functionality is enabled on your device',
              style: TextStyle(fontSize: 14),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: OutlinedButton(
                onPressed: () {
                  context.showModal(
                    title: "Verify manually",
                    child: ManualVerificationForm(
                      election: election,
                    ),
                  );
                },
                child: const Text('Verify Manually'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
