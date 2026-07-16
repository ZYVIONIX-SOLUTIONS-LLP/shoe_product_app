// import 'dart:async';
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:shoe_product/views/cart/cart_screen.dart';
// import 'package:shoe_product/views/detail/list_all_product.dart';
// import 'package:shoe_product/views/detail/product_detail_screen.dart';
// import 'package:shoe_product/views/widgets/cart_widget.dart';
// import 'package:shoe_product/views/widgets/wishlist_widget.dart';
// import 'package:shoe_product/views/wishlist/wishlist_screen.dart';

// const Color kPrimaryOrange = Color(0xFFFF5A1F);
// const Color kBackground = Color(0xFFF7F7FA);
// const Color kCardGrey = Color(0xFFF1F2F6);

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ScrollController _scrollController = ScrollController();
//   final PageController _bannerController = PageController();
//   int _bannerIndex = 0;
//   int _selectedCategory = 0;
//   Timer? _bannerTimer;

//   final List<String> _banners = const [
//     'assets/banner.png',
//     'assets/bannerimage.png',
//     'assets/banner.png',
//   ];

//   final List<_Category> _categories = const [
//     _Category(
//       'All',
//       'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=200&q=80',
//     ),
//     _Category(
//       'Sneakers',
//       'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=200&q=80',
//     ),
//     _Category(
//       'Sports',
//       'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=200&q=80',
//     ),
//     _Category(
//       'Formal',
//       'https://images.unsplash.com/photo-1614252369475-531eba835eb1?w=200&q=80',
//     ),
//     _Category(
//       'Casual',
//       'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=200&q=80',
//     ),
//     _Category(
//       'Lifestyle',
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpzrPNErvKgvwLVcSh4P0gz2ELJNe-9pU9nd6L2VHiRmxegENVZ15hSpcq&s=10',
//     ),
//   ];

//   final Map<int, List<_Product>> _productsByCategory = const {
//     1: [
//       // Sneakers
//       _Product(
//         id: 'snk_1',
//         name: 'Running Shoes',
//         price: 145,
//         rating: 4.8,
//         reviews: 320,
//         image:
//             'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=500&q=80',
//       ),
//       _Product(
//         id: 'snk_2',
//         name: 'Classic Sneakers',
//         price: 99,
//         rating: 4.7,
//         reviews: 210,
//         image:
//             'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=500&q=80',
//       ),
//     ],
//     2: [
//       // Sports
//       _Product(
//         id: 'spt_1',
//         name: 'Sports Footwear Pro',
//         price: 120,
//         rating: 4.9,
//         reviews: 450,
//         image:
//             'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&q=80',
//       ),
//       _Product(
//         id: 'spt_2',
//         name: 'Trail Runners',
//         price: 135,
//         rating: 4.6,
//         reviews: 180,
//         image:
//             'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=500&q=80',
//       ),
//     ],
//     3: [
//       // Formal
//       _Product(
//         id: 'frm_1',
//         name: 'Classic Leather Derby',
//         price: 180,
//         rating: 4.8,
//         reviews: 95,
//         image:
//             'https://images.unsplash.com/photo-1614252369475-531eba835eb1?w=500&q=80',
//       ),
//     ],
//     4: [
//       // Casual
//       _Product(
//         id: 'csl_1',
//         name: 'Street Style Casuals',
//         price: 110,
//         rating: 4.9,
//         reviews: 275,
//         image:
//             'https://images.unsplash.com/photo-1552346154-21d32810aba3?w=500&q=80',
//       ),
//       _Product(
//         id: 'csl_2',
//         name: 'Retro Canvas',
//         price: 85,
//         rating: 4.5,
//         reviews: 140,
//         image:
//             'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=500&q=80',
//       ),
//     ],
//     5: [
//       // Lifestyle
//       _Product(
//         id: 'lfs_1',
//         name: 'Urban Comfort',
//         price: 130,
//         rating: 4.7,
//         reviews: 190,
//         image:
//             'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=500&q=80',
//       ),
//     ],
//   };

//   // Ad banners now use network images instead of local assets.
//   final List<_AdBanner> _adBanners = const [
//     _AdBanner(
//       image:
//           'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=400&q=80',
//       title: 'BLACK FRIDAY\nSALE -50%',
//       subtitle: 'On all sneakers this week',
//       buttonText: 'Shop Now',
//       background: Color(0xFFE8432F),
//     ),
//     _AdBanner(
//       image:
//           'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=400&q=80',
//       title: 'NEW ARRIVALS\nUP TO 30% OFF',
//       subtitle: 'Fresh kicks just dropped',
//       buttonText: 'Shop Now',
//       background: Color(0xFF1F2937),
//     ),
//     _AdBanner(
//       image:
//           'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&q=80',
//       title: 'FREE SHIPPING\nON ORDERS \$99+',
//       subtitle: 'Limited time offer',
//       buttonText: 'Shop Now',
//       background: Color(0xFFFF5A1F),
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _startBannerAutoScroll();
//   }

