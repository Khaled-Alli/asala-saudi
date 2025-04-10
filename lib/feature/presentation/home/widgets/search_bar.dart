import 'package:asala_saudi/core/helpers/extentions/extentions.dart';
import 'package:asala_saudi/core/networking/data.dart';
import 'package:asala_saudi/feature/model/community/community.dart';
import 'package:asala_saudi/feature/model/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routing.dart';

class SearchBarWithSuggestions extends StatefulWidget {
  const SearchBarWithSuggestions({super.key});

  @override
  State<SearchBarWithSuggestions> createState() =>
      _SearchBarWithSuggestionsState();
}

class _SearchBarWithSuggestionsState extends State<SearchBarWithSuggestions> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;



  List<Community> filteredProducts = [];

  void _onSearchChanged() {
    final query = _controller.text.toLowerCase();
    filteredProducts = MyAppData.communities
        .where((product) => product.name!.contains(query))
        .toList();

    _showOverlay();
  }

  void _showOverlay() {
    _removeOverlay(); // <-- safer cleanup

    if (filteredProducts.isEmpty || _controller.text.isEmpty) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 290.w,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 55),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredProducts[index].name ?? ""),
                  onTap: () {
                   // _controller.text = filteredProducts[index].name ?? "";
                    print(filteredProducts[index].name);
                    context.pushNamed(Routes.communityDetailsScreen,arguments:filteredProducts[index] );
                    _removeOverlay();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }



  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: SizedBox(
        width: 290.w,
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "search",
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
