import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/styles.dart';

final passwordVisibilityProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

class PasswordInput extends ConsumerWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const PasswordInput({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context, ref) {
    final isVisible = ref.watch(passwordVisibilityProvider);
    return TextFormField(
      controller: controller,
      autocorrect: false,
      obscureText: !isVisible,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        hintText: hintText,
        suffixIconColor: Color(Colors.grey.value),
        suffixIcon: GestureDetector(
          onTap: () {
            ref.read(passwordVisibilityProvider.notifier).state = !isVisible;
          },
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: 10,
            height: 10,
            child: !isVisible
                ? const Icon(FeatherIcons.eyeOff)
                : const Icon(FeatherIcons.eye),
          ),
        ),
        border: defaultInputBorder,
        enabledBorder: defaultInputBorder,
        focusedBorder: defaultInputBorder,
      ),
    );
  }
}
