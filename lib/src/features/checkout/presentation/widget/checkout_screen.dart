import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/features/authentication/data/auth_repository.dart';
import 'package:rossoneri_store/src/features/authentication/domain/user_model.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/controller/sign_in_state.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/widget/sign_in_screen.dart';
import 'package:rossoneri_store/src/features/checkout/presentation/widget/payment_page.dart';

enum CheckoutSubRoute { signin, payment }

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  late final PageController _controller;
  var _subRoute = CheckoutSubRoute.signin;

  @override
  void initState() {
    super.initState();
    final userUid = ref.read(authStateChangesProvider).value;
    if (userUid != null) {
      setState(() {
        _subRoute = CheckoutSubRoute.payment;
      });
    }
    _controller = PageController(initialPage: _subRoute.index);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSignedIn() {
    setState(() => _subRoute = CheckoutSubRoute.payment);
    // perform a nice scroll animation to reveal the next page
    _controller.animateToPage(
      _subRoute.index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: _subRoute == CheckoutSubRoute.signin
      //       ? const Text('Sign in')
      //       : const Text('Payment'),
      // ),
      body: PageView(
        controller: _controller,
        children: [
          SignInScreen(AuthenticationFormType.signIn, onSignedIn: _onSignedIn),
          const PaymentPage()
        ],
      ),
    );
  }
}
