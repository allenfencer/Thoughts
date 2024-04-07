import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thoughts/global_widgets/custom_button.dart';
import 'package:thoughts/global_widgets/custom_text_field.dart';
import 'package:thoughts/utils/routes/app_route_constant.dart';
import 'package:thoughts/utils/themes/colors.dart';
import 'package:thoughts/utils/themes/text_theme.dart';
import 'package:thoughts/utils/validation/validation.dart';

import '../providers/auth_providers.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final passVisibility = ref.watch(passwordVisibilityProvider);
    final authProv = ref.watch(authProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.brandWhite,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Signup ', style: TT.f28w700),
                const SizedBox(height: 25),
                const Text(
                  'We are happy to see you here again, Enter your email address and password.',
                  style: TT.f14w400,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: 'Name',
                  editingController: nameController,
                  // label: 'Email',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: 'Email',
                  editingController: emailController,
                  // label: 'Email',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  formValidator: (value) {
                    return Validation.validateEmail(value);
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: 'Password',
                  editingController: passwordController,
                  maxLines: 1,
                  suffixIcon: IconButton(
                    onPressed: () {
                      ref.read(passwordVisibilityProvider.notifier).state =
                          !passVisibility;
                    },
                    icon: Icon(
                      passVisibility ? Icons.visibility : Icons.visibility_off,
                      size: 18,
                    ),
                  ),
                  obscureText: passVisibility,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.none,
                  formValidator: (val) => Validation.passwordValidation(val),
                ),
                const SizedBox(height: 100),
                CustomButton(
                  isLoading: authProv,
                  buttonText: 'Sign up',
                  function: () {
                    if (formKey.currentState!.validate()) {
                      ref.read(authProvider.notifier).signup(
                          context: context,
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                    }
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text.rich(TextSpan(
                      text: 'Already have an account? ',
                      style: TT.f14w500,
                      children: [
                        TextSpan(
                            text: 'Login',
                            style: TT.f14w700
                                .copyWith(color: AppColors.brandBlack),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () =>
                                  context.goNamed(AppRouteConstant.loginScreen))
                      ])),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
