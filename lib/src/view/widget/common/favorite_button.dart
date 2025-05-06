import 'package:e_commerce_flutter/services/prefs_box.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteButton extends StatefulWidget {
  final String productId;
  final double size;

  const FavoriteButton({
    super.key,
    required this.productId,
    this.size = 20.0,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;
  final GetStorage _box = GetStorage();
  late VoidCallback _storageListenerDisposer;
  static const String _favoriteProductIdsKey = 'favorite_product_ids';

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();

    _storageListenerDisposer =
        PrefsBox.instance.listenKey(_favoriteProductIdsKey, (value) {
      final List<String> favoriteIds = List<String>.from(value ?? []);
      final bool currentlyIsFavorite = favoriteIds.contains(widget.productId);
      if (mounted && _isFavorite != currentlyIsFavorite) {
        setState(() {
          _isFavorite = currentlyIsFavorite;
        });
      }
    });
  }

  void _checkIfFavorite() {
    final List<dynamic> favoriteIdsDynamic =
        _box.read<List<dynamic>>(_favoriteProductIdsKey) ?? [];
    final List<String> favoriteIds = favoriteIdsDynamic.cast<String>();
    if (mounted) {
      setState(() => _isFavorite = favoriteIds.contains(widget.productId));
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await PrefsBox.removeFavoriteProductId(widget.productId);
    } else {
      await PrefsBox.addFavoriteProductId(widget.productId);
    }
    if (mounted) {
      setState(() => _isFavorite = !_isFavorite);
    }
  }

  @override
  void dispose() {
    _storageListenerDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleFavorite,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
          size: widget.size,
        ),
      ),
    );
  }
}
