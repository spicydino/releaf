import 'package:flutter/material.dart';

class ReLeafShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1F9967),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Color(0xFF3FDAA0)),
        ),
      ),
      home: ReLeafShopPage(),
    );
  }
}

class ReLeafShopPage extends StatefulWidget {
  @override
  _ReLeafShopPageState createState() => _ReLeafShopPageState();
}

class _ReLeafShopPageState extends State<ReLeafShopPage> {
  String _selectedCategory = "Top Pick";
  final categories = ["Top Pick", "Indoor", "Outdoor", "Seeds", "Planters"];

  final List<Map<String, dynamic>> products = [
    {"name": "Snake Plant", "price": "\$15", "category": "Indoor", "image": "assets/images/snake_plant.jpg"},
    {"name": "Cactus", "price": "\$12", "category": "Indoor", "image": "assets/images/cactus.jpg"},
    {"name": "Palm Tree", "price": "\$25", "category": "Outdoor", "image": "assets/images/palm_tree.jpg"},
    {"name": "Basil Seeds", "price": "\$5", "category": "Seeds", "image": "assets/images/basil_seeds.jpg"},
    {"name": "Ceramic Planter", "price": "\$18", "category": "Planters", "image": "assets/images/ceramic_planter.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    // Filter products based on selected category
    final filteredProducts = _selectedCategory == "Top Pick"
        ? products // Show all products for "Top Pick"
        : products.where((p) => p["category"] == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Text(
              "ReLeaf Shop",
              style: TextStyle(
                color: Color(0xFF3FDAA0),
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Promotional banner
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Color(0xFFFDD4CD),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "There's a Plant\nfor everyone",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 2,
                          width: 120,
                          color: Colors.teal,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Get your 1st plant\n@ 40% off",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Image.network(
                  'https://via.placeholder.com/150',
                  width: 150,
                ),
              ],
            ),
          ),
          // Search bar
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color(0xFF1A2C1F),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          // Categories
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = categories[index];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: Column(
                      children: [
                        Text(
                          categories[index],
                          style: TextStyle(
                            color: _selectedCategory == categories[index]
                                ? Color(0xFF3FDAA0)
                                : Colors.white,
                            fontWeight: _selectedCategory == categories[index]
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 4),
                        if (_selectedCategory == categories[index])
                          Container(
                            height: 3,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF3FDAA0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Scrollable Product List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[900],
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: Image.asset(
                      filteredProducts[index]["image"],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      filteredProducts[index]["name"],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      filteredProducts[index]["price"],
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                    trailing: Icon(Icons.shopping_cart, color: Colors.green),
                    onTap: () {
                      // TODO: Navigate to product details page
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
