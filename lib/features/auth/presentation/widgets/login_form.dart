import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/utils/utils.dart';
import '../../../../config/styles.dart';
import '../../../../widgets/primary_button.dart';
import '../../../elections/presentation/screens/elections_screen.dart';
import '../../domain/usecases/login.dart';
import '../screens/forgot_password_screen.dart';
import 'password_input.dart';
import '../controllers/auth_controller.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void submit() {
    if (formKey.currentState!.validate()) {
      var params = LoginParams(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      ref.read(authStateProvider.notifier).login(params);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authStateProvider, (previous, state) {
      if (state.status == AuthStatus.unauthenticated) {
        state.failure!.showSnackBar(context);
      }

      if (state.status == AuthStatus.authenticated) {
        context.showSuccessSnackBar(
          "Welcome ${state.value!.fullName}",
        );
        context.go(ElectionsScreen.routePath);
      }
    });

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
                if (value!.isEmpty) {
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
            const SizedBox(height: 10),
            PasswordInput(
              hintText: "Password",
              controller: passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Password is required";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => context.push(ForgotPasswordScreen.routePath),
                child: Text(
                  "Forgot Password?",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            PrimaryButton(
              isLoading: authState.status == AuthStatus.loggingIn,
              onTap: submit,
              title: 'Login',
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
