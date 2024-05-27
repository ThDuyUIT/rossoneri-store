import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/common_widgets.dart/async_value_widget.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/products/data/products_repository.dart';
import 'package:rossoneri_store/src/features/products/domain/kind_of_products_model.dart';
import 'package:rossoneri_store/src/features/products/presentation/controllers/product_filter_state_provider.dart';

class KindsProductPopupMenu extends ConsumerStatefulWidget {
  const KindsProductPopupMenu({Key? key}) : super(key: key);

  @override
  ConsumerState<KindsProductPopupMenu> createState() =>
      _KindsProductPopupMenuState();
}

class _KindsProductPopupMenuState extends ConsumerState<KindsProductPopupMenu> {
  @override
  Widget build(BuildContext context) {
    final kindsList = ref.watch(kindsOfProductsProvider);
    String indexCurrentKind = ref.watch(productFilterStateProvider);
    return AsyncValueWidget(
        value: kindsList,
        data: (data) {
          return PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) {
              return [
                 PopupMenuItem(
                  value: '',
                  child: Container(
                    width: double.infinity,
                      padding: const EdgeInsets.all(Sizes.p8),
                      color: indexCurrentKind.isEmpty
                          ? ColorApp.rosso
                          : Colors.transparent,
                    child: Text('All', style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:  indexCurrentKind == ''
                              ? ColorApp.white
                              : Colors.black),)),
                ),
                for (final kind in data)
                  PopupMenuItem(
                    
                    value: kind.id,
                    child: Container(
                      // height: double.infinity,
                       width: double.infinity,
                      padding: const EdgeInsets.all(Sizes.p8),
                      color: kind.id == indexCurrentKind
                          ? ColorApp.rosso
                          : Colors.transparent,
                      child: Text(
                        kind.name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: kind.id == indexCurrentKind
                              ? ColorApp.white
                              : Colors.black),
                      ),
                    ),
                  )
              ];
            },
            onSelected: (value) {
              ref.read(productFilterStateProvider.notifier).state = value;
            },
          );
        });
  }
}
