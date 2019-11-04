import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedSearchField extends StatefulWidget {
  const RoundedSearchField({
    Key key,
    @required this.onSearch,
  }) : super(key: key);

  final Function onSearch;

  @override
  _RoundedSearchFieldState createState() => _RoundedSearchFieldState();
}

class _RoundedSearchFieldState extends State<RoundedSearchField> {
  TextEditingController _searchController;
  String _searchText = '';

  void _onTap(String value) {
    widget.onSearch(value);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(30),
        ],
        controller: _searchController,
        onSubmitted: (value) => _onTap(value),
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.blueAccent,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.arrow_right,
              size: 35.0,
            ),
            onPressed: () => _onTap(_searchText),
          ),
          contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          prefixIcon: Icon(Icons.search),
          hintText: "Search...",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 32.0),
              borderRadius: BorderRadius.circular(25.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 32.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
