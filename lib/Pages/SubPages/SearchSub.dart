import 'package:flutter/material.dart';
import 'package:hookah1/Tools/DataTracker.dart';
import '../../Tools/UserDataManager.dart';
import "package:provider/provider.dart";

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

  @override
  Widget build(BuildContext context) {
    return Text("Search");
  }
}
