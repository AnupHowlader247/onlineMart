import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return cart.cartItems.isEmpty
              ? Center(child: Text('Your cart is empty.'))
              : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(
                        cart.cartItems[index].imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(cart.cartItems[index].name),
                      subtitle: Text(cart.cartItems[index].description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('\$${cart.cartItems[index].price}'),
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () {
                              Provider.of<Cart>(context, listen: false)
                                  .removeFromCart(cart.cartItems[index]);
                            },
                          ),
                        ],
                      ),
                      onLongPress: () {
                        Provider.of<Cart>(context, listen: false).removeFromCart(cart.cartItems[index]);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total: \$${cart.totalPrice}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
