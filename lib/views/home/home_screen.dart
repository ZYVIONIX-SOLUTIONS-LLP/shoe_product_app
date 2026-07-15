import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shoe_product/views/detail/list_all_product.dart';
import 'package:shoe_product/views/detail/product_detail_screen.dart';

const Color kPrimaryOrange = Color(0xFFFF5A1F);
const Color kBackground = Color(0xFFF7F7FA);
const Color kCardGrey = Color(0xFFF1F2F6);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _bannerController = PageController();
  int _bannerIndex = 0;
  int _selectedCategory = 0;
  Timer? _bannerTimer;

  // Top hero banner keeps using the original local asset images.
  final List<String> _banners = const [
    'assets/banner.png',
    'assets/bannerimage.png',
    'assets/banner.png',
  ];

  final List<_Category> _categories = const [
    _Category(
      'All',
      'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=200&q=80',
    ),
    _Category(
      'Sneakers',
      'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=200&q=80',
    ),
    _Category(
      'Sports',
      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=200&q=80',
    ),
    _Category(
      'Formal',
      'https://images.unsplash.com/photo-1614252369475-531eba835eb1?w=200&q=80',
    ),
    _Category(
      'Casual',
      'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=200&q=80',
    ),
    _Category(
      'Lifestyle',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpzrPNErvKgvwLVcSh4P0gz2ELJNe-9pU9nd6L2VHiRmxegENVZ15hSpcq&s=10',
    ),
  ];

  // Map keys now align with category indexes (1 = Sneakers, 2 = Sports, etc.)
  final Map<int, List<_Product>> _productsByCategory = const {
    1: [
      // Sneakers
      _Product(
        id: 'snk_1',
        name: 'Running Shoes',
        price: 145,
        rating: 4.8,
        reviews: 320,
        image:
            'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=500&q=80',
      ),
      _Product(
        id: 'snk_2',
        name: 'Classic Sneakers',
        price: 99,
        rating: 4.7,
        reviews: 210,
        image:
            'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=500&q=80',
      ),
    ],
    2: [
      // Sports
      _Product(
        id: 'spt_1',
        name: 'Sports Footwear Pro',
        price: 120,
        rating: 4.9,
        reviews: 450,
        image:
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&q=80',
      ),
      _Product(
        id: 'spt_2',
        name: 'Trail Runners',
        price: 135,
        rating: 4.6,
        reviews: 180,
        image:
            'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=500&q=80',
      ),
    ],
    3: [
      // Formal
      _Product(
        id: 'frm_1',
        name: 'Classic Leather Derby',
        price: 180,
        rating: 4.8,
        reviews: 95,
        image:
            'https://images.unsplash.com/photo-1614252369475-531eba835eb1?w=500&q=80',
      ),
    ],
    4: [
      // Casual
      _Product(
        id: 'csl_1',
        name: 'Street Style Casuals',
        price: 110,
        rating: 4.9,
        reviews: 275,
        image:
            'https://images.unsplash.com/photo-1552346154-21d32810aba3?w=500&q=80',
      ),
      _Product(
        id: 'csl_2',
        name: 'Retro Canvas',
        price: 85,
        rating: 4.5,
        reviews: 140,
        image:
            'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=500&q=80',
      ),
    ],
    5: [
      // Lifestyle
      _Product(
        id: 'lfs_1',
        name: 'Urban Comfort',
        price: 130,
        rating: 4.7,
        reviews: 190,
        image:
            'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=500&q=80',
      ),
    ],
  };

  // Ad banners now use network images instead of local assets.
  final List<_AdBanner> _adBanners = const [
    _AdBanner(
      image:
          'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=400&q=80',
      title: 'BLACK FRIDAY\nSALE -50%',
      subtitle: 'On all sneakers this week',
      buttonText: 'Shop Now',
      background: Color(0xFFE8432F),
    ),
    _AdBanner(
      image:
          'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=400&q=80',
      title: 'NEW ARRIVALS\nUP TO 30% OFF',
      subtitle: 'Fresh kicks just dropped',
      buttonText: 'Shop Now',
      background: Color(0xFF1F2937),
    ),
    _AdBanner(
      image:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&q=80',
      title: 'FREE SHIPPING\nON ORDERS \$99+',
      subtitle: 'Limited time offer',
      buttonText: 'Shop Now',
      background: Color(0xFFFF5A1F),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startBannerAutoScroll();
  }

  void _startBannerAutoScroll() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_bannerController.hasClients) return;
      final nextPage = (_bannerIndex + 1) % _banners.length;
      _bannerController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bannerController.dispose();
    _bannerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Logic: If index is 0 ('All'), gather and flatten all map lists into one big list
    final currentProducts = _selectedCategory == 0
        ? _productsByCategory.values.expand((list) => list).toList()
        : _productsByCategory[_selectedCategory] ?? const [];

    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollStartNotification &&
                notification.metrics.axis == Axis.horizontal) {
              _bannerTimer?.cancel();
            } else if (notification is ScrollEndNotification &&
                notification.metrics.axis == Axis.horizontal) {
              _bannerTimer?.cancel();
              _startBannerAutoScroll();
            }
            return false;
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(child: _buildBanner()),
              SliverToBoxAdapter(child: _buildSectionTitle()),
              SliverToBoxAdapter(child: _buildCategories()),
              SliverToBoxAdapter(child: _buildProductsHeader()),
              ..._buildProductSlivers(currentProducts),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=100&q=80',
              width: 44,
              height: 44,
              fit: BoxFit.cover,
              loadingBuilder: (c, child, progress) =>
                  progress == null ? child : const _AvatarPlaceholder(),
              errorBuilder: (c, e, s) => const _AvatarPlaceholder(),
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                'Melvin Cherian',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const Spacer(),
          // Search icon now sits to the left of the wishlist icon,
          // replacing the old dedicated search bar.
          const _IconBubble(icon: Icons.search),
          const SizedBox(width: 8),
          const _IconBubble(icon: Icons.favorite_border),
          const SizedBox(width: 8),
          const _IconBubble(icon: Icons.shopping_bag_outlined, badge: '2'),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: PageView.builder(
              controller: _bannerController,
              itemCount: _banners.length,
              onPageChanged: (i) => setState(() => _bannerIndex = i),
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _bannerController,
                  builder: (context, child) {
                    double scale = 1.0;
                    if (_bannerController.position.haveDimensions) {
                      double page =
                          _bannerController.page ?? _bannerIndex.toDouble();
                      double diff = (page - index).abs();
                      scale = (1 - (diff * 0.08)).clamp(0.9, 1.0);
                    }
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(_banners[index], fit: BoxFit.cover),
                        Container(decoration: const BoxDecoration()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_banners.length, (i) {
              final active = i == _bannerIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: active ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: active ? kPrimaryOrange : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 18, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shop By Category',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 3),
          Text(
            'Enhance your shopping experience by accurate\ncategory browsing feature',
            style: TextStyle(fontSize: 11.5, color: Colors.grey, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 92,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final selected = index == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = index),
            child: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutBack,
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected ? kPrimaryOrange : Colors.transparent,
                        width: 2,
                      ),
                      color: kCardGrey,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        cat.image,
                        fit: BoxFit.cover,
                        loadingBuilder: (c, child, progress) => progress == null
                            ? child
                            : Container(color: kCardGrey),
                        errorBuilder: (c, e, s) =>
                            const Icon(Icons.image_not_supported, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                      color: selected ? Colors.black : Colors.grey,
                    ),
                    child: Text(cat.label),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Popular Shoes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListAllProduct()),
              );
            },
            child: const Text(
              'See All',
              style: TextStyle(
                fontSize: 12.5,
                color: kPrimaryOrange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the product grid as a series of slivers, inserting an
  /// auto-scrolling ad banner after every group of 4 product cards.
  List<Widget> _buildProductSlivers(List<_Product> products) {
    final List<Widget> slivers = [];
    int i = 0;
    int adSeed = 0;

    while (i < products.length) {
      final chunk = products.skip(i).take(4).toList();

      slivers.add(
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16, i == 0 ? 8 : 0, 16, 8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 14,
              childAspectRatio: 0.66,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final product = chunk[index];
              final globalIndex = i + index;
              return _TiltCard(
                scrollController: _scrollController,
                key: ValueKey(product.id),
                child: _ProductCard(product: product, index: globalIndex),
              );
            }, childCount: chunk.length),
          ),
        ),
      );

      i += chunk.length;

      // Only insert the ad after a *full* group of 4 cards.
      if (chunk.length == 4) {
        slivers.add(
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: _AdBannerCarousel(
                key: ValueKey('grid_ad_$adSeed'),
                ads: _adBanners,
                height: 140,
              ),
            ),
          ),
        );
        adSeed++;
      }
    }

    slivers.add(const SliverToBoxAdapter(child: SizedBox(height: 16)));
    return slivers;
  }
}

