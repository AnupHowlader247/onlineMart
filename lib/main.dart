import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';
import 'product.dart';
import 'cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductScreen(),
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'Watch',
      description: 'L LAVAREDO Ultra-Thin Mens Analog Leather Watch with TimeDate.',
      price: 50,
      imagePath: 'assets/images/watch.jpg',
    ),
    Product(
      name: 'Mobile',
      description: 'Xiaomi Mobile Phone | New Smartphone | Xiaomi India.',
      price: 200,
      imagePath: 'assets/images/mobile.jpeg',
    ),
    Product(
      name: 'Laptop',
      description: 'The best gaming laptop 2025 - all the latest models compared.',
      price: 2000,
      imagePath: 'assets/images/laptop.jpg',
    ),
    Product(
      name: 'Refrigerator',
      description: 'Fridge PNG, Vector, PSD, and Clipart With Transparent Clipart Images',
      price: 2100,
      imagePath: 'assets/images/fridge.jpg',
    ),
    Product(
      name: 'Washing machine',
      description: 'Capacity(Kg): 14 Kg Fully Automatic Samsung WA14J6750SP Washing Machine, Silver',
      price: 2600,
      imagePath: 'assets/images/machine.jpg',
    ),
    Product(
      name: 'Air Conditioner',
      description: 'Electra Air Conditioner | EAS-24K21AAB Premium | 2 Ton',
      price: 3500,
      imagePath: 'assets/images/ac.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce App'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()), // Navigate to CartScreen
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                product.imagePath, // Use Image.asset for local images
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${product.price}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false).addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${product.name} added to cart')),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
