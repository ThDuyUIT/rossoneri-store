import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/features/products/presentation/controllers/product_search_state_provider.dart';

class ProductsSearchTextfield extends ConsumerStatefulWidget {
  const ProductsSearchTextfield({super.key});

  @override
  ConsumerState<ProductsSearchTextfield> createState() {
    return ProductsSearchTextfieldState();
  }
}

class ProductsSearchTextfieldState
    extends ConsumerState<ProductsSearchTextfield> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search products',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      ref.read(productSearchStateProvider.notifier).state = '';
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            ref.read(productSearchStateProvider.notifier).state = value;
          },
        );
      },
    );
  }
}
