import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedSearchField extends StatefulWidget {
  final Function onSearch;

  const RoundedSearchField({
    Key key,
    @required this.onSearch,
  }) : super(key: key);

  @override
  _RoundedSearchFieldState createState() => _RoundedSearchFieldState();
}

class _RoundedSearchFieldState extends State<RoundedSearchField> {
  TextEditingController _searchController;
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      controller: _searchController,
      onSubmitted: (value) {
        if (value != '') {
          widget.onSearch(value);
          WidgetsBinding.instance
              .addPostFrameCallback((_) => _searchController.clear());
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
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
          onPressed: () {
            widget.onSearch(_searchController.text);
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _searchController.clear());
            FocusScope.of(context).requestFocus(FocusNode());
          },
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