//   void _startBannerAutoScroll() {
//     _bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (!_bannerController.hasClients) return;
//       final nextPage = (_bannerIndex + 1) % _banners.length;
//       _bannerController.animateToPage(
//         nextPage,
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeInOutCubic,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _bannerController.dispose();
//     _bannerTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentProducts = _selectedCategory == 0
//         ? _productsByCategory.values.expand((list) => list).toList()
//         : _productsByCategory[_selectedCategory] ?? const [];

//     return Scaffold(
//       backgroundColor: kBackground,
//       body: SafeArea(
//         child: NotificationListener<ScrollNotification>(
//           onNotification: (notification) {
//             if (notification is ScrollStartNotification &&
//                 notification.metrics.axis == Axis.horizontal) {
//               _bannerTimer?.cancel();
//             } else if (notification is ScrollEndNotification &&
//                 notification.metrics.axis == Axis.horizontal) {
//               _bannerTimer?.cancel();
//               _startBannerAutoScroll();
//             }
//             return false;
//           },
//           child: CustomScrollView(
//             controller: _scrollController,
//             slivers: [
//               SliverToBoxAdapter(child: _buildHeader()),
//               SliverToBoxAdapter(child: _buildBanner()),
//               SliverToBoxAdapter(child: _buildSectionTitle()),
//               SliverToBoxAdapter(child: _buildCategories()),
//               SliverToBoxAdapter(child: _buildProductsHeader()),
//               ..._buildProductSlivers(currentProducts),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
//       child: Row(
//         children: [
//           ClipOval(
//             child: Image.network(
//               'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=100&q=80',
//               width: 44,
//               height: 44,
//               fit: BoxFit.cover,
//               loadingBuilder: (c, child, progress) =>
//                   progress == null ? child : const _AvatarPlaceholder(),
//               errorBuilder: (c, e, s) => const _AvatarPlaceholder(),
//             ),
//           ),
//           const SizedBox(width: 10),
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Welcome Back!',
//                 style: TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//               Text(
//                 'Melvin Cherian',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//               ),
//             ],
//           ),
//           const Spacer(),
//           const _IconBubble(icon: Icons.search),
//           const SizedBox(width: 8),
//           AnimatedBuilder(
//             animation: WishlistManager.instance,
//             builder: (context, _) {
//               final count = WishlistManager.instance.itemCount;
//               return _IconBubble(
//                 icon: Icons.favorite_border,
//                 badge: count > 0 ? '$count' : null,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const WishlistScreen(),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           const SizedBox(width: 8),
//           AnimatedBuilder(
//             animation: CartManager.instance,
//             builder: (context, _) {
//               final count = CartManager.instance.itemCount;
//               return _IconBubble(
//                 icon: Icons.shopping_bag_outlined,
//                 badge: count > 0 ? '$count' : null,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const CartScreen()),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBanner() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 150,
//             child: PageView.builder(
//               controller: _bannerController,
//               itemCount: _banners.length,
//               onPageChanged: (i) => setState(() => _bannerIndex = i),
//               itemBuilder: (context, index) {
//                 return AnimatedBuilder(
//                   animation: _bannerController,
//                   builder: (context, child) {
//                     double scale = 1.0;
//                     if (_bannerController.position.haveDimensions) {
//                       double page =
//                           _bannerController.page ?? _bannerIndex.toDouble();
//                       double diff = (page - index).abs();
//                       scale = (1 - (diff * 0.08)).clamp(0.9, 1.0);
//                     }
//                     return Transform.scale(scale: scale, child: child);
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Image.asset(_banners[index], fit: BoxFit.cover),
//                         Container(decoration: const BoxDecoration()),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(_banners.length, (i) {
//               final active = i == _bannerIndex;
//               return AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeOut,
//                 margin: const EdgeInsets.symmetric(horizontal: 3),
//                 width: active ? 18 : 6,
//                 height: 6,
//                 decoration: BoxDecoration(
//                   color: active ? kPrimaryOrange : Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionTitle() {
//     return const Padding(
//       padding: EdgeInsets.fromLTRB(16, 18, 16, 4),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Shop By Category',
//             style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
//           ),
//           SizedBox(height: 3),
//           Text(
//             'Enhance your shopping experience by accurate\ncategory browsing feature',
//             style: TextStyle(fontSize: 11.5, color: Colors.grey, height: 1.3),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategories() {
//     return SizedBox(
//       height: 92,
//       child: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         scrollDirection: Axis.horizontal,
//         itemCount: _categories.length,
//         itemBuilder: (context, index) {
//           final cat = _categories[index];
//           final selected = index == _selectedCategory;
//           return GestureDetector(
//             onTap: () => setState(() => _selectedCategory = index),
//             child: Padding(
//               padding: const EdgeInsets.only(right: 14),
//               child: Column(
//                 children: [
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 250),
//                     curve: Curves.easeOutBack,
//                     width: 60,
//                     height: 60,
//                     padding: const EdgeInsets.all(3),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: selected ? kPrimaryOrange : Colors.transparent,
//                         width: 2,
//                       ),
//                       color: kCardGrey,
//                     ),
//                     child: ClipOval(
//                       child: Image.network(
//                         cat.image,
//                         fit: BoxFit.cover,
//                         loadingBuilder: (c, child, progress) => progress == null
//                             ? child
//                             : Container(color: kCardGrey),
//                         errorBuilder: (c, e, s) =>
//                             const Icon(Icons.image_not_supported, size: 20),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   AnimatedDefaultTextStyle(
//                     duration: const Duration(milliseconds: 200),
//                     style: TextStyle(
//                       fontSize: 11.5,
//                       fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
//                       color: selected ? Colors.black : Colors.grey,
//                     ),
//                     child: Text(cat.label),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProductsHeader() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             'Popular Shoes',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ListAllProduct()),
//               );
//             },
//             child: const Text(
//               'See All',
//               style: TextStyle(
//                 fontSize: 12.5,
//                 color: kPrimaryOrange,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildProductSlivers(List<_Product> products) {
//     final List<Widget> slivers = [];
//     int i = 0;
//     int adSeed = 0;

