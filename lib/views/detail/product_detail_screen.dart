import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedThumb = 0;
  int _selectedSize = 0;

  final List<String> _thumbnails = const [
    'https://demo.sirv.com/spins/karlmartini/ecco/ecco-037.jpg',
    'https://demo.sirv.com/spins/karlmartini/ecco/ecco-055.jpg',
    'https://demo.sirv.com/spins/karlmartini/ecco/ecco-019.jpg',
    'https://demo.sirv.com/spins/karlmartini/ecco/ecco-091.jpg',
  ];

  final List<String> _sizes = const [
    'US 4',
    'US 4.5',
    'US 5',
    'US 5.5',
    'US 6',
  ];

  String _getCameraOrbit() {
    switch (_selectedThumb) {
      case 1:
        return "180deg 75deg 105%";
      case 2:
        return "0deg 165deg 105%";
      case 3:
        return "0deg 15deg 105%";
      case 0:
      default:
        return "0deg 75deg 105%";
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF7F7FA);
    const ink = Color(0xFF17181C);
    const accent = Color(0xFFFF5A1F);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildTopBar(ink),
              const SizedBox(height: 20),
              _buildHeroCard(accent),
              const SizedBox(height: 16),
              _buildThumbnailRail(accent),
              const SizedBox(height: 20),
              _buildTitleRow(ink, accent),
              const SizedBox(height: 8),
              _buildPriceRow(ink, accent),
              const SizedBox(height: 12),
              _buildStatsRow(ink),
              const SizedBox(height: 16),
              const Text(
                'A signature shoe designed for everyday style and unmatched comfort. Seamless performance details combined with a legacy silhouette.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Color(0xFF8B8D97),
                ),
              ),
              const SizedBox(height: 24),
              _buildSizeSelector(ink, accent),
              const Spacer(),
              _buildActions(accent, ink),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(Color ink) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _circleIconButton(
          Icons.arrow_back_ios_new_rounded,
          () => Navigator.maybePop(context),
          ink,
        ),
        Text(
          'Product Detail',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: ink,
          ),
        ),
        _circleIconButton(Icons.more_vert_rounded, () {}, ink),
      ],
    );
  }

  Widget _circleIconButton(IconData icon, VoidCallback onTap, Color ink) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: ink),
      ),
    );
  }

  Widget _buildHeroCard(Color accent) {
    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [accent.withOpacity(0.10), Colors.white],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: ModelViewer(
          backgroundColor: Colors.transparent,
          src:
              'https://modelviewer.dev/shared-assets/models/glTF-Sample-Assets/Models/MaterialsVariantsShoe/glTF-Binary/MaterialsVariantsShoe.glb',
          alt: 'A 3D model of a shoe',
          ar: true,
          autoRotate: true,
          cameraControls: true,
          disableZoom: false,
          cameraOrbit: _getCameraOrbit(),
        ),
      ),
    );
  }

  Widget _buildThumbnailRail(Color accent) {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _thumbnails.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final selected = index == _selectedThumb;
          return GestureDetector(
            onTap: () => setState(() => _selectedThumb = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selected ? accent.withOpacity(0.10) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: selected ? accent : const Color(0xFFE9EAF0),
                  width: selected ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: _ShoeThumb(assetPath: _thumbnails[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitleRow(Color ink, Color accent) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Jordan 1 Low Grey Toe',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17181C),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(Color ink, Color accent) {
    return Text(
      '\$14,200',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: accent,
      ),
    );
  }

  Widget _buildStatsRow(Color ink) {
    return Row(
      children: [
        const Text(
          '5 Pair Left',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF8B8D97),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 14),
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            color: Color(0xFFD6D8E0),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 14),
        const Text(
          'Sold 50',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF8B8D97),
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        const Icon(Icons.star_rounded, color: Color(0xFFFFB400), size: 18),
        const SizedBox(width: 2),
        const Text(
          '4.7',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF17181C),
          ),
        ),
        const SizedBox(width: 4),
        const Text(
          '(69 Reviews)',
          style: TextStyle(fontSize: 12, color: Color(0xFF8B8D97)),
        ),
      ],
    );
  }

  Widget _buildSizeSelector(Color ink, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Select Size',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF17181C),
              ),
            ),
            Text(
              'Size chart',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _sizes.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final selected = index == _selectedSize;
              return GestureDetector(
                onTap: () => setState(() => _selectedSize = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: selected ? accent : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selected ? accent : const Color(0xFFE9EAF0),
                    ),
                  ),
                  child: Text(
                    _sizes[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: selected ? Colors.white : const Color(0xFF17181C),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActions(Color accent, Color ink) {
    return Row(
      children: [
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Item Added To cart'),
                ),
              );
            },
            icon: const Icon(Icons.shopping_bag_outlined, size: 18),
            label: const Text('Add to Cart'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF17181C),
              side: const BorderSide(color: Color(0xFFE9EAF0)),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('Redirecting to Razorpay....'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: accent,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Buy Now',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}

class _ShoeThumb extends StatelessWidget {
  final String assetPath;
  const _ShoeThumb({required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      assetPath,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 1.5),
          ),
        );
      },
      errorBuilder: (context, error, stack) => const Icon(
        Icons.directions_run_rounded,
        size: 22,
        color: Color(0xFFFF5A1F),
      ),
    );
  }
}
