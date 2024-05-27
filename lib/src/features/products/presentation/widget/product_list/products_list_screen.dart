import 'package:flutter/material.dart';
import 'package:rossoneri_store/src/common_widgets.dart/app_bar/home_app_bar.dart';
import 'package:rossoneri_store/src/common_widgets.dart/responsive_center.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/products/presentation/widget/product_list/products_grid.dart';
import 'package:rossoneri_store/src/features/products/presentation/widget/product_list/products_search_textfield.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductListScreenState();
  }
}

class ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HomeAppBar(isTitle: true,),
        body: CustomScrollView(
          slivers: [
            const ResponsiveSliverCenter(
              padding: EdgeInsets.all(Sizes.p16),
              child: ProductsSearchTextfield(),
            ),
            ResponsiveSliverCenter(
              padding: const EdgeInsets.all(Sizes.p16),
              child: ProductsGrid(),
            )
          ],
        ));
  }
}
