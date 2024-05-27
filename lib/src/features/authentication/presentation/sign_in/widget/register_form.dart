import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rossoneri_store/src/common_widgets.dart/input_text_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/primary_button.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/authentication/domain/user_model.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/controller/sign_in_controller.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/controller/sign_in_state.dart';
import 'package:rossoneri_store/src/routing/app_router.dart';

class SignUpForm extends ConsumerStatefulWidget {
  final SignInState state;
  const SignUpForm({super.key, required this.state});

  @override
  ConsumerState<SignUpForm> createState() {
    return StateSignUpForm();
  }
}

class StateSignUpForm extends ConsumerState<SignUpForm> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  final _verifyPassWordController = TextEditingController();

  String errorFullNameText = '';
  String errorEmailText = '';
  String errorPasswordText = '';
  String errorVerifyPasswordText = '';

  String get fullName => _fullNameController.text;
  String get email => _emailController.text;
  String get passWord => _passWordController.text;
  String get verifyPassWord => _verifyPassWordController.text;

  bool checkFullNameField(SignInState state) {
    if (state.fullNameErrorText(fullName) != null) {
      setState(() {
        errorFullNameText = state.fullNameErrorText(fullName)!;
      });
      return false;
    }
    setState(() {
      errorFullNameText = '';
    });

    return true;
  }

  bool checkEmailField(SignInState state) {
    if (state.emailErrorText(email) != null) {
      setState(() {
        errorEmailText = state.emailErrorText(email)!;
      });
      return false;
    }
    setState(() {
      errorEmailText = '';
    });

    return true;
  }

  bool checkPasswordField(SignInState state) {
    if (state.passwordErrorText(passWord) != null) {
      setState(() {
        errorPasswordText = state.passwordErrorText(passWord)!;
      });
      return false;
    }
    setState(() {
      errorPasswordText = '';
    });

    return true;
  }

  bool checkVerifyPasswordField(SignInState state) {
    if (state.verifyPasswordErrorText(passWord, verifyPassWord) != null) {
      setState(() {
        errorVerifyPasswordText =
            state.verifyPasswordErrorText(passWord, verifyPassWord)!;
      });
      return false;
    }
    setState(() {
      errorVerifyPasswordText = '';
    });
    return true;
  }

  Future<bool> _submitForm(SignInState state) async {
    if (!checkFullNameField(state)) {
      return false;
    }

    if (!checkEmailField(state)) {
      return false;
    }

    if (!checkPasswordField(state)) {
      return false;
    }

    if (!checkVerifyPasswordField(state)) {
      return false;
    }

    final result = await ref
        .read(signInControllerProvider(state.formType).notifier)
        .submit(email: email, password: passWord, formType: state.formType);
    if (result) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InputWidget(
          hintText: 'Enter your full name!',
          labelText: 'Full name',
          controller: _fullNameController,
          //focusNode: FocusNode(),
          invalidator: errorFullNameText,
        ),
        gapH12,
        InputWidget(
          hintText: 'Enter your email!',
          labelText: 'Username (Email)',
          controller: _emailController,
          //focusNode: FocusNode(),
          invalidator: errorEmailText,
        ),
        gapH12,
        InputWidget(
          hintText: 'Enter your password!',
          labelText: 'Password',
          controller: _passWordController,
          //focusNode: FocusNode(),
          coverSuffixIcon: true,
          invalidator: errorPasswordText,
        ),
        gapH12,
        InputWidget(
          hintText: 'Enter your password again!',
          labelText: 'Verify password',
          controller: _verifyPassWordController,
          //focusNode: FocusNode(),
          coverSuffixIcon: true,
          invalidator: errorVerifyPasswordText,
        ),
        gapH20,
        PrimaryButton(
            text: state.primaryButton,
            onPressed: () async {
              final success = await _submitForm(state);
              if (success) {
                // ref
                //     .read(signInControllerProvider(state.formType).notifier)
                //     .updateFormType(AuthenticationFormType.signIn);

                await ref
                    .read(signInControllerProvider(state.formType).notifier)
                    .saveUserData(User(
                      email: email,
                      fullName: fullName,
                      phoneNumber: '',
                      address: '',
                    ));


                context.goNamed(AppRoute.home.name);
              }
            }),
      ],
    );
  }
}
