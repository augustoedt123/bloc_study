import 'package:bloc_study/components/email_text_field.dart';
import 'package:bloc_study/components/login_button.dart';
import 'package:bloc_study/components/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  final OnLoginTapped onLoginTapped;

  const LoginView({ required this.onLoginTapped, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          EmailTextField(emailController: emailController),
          PasswordTextField(passwordController: passwordController),
          LoginButton(
              emailController: emailController,
              passwordController: passwordController,
              onLoginTapped: onLoginTapped
          )
        ],
      )
    );
  }
}