//     while (i < products.length) {
//       final chunk = products.skip(i).take(4).toList();

//       slivers.add(
//         SliverPadding(
//           padding: EdgeInsets.fromLTRB(16, i == 0 ? 8 : 0, 16, 8),
//           sliver: SliverGrid(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 16,
//               crossAxisSpacing: 14,
//               childAspectRatio: 0.66,
//             ),
//             delegate: SliverChildBuilderDelegate((context, index) {
//               final product = chunk[index];
//               final globalIndex = i + index;
//               return _TiltCard(
//                 scrollController: _scrollController,
//                 key: ValueKey(product.id),
//                 child: _ProductCard(product: product, index: globalIndex),
//               );
//             }, childCount: chunk.length),
//           ),
//         ),
//       );

//       i += chunk.length;

//       if (chunk.length == 4) {
//         slivers.add(
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//               child: _AdBannerCarousel(
//                 key: ValueKey('grid_ad_$adSeed'),
//                 ads: _adBanners,
//                 height: 140,
//               ),
//             ),
//           ),
//         );
//         adSeed++;
//       }
//     }

//     slivers.add(const SliverToBoxAdapter(child: SizedBox(height: 16)));
//     return slivers;
//   }
// }

// class _TiltCard extends StatefulWidget {
//   final Widget child;
//   final ScrollController scrollController;

//   const _TiltCard({
//     super.key,
//     required this.child,
//     required this.scrollController,
//   });

//   @override
//   State<_TiltCard> createState() => _TiltCardState();
// }

// class _TiltCardState extends State<_TiltCard> {
//   final GlobalKey _key = GlobalKey();
//   double _progress = 0;

//   @override
//   void initState() {
//     super.initState();
//     widget.scrollController.addListener(_updateProgress);
//     WidgetsBinding.instance.addPostFrameCallback((_) => _updateProgress());
//   }

//   @override
//   void dispose() {
//     widget.scrollController.removeListener(_updateProgress);
//     super.dispose();
//   }

//   void _updateProgress() {
//     if (!mounted) return;
//     final ctx = _key.currentContext;
//     if (ctx == null) return;
//     final box = ctx.findRenderObject() as RenderBox?;
//     if (box == null || !box.attached) return;

//     final screenHeight = MediaQuery.of(context).size.height;
//     final position = box.localToGlobal(Offset.zero);
//     final cardCenterY = position.dy + box.size.height / 2;
//     final viewportCenterY = screenHeight / 2;

//     double p = (cardCenterY - viewportCenterY) / (screenHeight / 2);
//     p = p.clamp(-1.0, 1.0);

//     if ((p - _progress).abs() > 0.01) {
//       setState(() => _progress = p);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final angle = _progress * 0.35;
//     final scale = 1 - (_progress.abs() * 0.12);
//     final opacity = (1 - _progress.abs() * 0.35).clamp(0.5, 1.0);

