import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rossoneri_store/src/common_widgets.dart/edit_text_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/input_text_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/primary_button.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/authentication/data/auth_repository.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/account/controller/account_screen_controller.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/account/controller/account_state.dart';
import 'package:rossoneri_store/src/routing/app_router.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() {
    return ProfileTabState();
  }
}

class ProfileTabState extends ConsumerState<ProfileTab> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumsController = TextEditingController();
  final _addressController = TextEditingController();

  String errorFullNameText = '';
  String errorEmailText = '';
  String errorPhoneText = '';
  String errorAddressText = '';

  String get fullName => _fullNameController.text;
  String get email => _emailController.text;
  String get phoneNums => _phoneNumsController.text;
  String get address => _addressController.text;

  IconData editIconFullName = Icons.edit_rounded;
  IconData editIconPhone = Icons.edit_rounded;
  IconData editIconAddress = Icons.edit_rounded;

  Future<void> _submitFullName(AccountState state) async {
    if (editIconFullName == Icons.edit_rounded) {
      setState(() {
        editIconFullName = Icons.save_rounded;
      });
      return;
    }
    if (state.fullNameErrorText(fullName) != null) {
      setState(() {
        errorFullNameText = state.fullNameErrorText(fullName)!;
      });
      return;
    }
    final result = await ref
        .read(accountTabControllerProvider(IndividualInfoTextFields.fullName)
            .notifier)
        .saveIndividualInfo(
            data: fullName, textFieldsType: IndividualInfoTextFields.fullName);
    if (result) {
      setState(() {
        editIconFullName = Icons.edit_rounded;
        errorFullNameText = '';
      });
    }
  }

  Future<void> _submitPhoneNums(AccountState state) async {
    if (editIconPhone == Icons.edit_rounded) {
      setState(() {
        editIconPhone = Icons.save_rounded;
      });
      return;
    }
    if (state.phoneNumberErrorText(phoneNums) != null) {
      setState(() {
        errorPhoneText = state.phoneNumberErrorText(phoneNums)!;
      });
      return;
    }
    final result = await ref
        .read(accountTabControllerProvider(IndividualInfoTextFields.phoneNumber)
            .notifier)
        .saveIndividualInfo(
            data: phoneNums,
            textFieldsType: IndividualInfoTextFields.phoneNumber);
    
    if (result) {
      setState(() {
        editIconPhone = Icons.edit_rounded;
        errorPhoneText = '';
      });
    }
  }

  Future<void> _submitAddress(AccountState state) async {
    if (editIconAddress == Icons.edit_rounded) {
      setState(() {
        editIconAddress = Icons.save_rounded;
      });
      return;
    }
    if (state.addressErrorText(address) != null) {
      setState(() {
        errorAddressText = state.addressErrorText(address)!;
      });
      return;
    }
    final result = await ref
        .read(accountTabControllerProvider(IndividualInfoTextFields.address)
            .notifier)
        .saveIndividualInfo(
            data: address, textFieldsType: IndividualInfoTextFields.address);

    if (result) {
      setState(() {
        editIconAddress = Icons.edit_rounded;
        errorAddressText = '';
      });
    }
  }

  Future<void> _signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    context.goNamed(AppRoute.home.name);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authWatchProvider).value;
    final state = ref
        .watch(accountTabControllerProvider(IndividualInfoTextFields.fullName));
    if (user == null) {
      return const Center(
          child:
              CircularProgressIndicator()); // or some other placeholder widget
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EditTextWidget(
            defaultValue: user.fullName,
            color: ColorApp.grey,
            hintText: 'Enter your full Name',
            labelText: 'Full Name',
            controller: _fullNameController,
            suffixIcon: editIconFullName,
            invalidator: errorFullNameText,
            onTap: () => _submitFullName(state)),
        gapH12,
        InputWidget(
          readOnlyTextField: true,
          defaultValue: user.email,
          color: ColorApp.grey,
          hintText: 'Enter your email',
          controller: _emailController,
          labelText: 'Email',
        ),
        gapH12,
        EditTextWidget(
            defaultValue: user.phoneNumber,
            color: ColorApp.grey,
            hintText: 'Enter your phone number',
            labelText: 'Phone Number',
            controller: _phoneNumsController,
            suffixIcon: editIconPhone,
            invalidator: errorPhoneText,
            onTap: () => _submitPhoneNums(state)),
        gapH12,
        EditTextWidget(
            defaultValue: user.address,
            color: ColorApp.grey,
            hintText: 'Enter your address',
            labelText: 'Address',
            controller: _addressController,
            suffixIcon: editIconAddress,
            invalidator: errorAddressText,
            onTap: () => _submitAddress(state)),
        gapH24,
        PrimaryButton(text: 'Log Out', onPressed: () async => await _signOut()),
      ],
    );
  }
}
