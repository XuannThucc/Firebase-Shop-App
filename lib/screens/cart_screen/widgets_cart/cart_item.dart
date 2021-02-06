import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/carts.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItemWidget(
      this.id, this.productId, this.title, this.quantity, this.price);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {//tra ve gia tri xac nhan true hay false, true thi tiep tuc thuc hien
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure??'),
                  content: Text('Delete your order!'),
                  actions: [
                    FlatButton(onPressed: () {
                      Navigator.of(ctx).pop(false); //tra lai ket qua vi false
                    }, child: Text('No')),
                    FlatButton(onPressed: () {
                      Navigator.of(ctx).pop(true); // tro ve nhung tiep tuc thuc hien cau lenh onDismiss
                    }, child: Text('Yes')),
                  ],
                ));
      },
      onDismissed: (dismiss) =>
          Provider.of<Cart>(context, listen: false).removeCart(productId),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FittedBox(child: Text('\$${price}')),
              ),
            ),
            title: Text(title),
            subtitle: Text('\$${price * quantity}'),
            trailing: Text('${quantity} x'),
          ),
        ),
      ),
    );
  }
}
