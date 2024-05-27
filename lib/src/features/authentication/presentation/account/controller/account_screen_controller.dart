import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/features/authentication/data/auth_repository.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/account/controller/account_state.dart';

class AccountTabController extends StateNotifier<AccountState> {
  AccountTabController(
      {required IndividualInfoTextFields textFieldsType,
      required this.authRepositoryProvider})
      : super(AccountState());
  final AuthRepository authRepositoryProvider;

  Future<bool> saveIndividualInfo(
      {required String data,
      required IndividualInfoTextFields textFieldsType}) async {
    state = state.copyWith(value: const AsyncValue.loading());
    try {
      final value = await AsyncValue.guard(() => patchIndividualInfo(
          data: data, textFieldsType: textFieldsType));
      state = state.copyWith(value: value);
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<void> patchIndividualInfo(
      {required String data,
      required IndividualInfoTextFields textFieldsType}) async {
    switch (textFieldsType) {
      case IndividualInfoTextFields.fullName:
        return authRepositoryProvider.editFullName(data);
      case IndividualInfoTextFields.phoneNumber:
        return authRepositoryProvider.editPhoneNumber(data);
      case IndividualInfoTextFields.address:
        return authRepositoryProvider.editAddress(data);
    }
  }
}

final accountTabControllerProvider = StateNotifierProvider.family<
        AccountTabController, AccountState, IndividualInfoTextFields>(
    (ref, textFieldsType) => AccountTabController(
        textFieldsType: textFieldsType,
        authRepositoryProvider: ref.read(authRepositoryProvider)));
