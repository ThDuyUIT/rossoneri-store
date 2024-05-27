import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/features/authentication/data/auth_repository.dart';
import 'package:rossoneri_store/src/features/authentication/domain/user_model.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/controller/sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  SignInController(
      {required AuthenticationFormType formType, required this.authRepository})
      : super(SignInState());

  final AuthRepository authRepository;

  void updateFormType(AuthenticationFormType formType) {
    state = state.copyWith(formType: formType);
  }

  Future submit(
      {required String email,
      required String password,
      required AuthenticationFormType formType}) async {
    try {
      state = state.copyWith(value: const AsyncValue.loading());
      final value = await AsyncValue.guard(() =>
          _authenticate(email: email, password: password, formType: formType));
      state = state.copyWith(value: value);
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<void> _authenticate(
      {required String email,
      required String password,
      required AuthenticationFormType formType}) async {
    switch (formType) {
      case AuthenticationFormType.signIn:
        return authRepository.signInWithEmailAndPassword(email, password);
      case AuthenticationFormType.signUp:
        return authRepository.createUserWithEmailAndPassword(email, password);
    }
  }

  Future saveUserData(User user) async {
    await authRepository.saveUserData(user);
  }
}

final signInControllerProvider = StateNotifierProvider.family<SignInController,
    SignInState, AuthenticationFormType>(
  (ref, formType) => SignInController(
      formType: formType, authRepository: ref.read(authRepositoryProvider)),
);
