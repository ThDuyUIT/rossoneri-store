import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rossoneri_store/src/common_widgets.dart/input_text_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/primary_button.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/controller/sign_in_controller.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/controller/sign_in_state.dart';
import 'package:rossoneri_store/src/routing/app_router.dart';

class SignInForm extends ConsumerStatefulWidget {
  final SignInState state;
  final VoidCallback? onSignedIn;
  const SignInForm({super.key, required this.state, this.onSignedIn});

  @override
  ConsumerState<SignInForm> createState() {
    return StateSignInForm();
  }
}

class StateSignInForm extends ConsumerState<SignInForm> {
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();

  String errorEmailText = '';
  String errorPasswordText = '';

  String get email => _emailController.text;
  String get passWord => _passWordController.text;

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
    if (email.isNotEmpty) {
      _node.nextFocus();
    }
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

  Future<bool> _submitForm(SignInState state) async {
    if (!checkEmailField(state)) {
      return false;
    }

    if (!checkPasswordField(state)) {
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
    return FocusScope(
      node: _node,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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
          gapH20,
          PrimaryButton(
              text: state.primaryButton,
              onPressed: widget.onSignedIn == null
                  ? () async {
                      final success = await _submitForm(state);
                      if (success) {
                        context.goNamed(AppRoute.home.name);
                      }
                    }
                  : () async {
                      final success = await _submitForm(state);
                      if (success) {
                        widget.onSignedIn!();
                      }
                    }),
        ],
      ),
    );
  }
}
