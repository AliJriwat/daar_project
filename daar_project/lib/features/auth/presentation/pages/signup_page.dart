import 'package:daar_project/app/theme/colors.dart';
import 'package:daar_project/core/utils/show_snackbar.dart';
import 'package:daar_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:daar_project/features/auth/presentation/pages/login_page.dart';
import 'package:daar_project/features/auth/presentation/widgets/auth_button.dart';
import 'package:daar_project/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/loader.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordConfirmTextController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        child: BlocConsumer<AuthBloc,AuthState>(
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
                    "Create your Account",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  AuthField(hintText: "Username", controller: usernameTextController,),
                  const SizedBox(height: 16),
                  AuthField(hintText: "Email", controller: emailTextController,),
                  const SizedBox(height: 16),
                  AuthField(hintText: "Password",controller: passwordTextController,isObscureText: true,),
                  const SizedBox(height: 16),
                  AuthField(hintText: "Confirm Password",controller: passwordConfirmTextController,isObscureText: true,),
                  const SizedBox(height: 16),
                  AuthButton(text: "Sign Up", onPressed: () {
                    if(formkey.currentState!.validate()) {
                      context.read<AuthBloc>().add(AuthSignUp(name: usernameTextController.text.trim(), email: emailTextController.text.trim(), password: passwordTextController.text.trim()));
                    }
                  },),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                          },
                    child: RichText(
                      text: TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                                text: "Sign In",
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
