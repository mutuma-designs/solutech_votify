import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../../../../config/styles.dart';
import '../../../../widgets/primary_button.dart';
import '../../../elections/presentation/controllers/elections_controller.dart';
import '../controllers/position_controller.dart';
import '../states/position_state.dart';

class AddPositionForm extends ConsumerStatefulWidget {
  final int electionId;
  const AddPositionForm({
    super.key,
    required this.electionId,
  });

  @override
  ConsumerState<AddPositionForm> createState() => _AddPositionFormState();
}

class _AddPositionFormState extends ConsumerState<AddPositionForm> {
  DateTime pickedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  final positionNameController = TextEditingController();
  final positionDescriptionController = TextEditingController();
  final maxSelectionsController = TextEditingController();

  void submit() {
    final positionController = ref.read(positionStateProvider.notifier);
    positionController.savePosition(
      electionId: widget.electionId,
      name: positionNameController.text.trim(),
      description: positionDescriptionController.text.trim(),
      maxSelections: int.parse(
        maxSelectionsController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    positionNameController.dispose();
    positionDescriptionController.dispose();
    maxSelectionsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(positionStateProvider, (prevState, state) {
      if (state is PositionAdded) {
        context.showSuccessSnackBar("Position added successfully");
        ref.read(electionsStateProvider.notifier).getElections();
        context.pop();
      }

      if (state is AddingPositionFailed) {
        context.pop();
        state.failure.showSnackBar(context);
      }
    });

    var state = ref.watch(positionStateProvider);
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: positionNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a name";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Enter Name",
              hintStyle: const TextStyle(
                color: Color(0xff565765),
              ),
              labelText: "Name",
              isDense: true,
              filled: true,
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              focusedBorder: defaultInputBorder,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: positionDescriptionController,
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a description";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Description",
              hintText: "Enter Description",
              hintStyle: const TextStyle(
                color: Color(0xff565765),
              ),
              filled: true,
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              focusedBorder: defaultInputBorder,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: maxSelectionsController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a value";
              }
              return null;
            },
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'-')),
              FilteringTextInputFormatter.deny(RegExp(r'\.')),
            ],
            decoration: InputDecoration(
              hintText: "Enter Maximum selections",
              hintStyle: const TextStyle(
                color: Color(0xff565765),
              ),
              labelText: "Maximum selections",
              isDense: true,
              filled: true,
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              focusedBorder: defaultInputBorder,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
              isLoading: state is PositionSaving,
              onTap: () {
                if (formKey.currentState!.validate()) submit();
              },
              title: "Save Position"),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
