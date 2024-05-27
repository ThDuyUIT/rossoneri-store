import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/untils/string_validators.dart';

enum AuthenticationFormType {
  signIn,
  signUp,
  //reset,
}

mixin UsernameAndPasswordValidator {
  final StringValidator minfullNameLengthValidator =
      MinLengthStringValidator(8);
  // final StringValidator nonEmptyFullNameValidator =
  //     NonEmptyStringValidator(); 
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);
  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();
  final MatchVerifyPasswordValidator matchVerifyPasswordValidator =
      MatchVerifyPasswordValidator(value: '', matchValue: '');
}

class SignInState with UsernameAndPasswordValidator {
  final AuthenticationFormType formType;
  // track state data, loading and error state.
  final AsyncValue<void> value;
  
  SignInState(
      {this.formType = AuthenticationFormType.signIn,
      this.value = const AsyncValue.data(null)});

  SignInState copyWith(
      {AuthenticationFormType? formType, AsyncValue<void>? value}) {
    return SignInState(
      formType: formType ?? this.formType,
      value: value ?? this.value,
    );
  }

  String get title {
    switch (formType) {
      case AuthenticationFormType.signIn:
        return 'Sign In';
      case AuthenticationFormType.signUp:
        return 'Sign Up';
      // case AuthenticationFormType.reset:
      //   return 'Reset Password';
    }
  }

  String get primaryButton {
    switch (formType) {
      case AuthenticationFormType.signIn:
        return 'Sign In';
      case AuthenticationFormType.signUp:
        return 'Sign Up';
      // case AuthenticationFormType.reset:
      //   return 'Reset';
    }
  }

  String get secondaryButton {
    switch (formType) {
      case AuthenticationFormType.signIn:
        return 'Need an account? Register';
      case AuthenticationFormType.signUp:
        return 'Have an account? Sign In';
      // case AuthenticationFormType.reset:
      //   return 'Sign In';
    }
  }

  bool validateEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool validatePassword(String password) {
    switch (formType) {
      case AuthenticationFormType.signIn:
        return passwordSignInSubmitValidator.isValid(password);
      case AuthenticationFormType.signUp:
        return passwordRegisterSubmitValidator.isValid(password);
      // case AuthenticationFormType.reset:
      //   return passwordResetSubmitValidator.isValid(password);
    }
  }

  bool validateVerifyPassword(String password, String verifiyPassword) {
    return matchVerifyPasswordValidator.isMatch(password, verifiyPassword);
  }


  bool validateFullName(String fullName) {
    return minfullNameLengthValidator.isValid(fullName);
  }

  // Notice error text
  String? emailErrorText(String email) {
    final bool showErrorText = !validateEmail(email);

    final String errorText =
        email.isEmpty ? 'Email can\'t be empty' : 'Invalid email';
    return showErrorText ? errorText : null;
  }

  String? passwordErrorText(String password) {
    final bool showErrorText = !validatePassword(password);
    final String errorText =
        password.isEmpty ? 'Password can\'t be empty' : 'Password is too short';
    return showErrorText ? errorText : null;
  }

  String? verifyPasswordErrorText(String password, String verifyPassword) {
    final bool showErrorText =
        !validateVerifyPassword(password, verifyPassword);
    final String errorText = verifyPassword.isEmpty
        ? 'Verify password can\'t be empty'
        : 'Password does not match';
    return showErrorText ? errorText : null;
  }

  String? fullNameErrorText(String fullName) {
    final bool showErrorText = !validateFullName(fullName);
    // print('showErrorText: $showErrorText');
    final String errorText =
        fullName.isEmpty ? 'Full name can\'t be empty' : 'Full name is too short';
    return showErrorText ? errorText : null;
  }
}
