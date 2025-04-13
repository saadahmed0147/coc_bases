import 'package:coc_bases/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedClickableBanner extends StatefulWidget {
  final double height;
  final String image;
  final VoidCallback onTap;

  const AnimatedClickableBanner({
    super.key,
    required this.height,
    required this.image,
    required this.onTap,
  });

  @override
  State<AnimatedClickableBanner> createState() =>
      AnimatedClickableBannerState();
}

class AnimatedClickableBannerState extends State<AnimatedClickableBanner> {
  double _scale = 1.0;

  void _onTapDown(_) => setState(() => _scale = 0.95);
  void _onTapUp(_) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    // Accessing the BannerProvider to listen to its state
    final bannerProvider = Provider.of<BannerProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          // Trigger the onTap callback passed to the widget
          widget.onTap();

          // Toggle the clicked state in the provider
          bannerProvider.toggleClick();
        },
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 1.0, end: _scale),
          duration: Duration(milliseconds: 150),
          builder: (context, value, child) => Transform.scale(
            scale: value,
            child: child,
          ),
          child: Consumer<BannerProvider>(
            builder: (context, bannerProvider, child) {
              return Container(
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
