import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/common_widgets.dart/input_text_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/primary_button.dart';
import 'package:rossoneri_store/src/common_widgets.dart/responsive_center.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/constants/breakpoints.dart';
import 'package:rossoneri_store/src/features/authentication/data/auth_repository.dart';

class DeliveryInformationContent extends ConsumerWidget {
  const DeliveryInformationContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final auth = ref.watch(authWatchProvider).value;
    if (auth == null) {
      return const Center(
          child:
              CircularProgressIndicator()); // or some other placeholder widget
    }
    return screenWidth < Breakpoint.desktop
        ? ResponsiveCenter(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                     Text('Delivery Information', style: Theme.of(context).textTheme.titleMedium),
                    gapH20,
                    InputWidget(
                        readOnlyTextField: true,
                        color: ColorApp.nero,
                        hintText: '',
                        labelText: 'Full name',
                        defaultValue: auth!.fullName,
                        controller: TextEditingController()),
                    gapH16,
                    InputWidget(
                        readOnlyTextField: true,
                        color: ColorApp.nero,
                        hintText: '',
                        labelText: 'Phone numbers',
                        defaultValue: auth.phoneNumber,
                        controller: TextEditingController()),
                    gapH16,
                    InputWidget(
                        readOnlyTextField: true,
                        color: ColorApp.nero,
                        hintText: '',
                        labelText: 'Address',
                        defaultValue: auth.address,
                        controller: TextEditingController()),
                    gapH16,
                    InputWidget(
                        readOnlyTextField: true,
                        color: ColorApp.nero,
                        hintText: '',
                        labelText: 'Email',
                        defaultValue: auth.email,
                        controller: TextEditingController()),
                    gapH20,
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          // Add your edit logic here
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.p16,
                              color: ColorApp.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : ResponsiveCenter(
            padding: const EdgeInsets.only(
                left: Sizes.p16,
                right: Sizes.p32,
                top: Sizes.p16,
                bottom: Sizes.p16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Delivery Information'),
                    gapH20,
                    Row(
                      children: [
                        Expanded(
                          child: InputWidget(
                              readOnlyTextField: true,
                              color: ColorApp.nero,
                              hintText: '',
                              labelText: 'Full name',
                              defaultValue: 'Nguyen Thanh Duy',
                              controller: TextEditingController()),
                        ),
                        gapW12,
                        Expanded(
                          child: InputWidget(
                              readOnlyTextField: true,
                              color: ColorApp.nero,
                              hintText: '',
                              labelText: 'Phone numbers',
                              defaultValue: '0828767179',
                              controller: TextEditingController()),
                        ),
                      ],
                    ),
                    gapH20,
                    Row(
                      children: [
                        Expanded(
                          child: InputWidget(
                              readOnlyTextField: true,
                              color: ColorApp.nero,
                              hintText: '',
                              labelText: 'Address',
                              defaultValue: '123 Sysney Autralia',
                              controller: TextEditingController()),
                        ),
                        gapW12,
                        Expanded(
                          child: InputWidget(
                              readOnlyTextField: true,
                              color: ColorApp.nero,
                              hintText: '',
                              labelText: 'Email',
                              defaultValue: 'nguyenthanhduy.93.vl@gmail.com',
                              controller: TextEditingController()),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