class _TiltCard extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;

  const _TiltCard({
    super.key,
    required this.child,
    required this.scrollController,
  });

  @override
  State<_TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<_TiltCard> {
  final GlobalKey _key = GlobalKey();
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateProgress);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateProgress());
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateProgress);
    super.dispose();
  }

  void _updateProgress() {
    if (!mounted) return;
    final ctx = _key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;

    final screenHeight = MediaQuery.of(context).size.height;
    final position = box.localToGlobal(Offset.zero);
    final cardCenterY = position.dy + box.size.height / 2;
    final viewportCenterY = screenHeight / 2;

    double p = (cardCenterY - viewportCenterY) / (screenHeight / 2);
    p = p.clamp(-1.0, 1.0);

    if ((p - _progress).abs() > 0.01) {
      setState(() => _progress = p);
    }
  }

  @override
  Widget build(BuildContext context) {
    final angle = _progress * 0.35;
    final scale = 1 - (_progress.abs() * 0.12);
    final opacity = (1 - _progress.abs() * 0.35).clamp(0.5, 1.0);

    return KeyedSubtree(
      key: _key,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0012)
          ..rotateX(angle)
          ..scale(scale, scale),
        child: Opacity(opacity: opacity, child: widget.child),
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final _Product product;
  final int index;
  const _ProductCard({required this.product, required this.index});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<double> _entranceAnim;

  late final AnimationController _giggleController;
  late final Animation<double> _giggleAnim;

  late final AnimationController _favController;
  bool _favSelected = false;

  late final AnimationController _cartController;
  bool _addedToCart = false;

  Timer? _giggleTimer;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _entranceAnim = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutBack,
    );
    Future.delayed(Duration(milliseconds: 80 * (widget.index % 6)), () {
      if (mounted) _entranceController.forward();
    });

    _giggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _giggleAnim =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.06), weight: 1),
          TweenSequenceItem(tween: Tween(begin: -0.06, end: 0.06), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 0.06, end: -0.04), weight: 2),
          TweenSequenceItem(tween: Tween(begin: -0.04, end: 0.0), weight: 1),
        ]).animate(
          CurvedAnimation(parent: _giggleController, curve: Curves.easeInOut),
        );

    Future.delayed(Duration(milliseconds: 400 + 300 * widget.index), () {
      if (!mounted) return;
      _giggleController.forward(from: 0);
      _giggleTimer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (mounted) _giggleController.forward(from: 0);
      });
    });

    _favController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.8,
      upperBound: 1.0,
      value: 1.0,
    );

    _cartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _giggleController.dispose();
    _favController.dispose();
    _cartController.dispose();
    _giggleTimer?.cancel();
    super.dispose();
  }

  void _toggleFav() {
    setState(() => _favSelected = !_favSelected);
    _favController.value = 0.8;
    _favController.animateTo(
      1.0,
      curve: Curves.elasticOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _handleAddToCart() {
    setState(() => _addedToCart = true);
    _cartController.forward(from: 0).then((_) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 900), () {
          if (mounted) setState(() => _addedToCart = false);
        });
      }
    });
  }

  void _openProductDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ProductDetailScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return ScaleTransition(
      scale: _entranceAnim,
      child: FadeTransition(
        opacity: _entranceAnim,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              _giggleController.forward(from: 0);
              _openProductDetail();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _giggleAnim,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _giggleAnim.value,
                              child: child,
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              color: kCardGrey,
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.network(
                                product.image,
                                fit: BoxFit.cover,
                                loadingBuilder: (c, child, progress) =>
                                    progress == null
                                    ? child
                                    : const Center(
                                        child: SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ),
                                errorBuilder: (c, e, s) => const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: _toggleFav,
                            child: ScaleTransition(
                              scale: _favController,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _favSelected
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 15,
                                  color: _favSelected
                                      ? kPrimaryOrange
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 13, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        '${product.rating}',
                        style: const TextStyle(fontSize: 11.5),
                      ),
                      Text(
                        ' (${product.reviews})',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: AnimatedBuilder(
                      animation: _cartController,
                      builder: (context, child) {
                        final bump =
                            1 +
                            (math.sin(_cartController.value * math.pi) * 0.08);
                        return Transform.scale(scale: bump, child: child);
                      },
                      child: ElevatedButton(
                        onPressed: _handleAddToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _addedToCart
                              ? Colors.green
                              : Colors.black,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          elevation: 0,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _addedToCart
                              ? const Row(
                                  key: ValueKey('added'),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.check, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      'Added',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                )
                              : const Text(
                                  'Add to Cart',
                                  key: ValueKey('add'),
                                  style: TextStyle(fontSize: 12),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconBubble extends StatelessWidget {
  final IconData icon;
  final String? badge;
  const _IconBubble({required this.icon, this.badge});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 19, color: Colors.black87),
        ),
        if (badge != null)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: kPrimaryOrange,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                badge!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 9),
              ),
            ),
          ),
      ],
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(color: kCardGrey, shape: BoxShape.circle),
      child: const Icon(Icons.person, color: Colors.grey),
    );
  }
}

