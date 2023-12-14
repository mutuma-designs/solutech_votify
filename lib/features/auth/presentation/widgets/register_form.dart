import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/auth/auth.dart';
import 'package:solutech_votify/utils/utils.dart';
import '../../../../config/styles.dart';
import '../../../../widgets/primary_button.dart';
import '../../domain/usecases/setup_account.dart';
import 'password_input.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authController = ref.watch(authStateProvider.notifier);
    var authState = ref.watch(authStateProvider);

    ref.listen(
      authStateProvider,
      (previous, state) {
        if (state.status == AuthStatus.registrationFailed) {
          state.failure!.showSnackBar(context);
        }

        if (state.status == AuthStatus.registered) {
          context.showSuccessSnackBar("Registration successful");
          context.go(LoginScreen.routePath);
        }
      },
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: fullNameController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Full name is required";
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                isDense: true,
                hintText: "Full Name",
                suffixIconColor: Color(Colors.grey.value),
                border: defaultInputBorder,
                enabledBorder: defaultInputBorder,
                focusedBorder: defaultInputBorder,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                }

                if (!value.contains("@")) {
                  return "Invalid email address";
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                isDense: true,
                hintText: "Email",
                suffixIconColor: Color(Colors.grey.value),
                border: defaultInputBorder,
                enabledBorder: defaultInputBorder,
                focusedBorder: defaultInputBorder,
              ),
            ),
            const SizedBox(height: 10),
            PasswordInput(
              hintText: "Password",
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is required";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            PasswordInput(
              hintText: "Confirm password",
              controller: confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Confirm password is required";
                }

                if (value != passwordController.text.trim()) {
                  return "Passwords do not match";
                }

                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            PrimaryButton(
              isLoading: authState.status == AuthStatus.registering,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  authController.setup(SetupAccountParams(
                    fullName: fullNameController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    confirmPassword: passwordController.text.trim(),
                  ));
                }
              },
              title: 'Create Account',
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
