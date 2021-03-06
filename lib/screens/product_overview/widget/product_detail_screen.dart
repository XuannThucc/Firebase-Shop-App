import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/carts.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName =
      '/product-detail'; //Đặt tên tuyến đường để truyền dữ liệu vào đây
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final productId = ModalRoute.of(context).settings.arguments
        as String; //Ben kia gui id, ben nay nhan id theo kieu String
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findById(productId); //truy cao vao san pham cos id trung voi id cu the
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Hero(
              tag: productId,
              child: Image.network(loadedProduct.imageUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(loadedProduct.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\$${loadedProduct.price}',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(loadedProduct.description),
          ),

          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.pinkAccent,
            ),
            onPressed: () {
              cart.addItem(productId, loadedProduct.title, loadedProduct.price);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Added item to cart!! '),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  onPressed: () => cart.removeSinglerCart(productId),
                  label: 'UNDO',
                  textColor: Colors.white,
                ),
              ));
            },
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
