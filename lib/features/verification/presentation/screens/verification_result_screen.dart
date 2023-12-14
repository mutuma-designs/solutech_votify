import 'package:flutter/material.dart';
import 'package:solutech_votify/features/users/presentation/widgets/user_details_view.dart';
import 'package:solutech_votify/utils/extensions/date_time.dart';
import '../../domain/entities/verification.dart';

class VerificationResultScreen extends StatelessWidget {
  static const String routePath = '/verification-result';
  final Verification verification;

  const VerificationResultScreen(this.verification, {super.key});

  @override
  Widget build(BuildContext context) {
    final user = verification.user;
    final verificationResult = verification.verificationResult;
    final bool canVote = verificationResult.canVote;
    final String reason = verificationResult.reason;
    final String? token = verificationResult.token;
    final DateTime? expiry = verificationResult.expiration;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification Result',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
              ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserDetailsView(user: user),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: canVote ? Colors.green : Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        canVote ? 'Verification Passed' : 'Verification Failed',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        reason,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      if (token != null)
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            token,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      const SizedBox(height: 10),
                      if (expiry != null)
                        Text(
                          'Expiry: ${expiry.toFormattedStringWithTime()}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
