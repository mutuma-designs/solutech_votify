import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/roles/presentation/states/roles_state.dart';
import 'package:solutech_votify/features/users/presentation/controllers/users_controller.dart';
import 'package:solutech_votify/utils/extensions/date_time.dart';
import 'package:solutech_votify/utils/utils.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';

import '../../../../config/styles.dart';
import '../../../../widgets/primary_button.dart';
import '../../../roles/domain/entities/role.dart';
import '../../../roles/presentation/controllers/roles_controller.dart';
import '../controllers/user_controller.dart';
import '../states/user_state.dart';

final selectedRoleProvider = StateProvider.autoDispose<Role?>((ref) => null);
final pickedDateProvider = StateProvider.autoDispose<DateTime?>((ref) => null);

final genderProvider = StateProvider.autoDispose<String?>((ref) => null);

final profileImagesProvider =
    StateProvider.autoDispose<List<PlatformFile>?>((ref) => null);

class AddUserForm extends ConsumerStatefulWidget {
  const AddUserForm({
    super.key,
  });

  @override
  ConsumerState<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends ConsumerState<AddUserForm> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final uniqueIdController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  void submit() {
    if (!formKey.currentState!.validate()) return;

    final userController = ref.read(userStateProvider.notifier);
    final role = ref.read(selectedRoleProvider);
    final gender = ref.read(genderProvider);
    final images = ref.read(profileImagesProvider);
    final profileImage = images != null ? File(images.first.path!) : null;
    final pickedDate = ref.read(pickedDateProvider);

    userController.saveUser(
      fullName: fullNameController.text.trim(),
      uniqueId: uniqueIdController.text.trim(),
      email: emailController.text.trim(),
      status: "Active",
      phoneNumber: phoneNumberController.text.trim(),
      gender: gender!,
      dateOfBirth: pickedDate!,
      roleId: role!.id,
      photo: profileImage,
    );
  }

  pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        ref.read(pickedDateProvider.notifier).state = value;
        log("Picked date: ${value.toFormattedString()}");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    uniqueIdController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userStateProvider, (prevState, state) {
      if (state is UserAdded) {
        context.showSuccessSnackBar("User added successfully");
        ref.read(usersStateProvider.notifier).getUsers();
        context.pop();
      }

      if (state is AddingUserFailed) {
        state.failure.showSnackBar(context);
      }
    });

    var state = ref.watch(userStateProvider);
    var rolesState = ref.watch(rolesStateProvider);
    var selectedRole = ref.watch(selectedRoleProvider);
    var gender = ref.watch(genderProvider);
    var pickedDate = ref.watch(pickedDateProvider);
    var profileImages = ref.watch(profileImagesProvider);

    return Form(
      key: formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: fullNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter full name";
              }

              return null;
            },
            decoration: const InputDecoration(
              hintText: "Enter Full Name",
              hintStyle: TextStyle(
                color: Color(0xff565765),
              ),
              labelText: "Full Name",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: uniqueIdController,
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'-')),
              FilteringTextInputFormatter.deny(RegExp(r'\.')),
            ],
            decoration: const InputDecoration(
              hintText: "Enter Unique ID",
              hintStyle: TextStyle(
                color: Color(0xff565765),
              ),
              labelText: "Unique ID",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter email";
              }

              return null;
            },
            decoration: const InputDecoration(
              hintText: "Enter email",
              hintStyle: TextStyle(
                color: Color(0xff565765),
              ),
              labelText: "Email",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FormBuilderPhoneField(
            name: 'phoneNumber',
            defaultSelectedCountryIsoCode: "KE",
            decoration: const InputDecoration(
              labelText: "Phone Number",
              hintText: "Enter phone number",
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              isDense: false,
            ),
            controller: phoneNumberController,
            iconSelector: const SizedBox.shrink(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a value";
              }

              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: pickDate,
            child: AbsorbPointer(
              child: TextFormField(
                key: Key("$pickedDate"),
                initialValue: pickedDate?.toFormattedStringWithMonth(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please pick a date";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(FeatherIcons.calendar),
                  hintText: "Pick Date of Birth",
                  labelText: "Date of Birth",
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
            value: gender,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select gender";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Select gender",
              labelText: "Gender",
            ),
            items: ["Male", "Female"]
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            onChanged: (value) {
              ref.read(genderProvider.notifier).state = value;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
            value: selectedRole,
            decoration: InputDecoration(
              hintText: "Select Role",
              labelText: "Role",
              prefixIcon: rolesState is RolesLoading
                  ? Container(
                      width: 10,
                      height: 10,
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.only(left: 10),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 30,
                minHeight: 20,
              ),
            ),
            validator: (value) {
              if (value == null) {
                return "Please select a role";
              }
              return null;
            },
            items: rolesState.roles
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              ref.read(selectedRoleProvider.notifier).state = value;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          FormBuilderFilePicker(
            name: "profileImage",
            initialValue: profileImages,
            decoration: InputDecoration(
              labelText: "Profile Image",
              hintText: "Select an image",
              isDense: true,
              filled: true,
              border: defaultInputBorder,
              enabledBorder: defaultInputBorder,
              focusedBorder: defaultInputBorder,
            ),
            maxFiles: 1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select an image";
              }
              return null;
            },
            previewImages: true,
            onChanged: (value) {
              if (value != null && value.isNotEmpty) {
                ref.read(profileImagesProvider.notifier).state = value;
              }
            },
            typeSelectors: const [
              TypeSelector(
                type: FileType.image,
                selector: Row(
                  children: <Widget>[
                    Icon(FeatherIcons.plusCircle),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Add image"),
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
            isLoading: state is UserSaving,
            onTap: submit,
            title: "Save User",
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
