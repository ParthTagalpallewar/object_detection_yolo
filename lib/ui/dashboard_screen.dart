import 'package:flutter/material.dart';
import 'package:object_detection_yolo/ui/camera_screen.dart';
import 'package:object_detection_yolo/ui/upi_screen.dart';
import 'dart:io';

import '../models/shooping_cart.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Shopping cart list

  @override
  Widget build(BuildContext context) {
    double totalCost = shoppingCart.fold(0, (sum, item) => sum + item.cost);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Dashboard'),
      ),
      body: shoppingCart.isEmpty
          ? const Center(
        child: Text(
          'No items in the cart!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: shoppingCart.length,
              itemBuilder: (context, index) {
                final item = shoppingCart[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.file(
                      File(item.imagePath),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.label),

                    trailing: Text('Cost: ₹${item.cost.toStringAsFixed(2)}')
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '₹${totalCost.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UPIScreen(amount: totalCost),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    backgroundColor: Colors.blue
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageUploadPage(),
            ),
          );
          setState(() {
            
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}
