import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/config/constants.dart';
import 'package:solutech_votify/features/users/presentation/controllers/users_controller.dart';
import 'package:solutech_votify/utils/utils.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import '../../../../widgets/primary_button.dart';
import '../controllers/user_controller.dart';
import '../states/user_state.dart';

final usersFileProvider =
    StateProvider.autoDispose<List<PlatformFile>?>((ref) => null);

class UploadUsersForm extends ConsumerStatefulWidget {
  const UploadUsersForm({
    super.key,
  });

  @override
  ConsumerState<UploadUsersForm> createState() => _UploadUsersFormState();
}

class _UploadUsersFormState extends ConsumerState<UploadUsersForm> {
  final formKey = GlobalKey<FormState>();

  void submit() {
    if (!formKey.currentState!.validate()) return;

    final usersFile = ref.read(usersFileProvider);

    ref
        .read(userStateProvider.notifier)
        .uploadUsers(File(usersFile!.first.path!));
  }

  void downloadCsvFile() async {
    await launch("$apiUrl/users/template.csv");
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userStateProvider, (prevState, state) {
      if (state is UsersUploaded) {
        context.showSuccessSnackBar("Users uploaded successfully");
        ref.read(usersStateProvider.notifier).getUsers();
        context.pop();
      }

      if (state is UploadingUsersFailed) {
        state.failure.showSnackBar(context);
      }
    });

    var state = ref.watch(userStateProvider);
    var usersFile = ref.watch(usersFileProvider);

    return Form(
      key: formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const Text(
            "Upload users",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          // download template button with icon
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              downloadCsvFile();
            },
            child: const Row(
              children: [
                Icon(
                  FeatherIcons.downloadCloud,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Download template",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          FormBuilderFilePicker(
            name: "usersCsv",
            //allowedExtensions: const ['csv'],
            initialValue: usersFile,
            decoration: const InputDecoration(
              labelText: "Users csv",
            ),
            maxFiles: 1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select a file";
              }
              return null;
            },
            previewImages: true,
            onChanged: (value) {
              if (value != null && value.isNotEmpty) {
                ref.read(usersFileProvider.notifier).state = value;
              }
            },
            typeSelectors: const [
              TypeSelector(
                type: FileType.any,
                selector: Row(
                  children: <Widget>[
                    Icon(FeatherIcons.plusCircle),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Add file"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
            isLoading: state is UploadingUsers,
            onTap: submit,
            title: "Upload File",
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
