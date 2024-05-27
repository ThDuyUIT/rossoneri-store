import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/common_widgets.dart/primary_button.dart';
import 'package:rossoneri_store/src/common_widgets.dart/responsive_scrollable_card.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/controller/sign_in_controller.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/controller/sign_in_state.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/widget/register_form.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/widget/sign_in_form.dart';
import 'package:rossoneri_store/src/untils/async_value_ui.dart';

class SignInScreen extends ConsumerStatefulWidget {
  final AuthenticationFormType formType;
  final VoidCallback? onSignedIn;
  const SignInScreen(this.formType, {super.key, this.onSignedIn});

  @override
  ConsumerState<SignInScreen> createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends ConsumerState<SignInScreen> {
  //change between sign in and sign up
  void updateFormType(AuthenticationFormType formType) {
    ref.read(signInControllerProvider(widget.formType).notifier).updateFormType(
        formType == AuthenticationFormType.signIn
            ? AuthenticationFormType.signUp
            : AuthenticationFormType.signIn);
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen<AsyncValue>(
    //     signInControllerProvider(widget.formType)
    //         .select((state) => state.value),
    //     (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(signInControllerProvider(widget.formType));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.nero,
        foregroundColor: Colors.white,
        title: const Text('Account'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/milan_theme.jpg'),
                fit: BoxFit.cover)),
        width: double.infinity,
        height: double.infinity,
        child: ResponsiveScrollableCard(
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  state.title,
                  // ? 'Sign In'
                  // : 'Sign Up',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.p24),
                ),
              ),
              gapH20,
              state.formType == AuthenticationFormType.signIn
                  ? SignInForm(
                      state: state,
                      onSignedIn: widget.onSignedIn,
                    )
                  : SignUpForm(
                      state: state,
                    ),
              gapH16,
              widget.onSignedIn == null
                  ? TextButton(
                      onPressed: () {
                        updateFormType(state.formType);
                      },
                      child: Text(
                        state.formType == AuthenticationFormType.signIn
                            ? 'Need an account? Register'
                            : 'Have an account? Sign In',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.p16,
                            color: Colors.white),
                      ),
                    )
                  : const SizedBox(),
            ])),
      ),
    );
  }
}
