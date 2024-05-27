import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/common_widgets.dart/async_value_widget.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/features/products/data/products_repository.dart';
import 'package:rossoneri_store/src/features/products/presentation/controllers/product_filter_state_provider.dart';

class KindProductFilter extends ConsumerStatefulWidget {
  const KindProductFilter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _KindProductFilterState();
}

class _KindProductFilterState extends ConsumerState<ConsumerStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    final kindsList = ref.watch(kindsOfProductsProvider);
    String indexCurrentKind = ref.watch(productFilterStateProvider);
    return AsyncValueWidget(
      value: kindsList,
      data: (kinds) => kinds.isEmpty
          ? const Center(
              child: Text('No kinds found'),
            )
          : SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        ref.read(productFilterStateProvider.notifier).state =
                            '';
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          indexCurrentKind == ''
                              ? ColorApp.rosso
                              : Colors.transparent,
                        ),
                      ),
                      child: Text('All',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: indexCurrentKind == ''
                                        ? ColorApp.white
                                        : Colors.black,
                                  ))),
                  for (final kind in kinds)
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                          kind.id == indexCurrentKind
                              ? ColorApp.rosso
                              : Colors.transparent,
                        )),
                        onPressed: () {
                          //setState(() {
                          ref.read(productFilterStateProvider.notifier).state =
                              kind.id;
//});
                        },
                        child: Text(kind.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: kind.id == indexCurrentKind
                                        ? ColorApp.white
                                        : Colors.black))),
                ],
              )),
    );
  }
}
