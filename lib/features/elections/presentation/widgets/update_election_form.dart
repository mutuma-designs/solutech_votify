import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/elections/presentation/controllers/elections_controller.dart';
import 'package:solutech_votify/utils/extensions/date_time.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../../../../config/styles.dart';
import '../../../../widgets/primary_button.dart';
import '../../domain/entities/election.dart';
import '../../domain/usecases/update_election.dart';

class UpdateElectionForm extends ConsumerStatefulWidget {
  final int electionId;
  const UpdateElectionForm({
    super.key,
    required this.electionId,
  });

  @override
  ConsumerState<UpdateElectionForm> createState() => _AddElectionFormState();
}

class _AddElectionFormState extends ConsumerState<UpdateElectionForm> {
  DateTime pickedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  final electionTitleController = TextEditingController();
  final electionDescriptionController = TextEditingController();
  final maximumVotingTimeInMinutesController = TextEditingController();
  final minimumAgeController = TextEditingController();
  final dateController = TextEditingController();

  void submit() {
    var updateElectionParams = UpdateElectionParams(
      electionId: widget.electionId,
      name: electionTitleController.text.trim(),
      description: electionDescriptionController.text.trim(),
      maximumVotingTimeInMinutes: int.parse(
        maximumVotingTimeInMinutesController.text.trim(),
      ),
      date: pickedDate,
      minimumAge: int.parse(minimumAgeController.text.trim()),
    );

    ref.read(electionsStateProvider.notifier).updateElection(
          updateElectionParams,
        );
  }

  pickDate() {
    showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((value) {
      if (value != null) {
        pickedDate = value;
        dateController.text = pickedDate.toFormattedStringWithMonth();
      }
    });
  }

  setElectionDetails(Election election) {
    pickedDate = election.date;
    electionTitleController.text = election.name;
    electionDescriptionController.text = election.description;
    maximumVotingTimeInMinutesController.text =
        election.votingTimeInMinutes.toString();
    minimumAgeController.text = election.minimumAge.toString();
    dateController.text = election.date.toFormattedStringWithMonth();
  }

  @override
  void dispose() {
    super.dispose();
    electionTitleController.dispose();
    electionDescriptionController.dispose();
    maximumVotingTimeInMinutesController.dispose();
    minimumAgeController.dispose();
    dateController.dispose();
  }

  @override
  void initState() {
    super.initState();
    final election = ref.read(electionProvider(widget.electionId));
    if (election != null) {
      setElectionDetails(election);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(electionsStateProvider, (prevState, state) {
      if (state.status == ElectionsStatus.updated) {
        context.showSuccessSnackBar("Election updated successfully");
        context.pop();
      }

      if (state.status == ElectionsStatus.updatingFailed) {
        state.failure!.showSnackBar(context);
      }
    });

    var state = ref.watch(electionsStateProvider);
    return Form(
      key: formKey,
      child: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: electionTitleController,
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
            controller: electionDescriptionController,
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
            controller: minimumAgeController,
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
              hintText: "Enter Minimum Age",
              hintStyle: const TextStyle(
                color: Color(0xff565765),
              ),
              labelText: "Minimum Age",
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
            controller: maximumVotingTimeInMinutesController,
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
              hintText: "Enter Maximum Voting Time In Minutes",
              hintStyle: const TextStyle(
                color: Color(0xff565765),
              ),
              labelText: "Maximum Voting Time In Minutes",
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
          GestureDetector(
            onTap: pickDate,
            child: AbsorbPointer(
              child: TextFormField(
                controller: dateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please pick a date";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(FeatherIcons.calendar),
                  hintText: "Pick Date",
                  hintStyle: const TextStyle(
                    color: Color(0xff565765),
                  ),
                  labelText: "Date",
                  isDense: true,
                  filled: true,
                  border: defaultInputBorder,
                  enabledBorder: defaultInputBorder,
                  focusedBorder: defaultInputBorder,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
              isLoading: state.status == ElectionsStatus.updating,
              onTap: () {
                if (formKey.currentState!.validate()) submit();
              },
              title: "Save Election"),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
