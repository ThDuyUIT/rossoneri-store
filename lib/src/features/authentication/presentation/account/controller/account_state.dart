import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/untils/string_validators.dart';

enum IndividualInfoTextFields {
  fullName,
  phoneNumber,
  address,
}

mixin AccountInformationValidator {
  final StringValidator minfullNameLengthValidator =
      MinLengthStringValidator(8);
  final StringValidator numberValidation = NumberValidator();
  final StringValidator minNumberLengthValidator = MinLengthNumberValidator(10);
  final StringValidator minAndressLengthValidator =
      MinLengthStringValidator(15);
}

class AccountState with AccountInformationValidator {
  final IndividualInfoTextFields textfieldTypes;
  final AsyncValue<void> value;

  AccountState(
      {this.textfieldTypes = IndividualInfoTextFields.fullName,
      this.value = const AsyncValue.data(null)});

  bool validateFullName(String fullName) {
    return minfullNameLengthValidator.isValid(fullName);
  }

  bool validatePhoneNumber(String phoneNumber) {
    return numberValidation.isValid(phoneNumber);
  }

  bool validatePhoneNumberLength(String phoneNumber) {
    return minNumberLengthValidator.isValid(phoneNumber);
  }

  bool validateAddress(String address) {
    return minAndressLengthValidator.isValid(address);
  }

  String? fullNameErrorText(String fullName) {
    final bool showErrorText = !validateFullName(fullName);
    final String errorText = fullName.isEmpty
        ? 'Full name can\'t be empty'
        : 'Full name is too short';
    return showErrorText ? errorText : null;
  }

  String? phoneNumberErrorText(String phoneNumber) {
    final bool showErrorText = !validatePhoneNumber(phoneNumber);
    final bool showErrorTextLength = !validatePhoneNumberLength(phoneNumber);
    final String errorText = phoneNumber.isEmpty
        ? 'Phone number can\'t be empty'
        : 'Invalid phone number';
    return (showErrorText || showErrorTextLength) ? errorText : null;
  }

  String? addressErrorText(String address) {
    final bool showErrorText = !validateAddress(address);
    final String errorText =
        address.isEmpty ? 'Address can\'t be empty' : 'Address is too short';
    return showErrorText ? errorText : null;
  }

  AccountState copyWith({
    IndividualInfoTextFields? textfieldTypes,
    AsyncValue<void>? value,
  }) {
    return AccountState(
      textfieldTypes: textfieldTypes ?? this.textfieldTypes,
      value: value ?? this.value,
    );
  }
}
