import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../../../../config/styles.dart';
import '../../../../widgets/primary_button.dart';
import '../../../elections/presentation/controllers/elections_controller.dart';
import '../../domain/entities/position.dart';
import '../controllers/position_controller.dart';
import '../states/position_state.dart';

class UpdatePositionForm extends ConsumerStatefulWidget {
  final int positionId;
  const UpdatePositionForm({
    super.key,
    required this.positionId,
  });

  @override
  ConsumerState<UpdatePositionForm> createState() => _AddPositionFormState();
}

class _AddPositionFormState extends ConsumerState<UpdatePositionForm> {
  DateTime pickedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  final positionNameController = TextEditingController();
  final positionDescriptionController = TextEditingController();
  final maxSelectionsController = TextEditingController();

  void submit() {
    final positionController = ref.read(positionStateProvider.notifier);
    positionController.updatePosition(
      positionId: widget.positionId,
      name: positionNameController.text.trim(),
      description: positionDescriptionController.text.trim(),
      maxSelections: int.parse(
        maxSelectionsController.text.trim(),
      ),
    );
  }

  void setInitialValues(Position position) {
    positionNameController.text = position.name;
    positionDescriptionController.text = position.description;
    maxSelectionsController.text = position.maxSelections.toString();
  }

  @override
  void dispose() {
    super.dispose();
    positionNameController.dispose();
    positionDescriptionController.dispose();
    maxSelectionsController.dispose();
  }

  @override
  void initState() {
    super.initState();
    final position = ref.read(positionProvider(widget.positionId));
    if (position != null) {
      setInitialValues(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(positionStateProvider, (prevState, state) {
      if (state is PositionUpdated) {
        context.showSuccessSnackBar("Position updated successfully");
        ref.read(electionsStateProvider.notifier).getElections();
        context.pop();
      }

      if (state is UpdatingPositionFailed) {
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
                return "Please enter name";
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
                return "Please enter description";
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
                return "Please enter maximum selections";
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
