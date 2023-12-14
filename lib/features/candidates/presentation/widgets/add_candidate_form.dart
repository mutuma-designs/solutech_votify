import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/candidates/presentation/states/candidate_state.dart';
import 'package:solutech_votify/utils/utils.dart';
import 'package:solutech_votify/widgets/primary_button.dart';

import '../../../users/domain/entities/user.dart';
import '../../../users/presentation/widgets/select_user_view.dart';
import '../controllers/candidate_controller.dart';

final selectedCandidateProvider =
    StateProvider.autoDispose<User?>((ref) => null);

class AddCandidateForm extends ConsumerStatefulWidget {
  final int positionId;
  const AddCandidateForm({super.key, required this.positionId});

  @override
  ConsumerState<AddCandidateForm> createState() => _AddCandidateFormState();
}

class _AddCandidateFormState extends ConsumerState<AddCandidateForm> {
  final formKey = GlobalKey<FormState>();
  void submit() {
    if (formKey.currentState!.validate()) {
      final user = ref.read(selectedCandidateProvider);

      ref.read(candidateStateProvider.notifier).saveCandidate(
            userId: user!.id,
            positionId: widget.positionId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(selectedCandidateProvider);
    final state = ref.watch(candidateStateProvider);

    ref.listen(candidateStateProvider, (prevState, state) {
      if (state is CandidateAdded) {
        context.pop();
        context.showSuccessSnackBar("Candidate added successfully");
      }

      if (state is AddingCandidateFailed) {
        context.pop();
        state.failure.showSnackBar(context);
      }
    });

    return Form(
      key: formKey,
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              User? user = await context.showModal(
                title: "Select Candidate",
                child: const SelectUserView(),
              );

              ref.read(selectedCandidateProvider.notifier).state = user;
            },
            child: IgnorePointer(
              child: TextFormField(
                key: ValueKey("${user?.id}"),
                initialValue: user?.fullName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a user";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(FeatherIcons.user),
                  labelText: 'Select User',
                  hintText: 'Select User',
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            onTap: submit,
            isLoading: state is AddingCandidate,
            title: "Add Candidate",
          )
        ],
      ),
    );
  }
}