//     return KeyedSubtree(
//       key: _key,
//       child: Transform(
//         alignment: Alignment.center,
//         transform: Matrix4.identity()
//           ..setEntry(3, 2, 0.0012)
//           ..rotateX(angle)
//           ..scale(scale, scale),
//         child: Opacity(opacity: opacity, child: widget.child),
//       ),
//     );
//   }
// }

// class _ProductCard extends StatefulWidget {
//   final _Product product;
//   final int index;
//   const _ProductCard({required this.product, required this.index});

//   @override
//   State<_ProductCard> createState() => _ProductCardState();
// }

// class _ProductCardState extends State<_ProductCard>
//     with TickerProviderStateMixin {
//   late final AnimationController _entranceController;
//   late final Animation<double> _entranceAnim;

//   late final AnimationController _giggleController;
//   late final Animation<double> _giggleAnim;

//   late final AnimationController _favController;
//   bool _favSelected = false;

//   late final AnimationController _cartController;
//   bool _addedToCart = false;

//   Timer? _giggleTimer;

//   @override
//   void initState() {
//     super.initState();

//     _entranceController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _entranceAnim = CurvedAnimation(
//       parent: _entranceController,
//       curve: Curves.easeOutBack,
//     );
//     Future.delayed(Duration(milliseconds: 80 * (widget.index % 6)), () {
//       if (mounted) _entranceController.forward();
//     });

//     _giggleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//     _giggleAnim =
//         TweenSequence<double>([
//           TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.06), weight: 1),
//           TweenSequenceItem(tween: Tween(begin: -0.06, end: 0.06), weight: 2),
//           TweenSequenceItem(tween: Tween(begin: 0.06, end: -0.04), weight: 2),
//           TweenSequenceItem(tween: Tween(begin: -0.04, end: 0.0), weight: 1),
//         ]).animate(
//           CurvedAnimation(parent: _giggleController, curve: Curves.easeInOut),
//         );

//     Future.delayed(Duration(milliseconds: 400 + 300 * widget.index), () {
//       if (!mounted) return;
//       _giggleController.forward(from: 0);
//       _giggleTimer = Timer.periodic(const Duration(seconds: 5), (_) {
//         if (mounted) _giggleController.forward(from: 0);
//       });
//     });

//     _favController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//       lowerBound: 0.8,
//       upperBound: 1.0,
//       value: 1.0,
//     );
//     _favSelected = WishlistManager.instance.isFavorite(widget.product.id);
//     WishlistManager.instance.addListener(_syncFavWithWishlist);

//     _cartController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 250),
//     );
//   }

//   @override
//   void dispose() {
//     _entranceController.dispose();
//     _giggleController.dispose();
//     _favController.dispose();
//     _cartController.dispose();
//     _giggleTimer?.cancel();
//     WishlistManager.instance.removeListener(_syncFavWithWishlist);
//     super.dispose();
//   }

//   void _syncFavWithWishlist() {
//     final isFav = WishlistManager.instance.isFavorite(widget.product.id);
//     if (isFav != _favSelected && mounted) {
//       setState(() => _favSelected = isFav);
//     }
//   }

//   void _toggleFav() {
//     final product = widget.product;
//     WishlistManager.instance.toggle(
//       WishlistItem(
//         id: product.id,
//         name: product.name,
//         price: product.price.toDouble(),
//         image: product.image,
//         rating: product.rating,
//         reviews: product.reviews,
//         subtitle: 'Premium Footwear',
//         bgColor: kCardGrey,
//       ),
//     );
//     _favController.value = 0.8;
//     _favController.animateTo(
//       1.0,
//       curve: Curves.elasticOut,
//       duration: const Duration(milliseconds: 500),
//     );
//   }

//   void _handleAddToCart() {
//     if (_addedToCart) return;
//     setState(() => _addedToCart = true);
//     _cartController.forward(from: 0);

//     final product = widget.product;
//     CartManager.instance.addItem(
//       CartItem(
//         id: product.id,
//         name: product.name,
//         price: product.price.toDouble(),
//         image: product.image,
//         subtitle: 'Premium Footwear',
//         bgColor: kCardGrey,
//       ),
//     );

//     _showAddedToCartSnackBar();
//   }

