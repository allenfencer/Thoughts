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

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibility = ref.watch(passwordVisibilityProvider);
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
                const Text('LOGIN', style: TT.f28w700),
                const SizedBox(height: 25),
                const Text(
                    'Unlock your thoughts with a single login\nyour notes, your world, securely accessible.',
                    style: TT.f14w400,
                    textAlign: TextAlign.center),
                const SizedBox(height: 25),
                CustomTextField(
                  label: 'Email',
                  editingController: emailController,
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
                          !visibility;
                    },
                    icon: Icon(
                      visibility ? Icons.visibility : Icons.visibility_off,
                      size: 18,
                    ),
                  ),
                  obscureText: visibility,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.none,
                  formValidator: (val) => Validation.passwordValidation(val),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TT.f12w500,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                CustomButton(
                    isLoading: authProv,
                    buttonText: 'Log in',
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ref.read(authProvider.notifier).login(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text);
                      }
                    }),
                const SizedBox(height: 30),
                Center(
                  child: Text.rich(TextSpan(
                      text: 'Dont have an account? ',
                      style: TT.f14w500,
                      children: [
                        TextSpan(
                            text: 'Create an account',
                            style: TT.f14w700
                                .copyWith(color: AppColors.brandBlack),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context
                                  .goNamed(AppRouteConstant.signupScreen))
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
