import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  Map<String, dynamic> itemMap;
  List<String> keysList;
  String name = "";
  DataSearch(Map<String, dynamic> itemMapObj) : itemMap = itemMapObj {
    keysList = itemMapObj.keys.toList();
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {

    return Container(
      child: ListView(
        children: [
          Center(
            child: itemMap[name],
          )
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchKeyList = keysList
        .where((s) => s.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
            onTap: () {
              name = searchKeyList[index];
              showResults(context);
            },
            leading: Icon(Icons.smoking_rooms),
            title: Text(searchKeyList[index]),
          ),
      itemCount: searchKeyList.length,
    );
  }
}
