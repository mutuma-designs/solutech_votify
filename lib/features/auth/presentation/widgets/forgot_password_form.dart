import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/utils/utils.dart';
import '../../../../config/styles.dart';
import '../../../../widgets/primary_button.dart';
import 'register_button.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordForm extends ConsumerStatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  ConsumerState<ForgotPasswordForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<ForgotPasswordForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  void submit() {
    if (formKey.currentState!.validate()) {
      /* ref.read(authStateProvider.notifier).sendEmailInstructions(
        email: emailController.text.trim(),
      ); */
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authStateProvider,
      (previous, state) {
        if (state.status == AuthStatus.sendingInstructionsFailed) {
          state.failure!.showSnackBar(context);
        }

        if (state.status == AuthStatus.sentInstructions) {
          context.showSuccessSnackBar(
            "Instructions sent to ${emailController.text.trim()}",
          );
          context.pop();
        }
      },
    );

    final authState = ref.watch(authStateProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
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
            const SizedBox(
              height: 10,
            ),
            PrimaryButton(
              isLoading: authState.status == AuthStatus.sendingInstructions,
              onTap: submit,
              title: 'Send Instructions',
            ),
            const SizedBox(
              height: 30,
            ),
            AccountAvailabilityWidget(
              text: "Remembered your password?",
              actionText: "Login",
              onTap: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