//   void _showAddedToCartSnackBar() {
//     final messenger = ScaffoldMessenger.of(context);
//     messenger.hideCurrentSnackBar();
//     messenger.showSnackBar(
//       SnackBar(
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: const Color(0xFF1F2937),
//         elevation: 6,
//         margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         duration: const Duration(seconds: 2),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         content: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(6),
//               decoration: const BoxDecoration(
//                 color: kPrimaryOrange,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.check, size: 14, color: Colors.white),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     'Added to cart',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 13.5,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     widget.product.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.75),
//                       fontSize: 11.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         action: SnackBarAction(
//           label: 'VIEW CART',
//           textColor: kPrimaryOrange,
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => CartScreen()),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   void _openProductDetail() {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (context) => const ProductDetailScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final product = widget.product;

//     return ScaleTransition(
//       scale: _entranceAnim,
//       child: FadeTransition(
//         opacity: _entranceAnim,
//         child: Material(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           clipBehavior: Clip.antiAlias,
//           child: InkWell(
//             onTap: () {
//               _giggleController.forward(from: 0);
//               _openProductDetail();
//             },
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Stack(
//                       children: [
//                         AnimatedBuilder(
//                           animation: _giggleAnim,
//                           builder: (context, child) {
//                             return Transform.rotate(
//                               angle: _giggleAnim.value,
//                               child: child,
//                             );
//                           },
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(14),
//                             child: Container(
//                               color: kCardGrey,
//                               width: double.infinity,
//                               height: double.infinity,
//                               child: Image.network(
//                                 product.image,
//                                 fit: BoxFit.cover,
//                                 loadingBuilder: (c, child, progress) =>
//                                     progress == null
//                                     ? child
//                                     : const Center(
//                                         child: SizedBox(
//                                           width: 22,
//                                           height: 22,
//                                           child: CircularProgressIndicator(
//                                             strokeWidth: 2,
//                                           ),
//                                         ),
//                                       ),
//                                 errorBuilder: (c, e, s) => const Icon(
//                                   Icons.image_not_supported,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 6,
//                           right: 6,
//                           child: GestureDetector(
//                             onTap: _toggleFav,
//                             child: ScaleTransition(
//                               scale: _favController,
//                               child: Container(
//                                 padding: const EdgeInsets.all(6),
//                                 decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(
//                                   _favSelected
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   size: 15,
//                                   color: _favSelected
//                                       ? kPrimaryOrange
//                                       : Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     product.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 3),
//                   Row(
//                     children: [
//                       const Icon(Icons.star, size: 13, color: Colors.amber),
//                       const SizedBox(width: 2),
//                       Text(
//                         '${product.rating}',
//                         style: const TextStyle(fontSize: 11.5),
//                       ),
//                       Text(
//                         ' (${product.reviews})',
//                         style: const TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '\$${product.price}',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 32,
//                     child: AnimatedBuilder(
//                       animation: _cartController,
//                       builder: (context, child) {
//                         final bump =
//                             1 +
//                             (math.sin(_cartController.value * math.pi) * 0.08);
//                         return Transform.scale(scale: bump, child: child);
//                       },
//                       child: ElevatedButton(
//                         onPressed: _addedToCart ? null : _handleAddToCart,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _addedToCart
//                               ? Colors.green
//                               : Colors.black,
//                           disabledBackgroundColor: Colors.green,
//                           foregroundColor: Colors.white,
//                           disabledForegroundColor: Colors.white,
//                           padding: EdgeInsets.zero,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(9),
//                           ),
//                           elevation: 0,
//                         ),
//                         child: AnimatedSwitcher(
//                           duration: const Duration(milliseconds: 200),
//                           child: _addedToCart
//                               ? const Row(
//                                   key: ValueKey('added'),
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(Icons.check, size: 14),
//                                     SizedBox(width: 4),
//                                     Text(
//                                       'Added',
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                   ],
//                                 )
//                               : const Text(
//                                   'Add to Cart',
//                                   key: ValueKey('add'),
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _IconBubble extends StatelessWidget {
//   final IconData icon;
//   final String? badge;
//   final VoidCallback? onTap;
//   const _IconBubble({required this.icon, this.badge, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 6,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Icon(icon, size: 19, color: Colors.black87),
//           ),
//           if (badge != null)
//             Positioned(
//               top: -2,
//               right: -2,
//               child: Container(
//                 padding: const EdgeInsets.all(3),
//                 decoration: const BoxDecoration(
//                   color: kPrimaryOrange,
//                   shape: BoxShape.circle,
//                 ),
//                 constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
//                 child: Text(
//                   badge!,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.white, fontSize: 9),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _AvatarPlaceholder extends StatelessWidget {
//   const _AvatarPlaceholder();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 44,
//       height: 44,
//       decoration: const BoxDecoration(color: kCardGrey, shape: BoxShape.circle),
//       child: const Icon(Icons.person, color: Colors.grey),
//     );
//   }
// }

// class _AdBanner {
//   final String image;
//   final String title;
//   final String subtitle;
//   final String buttonText;
//   final Color background;
//   const _AdBanner({
//     required this.image,
//     required this.title,
//     required this.subtitle,
//     required this.buttonText,
//     required this.background,
//   });
// }

// class _AdBannerCarousel extends StatefulWidget {
//   final List<_AdBanner> ads;
//   final double height;
//   const _AdBannerCarousel({super.key, required this.ads, this.height = 150});

//   @override
//   State<_AdBannerCarousel> createState() => _AdBannerCarouselState();
// }

// class _AdBannerCarouselState extends State<_AdBannerCarousel> {
//   late final PageController _controller;
//   int _index = 0;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _controller = PageController();
//     _startAutoScroll();
//   }

//   void _startAutoScroll() {
//     _timer?.cancel();
//     if (widget.ads.length <= 1) return;
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (!_controller.hasClients) return;
//       final nextPage = (_index + 1) % widget.ads.length;
//       _controller.animateToPage(
//         nextPage,
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeInOutCubic,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: widget.height,
//           child: NotificationListener<ScrollNotification>(
//             onNotification: (notification) {
//               if (notification is ScrollStartNotification) {
//                 _timer?.cancel();
//               } else if (notification is ScrollEndNotification) {
//                 _startAutoScroll();
//               }
//               return true;
//             },
//             child: PageView.builder(
//               controller: _controller,
//               itemCount: widget.ads.length,
//               onPageChanged: (i) => setState(() => _index = i),
//               itemBuilder: (context, index) {
//                 return AnimatedBuilder(
//                   animation: _controller,
//                   builder: (context, child) {
//                     double scale = 1.0;
//                     if (_controller.position.haveDimensions) {
//                       double page = _controller.page ?? _index.toDouble();
//                       double diff = (page - index).abs();
//                       scale = (1 - (diff * 0.08)).clamp(0.9, 1.0);
//                     }
//                     return Transform.scale(scale: scale, child: child);
//                   },
//                   child: _AdBannerCard(ad: widget.ads[index]),
//                 );
//               },
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(widget.ads.length, (i) {
//             final active = i == _index;
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeOut,
//               margin: const EdgeInsets.symmetric(horizontal: 3),
//               width: active ? 18 : 6,
//               height: 6,
//               decoration: BoxDecoration(
//                 color: active ? kPrimaryOrange : Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }

// class _AdBannerCard extends StatelessWidget {
//   final _AdBanner ad;
//   const _AdBannerCard({required this.ad});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: Container(
//         color: ad.background,
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Positioned(
//               right: -10,
//               bottom: -10,
//               width: 170,
//               child: Image.network(
//                 ad.image,
//                 fit: BoxFit.contain,
//                 loadingBuilder: (c, child, progress) =>
//                     progress == null ? child : const SizedBox(),
//                 errorBuilder: (c, e, s) => const SizedBox(),
//               ),
//             ),
//             Positioned(
//               left: 20,
//               top: 20,
//               right: 140,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     ad.title,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w800,
//                       height: 1.2,
//                     ),
//                   ),
//                   if (ad.subtitle.isNotEmpty) ...[
//                     const SizedBox(height: 4),
//                     Text(
//                       ad.subtitle,
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.9),
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                   const SizedBox(height: 12),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 7,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       ad.buttonText,
//                       style: const TextStyle(
//                         fontSize: 11.5,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _Category {
//   final String label;
//   final String image;
//   const _Category(this.label, this.image);
// }

// class _Product {
//   final String id;
//   final String name;
//   final int price;
//   final double rating;
//   final int reviews;
//   final String image;
//   const _Product({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.rating,
//     required this.reviews,
//     required this.image,
//   });
// }

////// Added Filter code////////

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shoe_product/views/cart/cart_screen.dart';
import 'package:shoe_product/views/detail/list_all_product.dart';
import 'package:shoe_product/views/detail/product_detail_screen.dart';
import 'package:shoe_product/views/widgets/cart_widget.dart';
import 'package:shoe_product/views/widgets/wishlist_widget.dart';
import 'package:shoe_product/views/wishlist/wishlist_screen.dart';

const Color kPrimaryOrange = Color(0xFFFF5A1F);
const Color kBackground = Color(0xFFF7F7FA);
const Color kCardGrey = Color(0xFFF1F2F6);

enum _SortOption { popularity, priceLowHigh, priceHighLow, rating }

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

  // ----- Filter state -----
  static const double _minPossiblePrice = 0;
  static const double _maxPossiblePrice = 300;

  RangeValues _priceRange = const RangeValues(
    _minPossiblePrice,
    _maxPossiblePrice,
  );
  double _minRating = 0;
  _SortOption _sortOption = _SortOption.popularity;

  bool get _isFilterActive =>
      _priceRange.start != _minPossiblePrice ||
      _priceRange.end != _maxPossiblePrice ||
      _minRating != 0 ||
      _sortOption != _SortOption.popularity;

  int get _activeFilterCount {
    int count = 0;
    if (_priceRange.start != _minPossiblePrice ||
        _priceRange.end != _maxPossiblePrice) {
      count++;
    }
    if (_minRating != 0) count++;
    if (_sortOption != _SortOption.popularity) count++;
    return count;
  }

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

  // ----- Filtering / sorting helpers -----
  List<_Product> _applyFiltersAndSort(List<_Product> products) {
    var filtered = products.where((p) {
      final withinPrice =
          p.price >= _priceRange.start && p.price <= _priceRange.end;
      final withinRating = p.rating >= _minRating;
      return withinPrice && withinRating;
    }).toList();

    switch (_sortOption) {
      case _SortOption.priceLowHigh:
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case _SortOption.priceHighLow:
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case _SortOption.rating:
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case _SortOption.popularity:
        filtered.sort((a, b) => b.reviews.compareTo(a.reviews));
        break;
    }

    return filtered;
  }

  void _openFilterSheet() {
    // Local temp state so changes only apply when the user taps "Apply".
    RangeValues tempPriceRange = _priceRange;
    double tempMinRating = _minRating;
    _SortOption tempSort = _sortOption;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return _FilterSheet(
              priceRange: tempPriceRange,
              minRating: tempMinRating,
              sortOption: tempSort,
              minPossiblePrice: _minPossiblePrice,
              maxPossiblePrice: _maxPossiblePrice,
              onPriceRangeChanged: (v) =>
                  setSheetState(() => tempPriceRange = v),
              onMinRatingChanged: (v) => setSheetState(() => tempMinRating = v),
              onSortChanged: (v) => setSheetState(() => tempSort = v),
              onReset: () {
                setSheetState(() {
                  tempPriceRange = const RangeValues(
                    _minPossiblePrice,
                    _maxPossiblePrice,
                  );
                  tempMinRating = 0;
                  tempSort = _SortOption.popularity;
                });
              },
              onApply: () {
                setState(() {
                  _priceRange = tempPriceRange;
                  _minRating = tempMinRating;
                  _sortOption = tempSort;
                });
                Navigator.pop(sheetContext);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryProducts = _selectedCategory == 0
        ? _productsByCategory.values.expand((list) => list).toList()
        : _productsByCategory[_selectedCategory] ?? const [];

    final currentProducts = _applyFiltersAndSort(categoryProducts);

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
              if (currentProducts.isEmpty)
                SliverToBoxAdapter(child: _buildEmptyState())
              else
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
          const _IconBubble(icon: Icons.search),
          const SizedBox(width: 8),
          AnimatedBuilder(
            animation: WishlistManager.instance,
            builder: (context, _) {
              final count = WishlistManager.instance.itemCount;
              return _IconBubble(
                icon: Icons.favorite_border,
                badge: count > 0 ? '$count' : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WishlistScreen(),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(width: 8),
          AnimatedBuilder(
            animation: CartManager.instance,
            builder: (context, _) {
              final count = CartManager.instance.itemCount;
              return _IconBubble(
                icon: Icons.shopping_bag_outlined,
                badge: count > 0 ? '$count' : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              );
            },
          ),
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
          Row(
            children: [
              GestureDetector(
                onTap: _openFilterSheet,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _isFilterActive ? kPrimaryOrange : kCardGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.tune,
                        size: 15,
                        color: _isFilterActive ? Colors.white : Colors.black87,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _isFilterActive
                            ? 'Filters ($_activeFilterCount)'
                            : 'Filter',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: _isFilterActive
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListAllProduct(),
                    ),
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
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
      child: Column(
        children: [
          const Icon(Icons.search_off, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          const Text(
            'No shoes match your filters',
            style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Text(
            'Try adjusting the price range or rating',
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              setState(() {
                _priceRange = const RangeValues(
                  _minPossiblePrice,
                  _maxPossiblePrice,
                );
                _minRating = 0;
                _sortOption = _SortOption.popularity;
              });
            },
            child: const Text(
              'Reset Filters',
              style: TextStyle(
                color: kPrimaryOrange,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

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

class _FilterSheet extends StatelessWidget {
  final RangeValues priceRange;
  final double minRating;
  final _SortOption sortOption;
  final double minPossiblePrice;
  final double maxPossiblePrice;
  final ValueChanged<RangeValues> onPriceRangeChanged;
  final ValueChanged<double> onMinRatingChanged;
  final ValueChanged<_SortOption> onSortChanged;
  final VoidCallback onReset;
  final VoidCallback onApply;

  const _FilterSheet({
    required this.priceRange,
    required this.minRating,
    required this.sortOption,
    required this.minPossiblePrice,
    required this.maxPossiblePrice,
    required this.onPriceRangeChanged,
    required this.onMinRatingChanged,
    required this.onSortChanged,
    required this.onReset,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 14,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter & Sort',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: onReset,
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    color: kPrimaryOrange,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Sort By',
            style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSortChip(context, 'Popularity', _SortOption.popularity),
              _buildSortChip(
                context,
                'Price: Low to High',
                _SortOption.priceLowHigh,
              ),
              _buildSortChip(
                context,
                'Price: High to Low',
                _SortOption.priceHighLow,
              ),
              _buildSortChip(context, 'Top Rated', _SortOption.rating),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price Range',
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
              ),
              Text(
                '\$${priceRange.start.round()} - \$${priceRange.end.round()}',
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: kPrimaryOrange,
              inactiveTrackColor: kCardGrey,
              thumbColor: kPrimaryOrange,
              overlayColor: kPrimaryOrange.withOpacity(0.15),
              rangeThumbShape: const RoundRangeSliderThumbShape(
                enabledThumbRadius: 8,
              ),
            ),
            child: RangeSlider(
              min: minPossiblePrice,
              max: maxPossiblePrice,
              divisions: 30,
              values: priceRange,
              labels: RangeLabels(
                '\$${priceRange.start.round()}',
                '\$${priceRange.end.round()}',
              ),
              onChanged: onPriceRangeChanged,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Minimum Rating',
            style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildRatingChip(context, 'All', 0),
              _buildRatingChip(context, '4.0+', 4.0),
              _buildRatingChip(context, '4.5+', 4.5),
              _buildRatingChip(context, '4.8+', 4.8),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onApply,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Apply Filters',
                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortChip(
    BuildContext context,
    String label,
    _SortOption option,
  ) {
    final selected = sortOption == option;
    return GestureDetector(
      onTap: () => onSortChanged(option),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? kPrimaryOrange : kCardGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildRatingChip(BuildContext context, String label, double value) {
    final selected = minRating == value;
    return GestureDetector(
      onTap: () => onMinRatingChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? kPrimaryOrange : kCardGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value > 0) ...[
              Icon(
                Icons.star,
                size: 13,
                color: selected ? Colors.white : Colors.amber,
              ),
              const SizedBox(width: 3),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
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
    _favSelected = WishlistManager.instance.isFavorite(widget.product.id);
    WishlistManager.instance.addListener(_syncFavWithWishlist);

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
    WishlistManager.instance.removeListener(_syncFavWithWishlist);
    super.dispose();
  }

  void _syncFavWithWishlist() {
    final isFav = WishlistManager.instance.isFavorite(widget.product.id);
    if (isFav != _favSelected && mounted) {
      setState(() => _favSelected = isFav);
    }
  }

  void _toggleFav() {
    final product = widget.product;
    WishlistManager.instance.toggle(
      WishlistItem(
        id: product.id,
        name: product.name,
        price: product.price.toDouble(),
        image: product.image,
        rating: product.rating,
        reviews: product.reviews,
        subtitle: 'Premium Footwear',
        bgColor: kCardGrey,
      ),
    );
    _favController.value = 0.8;
    _favController.animateTo(
      1.0,
      curve: Curves.elasticOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _handleAddToCart() {
    if (_addedToCart) return;
    setState(() => _addedToCart = true);
    _cartController.forward(from: 0);

    final product = widget.product;
    CartManager.instance.addItem(
      CartItem(
        id: product.id,
        name: product.name,
        price: product.price.toDouble(),
        image: product.image,
        subtitle: 'Premium Footwear',
        bgColor: kCardGrey,
      ),
    );

    _showAddedToCartSnackBar();
  }

  void _showAddedToCartSnackBar() {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1F2937),
        elevation: 6,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: kPrimaryOrange,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 14, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Added to cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: kPrimaryOrange,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
        ),
      ),
    );
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
                        onPressed: _addedToCart ? null : _handleAddToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _addedToCart
                              ? Colors.green
                              : Colors.black,
                          disabledBackgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          disabledForegroundColor: Colors.white,
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
  final VoidCallback? onTap;
  const _IconBubble({required this.icon, this.badge, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
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
      ),
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
