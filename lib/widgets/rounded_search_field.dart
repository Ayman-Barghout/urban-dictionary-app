import 'package:flutter/material.dart';

class RoundedSearchField extends StatelessWidget {
  const RoundedSearchField({
    Key key,
    @required this.onSearch,
  }) : super(key: key);

  final Function onSearch;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) => onSearch(value),
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.blueAccent,
      ),
      decoration: InputDecoration(
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
}
