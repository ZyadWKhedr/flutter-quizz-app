import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final List<String> categories;
  final void Function(String) onSearch;

  const SearchBar({
    super.key,
    required this.categories,
    required this.onSearch,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          widget.onSearch(value);
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          hintText: 'Search categories...',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          filled: true,
          fillColor: Colors.blueGrey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
