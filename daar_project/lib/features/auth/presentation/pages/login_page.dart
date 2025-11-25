import 'package:daar_project/app/theme/colors.dart';
import 'package:daar_project/features/auth/presentation/pages/signup_page.dart';
import 'package:daar_project/features/auth/presentation/widgets/auth_button.dart';
import 'package:daar_project/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              } else if (state is AuthSuccess) {


              }
            },

            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }
            return Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login to your Account",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  AuthField(hintText: "Email", controller: emailTextController,),
                  const SizedBox(height: 16),
                  AuthField(hintText: "Password",controller: passwordTextController,isObscureText: true,),
                  const SizedBox(height: 16),
                  AuthButton(text: "Sign In", onPressed: () {
                    if (formkey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        AuthLogin(
                          email: emailTextController.text.trim(),
                          password: passwordTextController.text.trim(),
                        ),
                      );
                    }
                  },
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.primary,
                            )
                          )
                        ]
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
