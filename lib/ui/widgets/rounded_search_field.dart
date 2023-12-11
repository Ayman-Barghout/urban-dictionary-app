import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/definitions_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/term_bloc/bloc.dart';

class RoundedSearchField extends StatefulWidget {
  const RoundedSearchField({super.key});

  @override
  _RoundedSearchFieldState createState() => _RoundedSearchFieldState();
}

class _RoundedSearchFieldState extends State<RoundedSearchField> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearch(String term) {
    BlocProvider.of<TermBloc>(context).add(ChangeTerm(newTerm: term));
    BlocProvider.of<DefinitionsBloc>(context).add(FetchDefinitions(term));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      controller: _searchController,
      onSubmitted: (value) => _onSearch(value),
      style: TextStyle(
        fontSize: 20.0,
        color: Theme.of(context).primaryColor,
        decoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.arrow_right,
            size: 35.0,
          ),
          onPressed: () => _onSearch(_searchController.text),
        ),
        contentPadding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        prefixIcon: const Icon(Icons.search),
        hintText: "Search...",
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 32.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 32.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
