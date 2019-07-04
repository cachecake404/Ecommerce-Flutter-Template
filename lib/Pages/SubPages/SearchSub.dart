import 'package:flutter/material.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import '../../Tools/UserDataManager.dart';
import "package:provider/provider.dart";
import "../../Widgets/Searcher.dart";
import "../../Widgets/ShopCard.dart";

class SearchSub extends StatelessWidget {
  void updateSample(BuildContext context) {
    // Get current data to change and update
    DataTracker dataManager = Provider.of<DataTracker>(context);
    UserDataManager userHandler = new UserDataManager(dataManager.user);
    Map<String, dynamic> updatedData = dataManager.customData;
    // Data to update
    updatedData["first_name"] = "Sam";
    // Submit the update
    userHandler.updateData(updatedData, dataManager.customDataKey);
    dataManager.autoSetData();
  }

  Map<String, ShopCard> getCardMap(BuildContext context) {
    List<List<ShopCard>> shopCards = Provider.of<DataTracker>(context).allCards;
    Map<String, ShopCard> cardsMap = new Map<String, ShopCard>();
    for (int i = 0; i < shopCards.length; i++) {
      for (int j = 0; j < shopCards[i].length; j++) {
        cardsMap[shopCards[i][j].name] = shopCards[i][j];
      }
    }
    return cardsMap;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: DataSearch(getCardMap(context)));
      },
      child: Card(
        child: Row(
          children: <Widget>[
            Text(
              "Search ...",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            Spacer(),
            Icon(Icons.search,size: 30,),
          ],
        ),
      ),
    );
  }
}
