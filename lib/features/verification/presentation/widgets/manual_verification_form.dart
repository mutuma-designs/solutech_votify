import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/utils/utils.dart';
import 'package:solutech_votify/widgets/primary_button.dart';
import '../../../../config/styles.dart';
import '../../../elections/domain/entities/election.dart';
import '../controllers/verification_controller.dart';
import '../screens/verification_result_screen.dart';
import '../states/verification_state.dart';

class ManualVerificationForm extends ConsumerStatefulWidget {
  final Election election;
  const ManualVerificationForm({
    super.key,
    required this.election,
  });

  @override
  ConsumerState<ManualVerificationForm> createState() =>
      _ManualVerificationFormState();
}

class _ManualVerificationFormState
    extends ConsumerState<ManualVerificationForm> {
  final uniqueIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen<VerificationState>(verificationStateProvider, (prev, next) {
      log("Verification state changed to $next");
      if (next is Verified) {
        context.pop();
        context.push(
          VerificationResultScreen.routePath,
          extra: next.verification,
        );
      }

      if (next is VerificationFailed) {
        context.pop();
        next.failure.showSnackBar(context);
      }
    });
    final verificationState = ref.watch(verificationStateProvider);
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 16),
          TextFormField(
            controller: uniqueIdController,
            keyboardType: TextInputType.text,
            validator: (value) {
              return null;
            },
            decoration: InputDecoration(
              hintText: "Enter Unique ID",
              hintStyle: const TextStyle(
                color: Color(0xff565765),
              ),
              labelText: "Unique ID",
              isDense: true,
              filled: true,
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              focusedBorder: defaultInputBorder,
            ),
          ),
          const SizedBox(height: 8),
          PrimaryButton(
            isLoading: verificationState is Verifying,
            onTap: () {
              ref.read(verificationStateProvider.notifier).verifyVoter(
                    uniqueId: uniqueIdController.text,
                    electionId: widget.election.id,
                  );
            },
            title: "Verify",
          ),
        ],
      ),
    );
  }
}
