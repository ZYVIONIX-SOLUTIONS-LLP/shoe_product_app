import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoe_product/views/detail/product_detail_screen.dart';

class ListAllProduct extends StatefulWidget {
  const ListAllProduct({super.key});

  @override
  State<ListAllProduct> createState() => _ListAllProductState();
}

class _ListAllProductState extends State<ListAllProduct> {
  final List<Map<String, dynamic>> _allProducts = [
    {
      'image':
          'https://images.unsplash.com/photo-1595777457583-95e059d581b8?q=80&w=600&auto=format&fit=crop',
      'title': 'Knit Midi Dress',
      'brand': 'Apparel',
      'price': 7800000,
      'rating': 4.8,
    },
    {
      'image':
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=600&auto=format&fit=crop',
      'title': 'Geometric Bag',
      'brand': 'Bags',
      'price': 27900000,
      'rating': 4.7,
    },
    {
      'image':
          'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?q=80&w=600&auto=format&fit=crop',
      'title': 'Leather Sneakers',
      'brand': 'Shoes',
      'price': 11000000,
      'rating': 4.9,
    },
    {
      'image':
          'https://images.unsplash.com/photo-1544923246-77307dd654cb?q=80&w=600&auto=format&fit=crop',
      'title': 'Hooded Jacket',
      'brand': 'Apparel',
      'price': 5100000,
      'rating': 4.6,
    },

    {
      'image':
          'https://images.unsplash.com/photo-1544923246-77307dd654cb?q=80&w=600&auto=format&fit=crop',
      'title': 'Hooded Jacket',
      'brand': 'Apparel',
      'price': 5100000,
      'rating': 4.6,
    },

    {
      'image':
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=600&auto=format&fit=crop',
      'title': 'Geometric Bag',
      'brand': 'Bags',
      'price': 27900000,
      'rating': 4.7,
    },
  ];

  List<Map<String, dynamic>> _displayedProducts = [];
  String _currentSort = 'Default';
  String _currentFilter = 'All';

  @override
  void initState() {
    super.initState();
    _displayedProducts = List.from(_allProducts);
  }

  void _applySortAndFilter() {
    List<Map<String, dynamic>> updatedList = List.from(_allProducts);

    if (_currentFilter != 'All') {
      updatedList = updatedList
          .where((p) => p['brand'] == _currentFilter)
          .toList();
    }

    if (_currentSort == 'Price: Low to High') {
      updatedList.sort((a, b) => a['price'].compareTo(b['price']));
    } else if (_currentSort == 'Price: High to Low') {
      updatedList.sort((a, b) => b['price'].compareTo(a['price']));
    } else if (_currentSort == 'Alphabetical') {
      updatedList.sort((a, b) => a['title'].compareTo(b['title']));
    }

    setState(() {
      _displayedProducts = updatedList;
    });
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                [
                  'Default',
                  'Price: Low to High',
                  'Price: High to Low',
                  'Alphabetical',
                ].map((sortOption) {
                  return ListTile(
                    title: Text(
                      sortOption,
                      style: TextStyle(
                        fontWeight: _currentSort == sortOption
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    trailing: _currentSort == sortOption
                        ? const Icon(Icons.check, color: Colors.black)
                        : null,
                    onTap: () {
                      _currentSort = sortOption;
                      _applySortAndFilter();
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['All', 'Apparel', 'Bags', 'Shoes'].map((filterOption) {
              return ListTile(
                title: Text(
                  filterOption,
                  style: TextStyle(
                    fontWeight: _currentFilter == filterOption
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                trailing: _currentFilter == filterOption
                    ? const Icon(Icons.check, color: Colors.black)
                    : null,
                onTap: () {
                  _currentFilter = filterOption;
                  _applySortAndFilter();
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  String _formatCurrency(num value) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    return 'IDR ${value.toString().replaceAllMapped(reg, mathFunc)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Discover Products",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                _buildActionButton(
                  'Sort: $_currentSort',
                  Icons.keyboard_arrow_down,
                  _showSortBottomSheet,
                ),
                const SizedBox(width: 10),
                _buildActionButton(
                  'Type: $_currentFilter',
                  Icons.keyboard_arrow_down,
                  _showFilterBottomSheet,
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 0.5),

          Expanded(
            child: _displayedProducts.isEmpty
                ? const Center(child: Text("No items match your filters."))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      itemCount: _displayedProducts.length,
                      itemBuilder: (context, index) {
                        final product = _displayedProducts[index];
                        final double imageBlockHeight = (index % 2 == 0)
                            ? 220
                            : 160;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(),
                              ),
                            );
                          },
                          child: _buildProductCard(product, imageBlockHeight),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 2),
            Icon(icon, size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, double imageHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: imageHeight,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              product['image'],
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => const Center(
                child: Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Price metadata + Star Rating Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _formatCurrency(product['price']),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFEBC351),
                  size: 16,
                ),
                const SizedBox(width: 2),
                Text(
                  product['rating'].toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 2),

        // Product Label
        Text(
          product['title'],
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'serif',
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