class _AdBanner {
  final String image;
  final String title;
  final String subtitle;
  final String buttonText;
  final Color background;
  const _AdBanner({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.background,
  });
}

class _AdBannerCarousel extends StatefulWidget {
  final List<_AdBanner> ads;
  final double height;
  const _AdBannerCarousel({super.key, required this.ads, this.height = 150});

  @override
  State<_AdBannerCarousel> createState() => _AdBannerCarouselState();
}

class _AdBannerCarouselState extends State<_AdBannerCarousel> {
  late final PageController _controller;
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    if (widget.ads.length <= 1) return;
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_controller.hasClients) return;
      final nextPage = (_index + 1) % widget.ads.length;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                _timer?.cancel();
              } else if (notification is ScrollEndNotification) {
                _startAutoScroll();
              }
              return true;
            },
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.ads.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    double scale = 1.0;
                    if (_controller.position.haveDimensions) {
                      double page = _controller.page ?? _index.toDouble();
                      double diff = (page - index).abs();
                      scale = (1 - (diff * 0.08)).clamp(0.9, 1.0);
                    }
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: _AdBannerCard(ad: widget.ads[index]),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.ads.length, (i) {
            final active = i == _index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: active ? kPrimaryOrange : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _AdBannerCard extends StatelessWidget {
  final _AdBanner ad;
  const _AdBannerCard({required this.ad});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: ad.background,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              right: -10,
              bottom: -10,
              width: 170,
              child: Image.network(
                ad.image,
                fit: BoxFit.contain,
                loadingBuilder: (c, child, progress) =>
                    progress == null ? child : const SizedBox(),
                errorBuilder: (c, e, s) => const SizedBox(),
              ),
            ),
            Positioned(
              left: 20,
              top: 20,
              right: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ad.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  if (ad.subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      ad.subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      ad.buttonText,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
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

class _Category {
  final String label;
  final String image;
  const _Category(this.label, this.image);
}

class _Product {
  final String id;
  final String name;
  final int price;
  final double rating;
  final int reviews;
  final String image;
  const _Product({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.image,
  });
}
