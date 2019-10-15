import 'package:flutter/material.dart';
import 'package:urban_dict_slang/services/api/http_api.dart';

import 'package:urban_dict_slang/widgets/definition_tile.dart';
import 'package:urban_dict_slang/models/definition.dart';

import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class ResultPage extends StatefulWidget {
  const ResultPage({Key key, this.passedTerm}) : super(key: key);

  final String passedTerm;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String term;
  Future<List<Definition>> definitions;

  initState() {
    super.initState();
    definitions = HttpApi().getDefinitions(widget.passedTerm);
    term = widget.passedTerm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => print('Search action pressed'),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.star_border, color: Colors.yellowAccent),
                      onPressed: () => print('bookmark pressed'),
                    ),
                    Center(
                      child: Text(
                        term,
                        style: customStyles.definitionHeaderTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: FutureBuilder(
                future: definitions,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: Text('Loading...'),
                      );
                    default:
                      if (snapshot.hasError)
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      else if (snapshot.data.length == 0)
                        return Center(
                          child: Text('No such term'),
                        );
                      else
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return DefinitionTile(
                              definition: snapshot.data[index],
                            );
                          },
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
