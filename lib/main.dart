import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Shopinglist',
    home: ShoppingList(products: [
      Product(name: 'C#'),
      Product(name: 'Flutter'),
      Product(name: 'React Native'),
      Product(name: 'Ionic'),
      Product(name: 'Stencil'),
      Product(name: 'Vue'),
      Product(name: 'Angular'),
    ]),
  ));
}

class Product {
  const Product({required this.name});

  final String name;
}

typedef CartChangeCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangeCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) {
      return null;
    }
    return const TextStyle(
        color: Colors.black54, decoration: TextDecoration.lineThrough);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          onCartChanged(product, inCart);
        },
        leading: CircleAvatar(
          backgroundColor: _getColor(context),
          child: Text(product.name[0]),
        ),
        title: Text(
          product.name,
          style: _getTextStyle(context),
        ));
  }
}

class ShoppingList extends StatefulWidget {
  const ShoppingList({required this.products, Key? key}) : super(key: key);

  final List<Product> products;

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _shoppingCart = <Product>{};

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (!inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skills'),
        leading: IconButton(
            onPressed: null,
            icon: new Stack(children: <Widget>[
              new Icon(
                Icons.shopping_bag,
              ),
              new Positioned(
                top: 0.0,
                right: 0.0,
                child: Text(
                  _shoppingCart.length.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ])),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}
