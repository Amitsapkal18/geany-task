import 'package:flutter/material.dart';
import 'package:geany/product/product_details.dart';
import 'product_model.dart'; // Import the product model

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // Sample products (for demonstration, you can fetch them from Firebase Firestore)
  List<Product> allProducts = [
    Product(
      id: '1',
      title: 'Electric Motor',
      description: 'High-quality motor for industrial use',
      cost: 1000.0,
      images: ['assets/images/motor1.png', 'assets/images/motor2.png', 'assets/images/motor3.png'],
      sector: 'Electrical',
    ),
    Product(
      id: '2',
      title: 'Hydraulic Pump',
      description: 'Durable hydraulic pump for heavy-duty applications',
      cost: 1500.0,
      images: ['assets/images/pump1.jpeg', 'assets/images/pump2.jpeg', 'assets/images/pump3.jpeg'],
      sector: 'Mechanical',
    ),
    Product(
      id: '3',
      title: 'Capacitor',
      description: 'High-capacity capacitor for electrical circuits',
      cost: 500.0,
      images: ['assets/images/capsitor1.png', 'assets/images/capsitor2.jpeg', 'assets/images/capsitor3.png'],
      sector: 'Components',
    ),
    Product(
      id: '4',
      title: 'Steel Bolt',
      description: 'Strong steel bolts for construction',
      cost: 50.0,
      images: ['assets/images/nut1.jpeg', 'assets/images/nut2.jpeg', 'assets/images/nut3.jpeg'],
      sector: 'Parts',
    ),
  ];

  List<Product> filteredProducts = [];
  String selectedSector = 'All';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts; // Show all products initially
  }

  // Method to filter products by sector
  void filterProductsBySector(String? sector) {
    setState(() {
      selectedSector = sector!;
      filteredProducts = sector == 'All'
          ? allProducts
          : allProducts.where((product) => product.sector == sector).toList();
    });
  }

  // Method to search products by title
  void searchProducts(String query) {
    setState(() {
      searchQuery = query;
      filteredProducts = allProducts.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Products',
                border: OutlineInputBorder(),
              ),
              onChanged: searchProducts,
            ),
          ),
          // Filter Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedSector,
              onChanged: filterProductsBySector,
              items: ['All', 'Electrical', 'Mechanical', 'Components', 'Parts'].map((String sector) {
                return DropdownMenuItem<String>(
                  value: sector,
                  child: Text(sector),
                );
              }).toList(),
            ),
          ),
          // Product List
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                Product product = filteredProducts[index];
                return ListTile(
                  leading: Image.asset(product.images[0], width: 80, height: 80), // Display product image
                  title: Text(product.title),
                  subtitle: Text('\$${product.cost.toString()}'),
                  onTap: () {
                    // Navigate to Product Detail Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
