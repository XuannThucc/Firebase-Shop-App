
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import '../../../providers/products.dart';
import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductItem(
          products[index].id,
          products[index].title,
          products[index].price,
          products[index].imageUrl,
        ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
