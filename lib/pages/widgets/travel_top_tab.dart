import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/models/travel_tab_model.dart';

class TravelTopTab extends StatelessWidget {
  final TravelTab travelTab;

  const TravelTopTab({Key key, this.travelTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(travelTab.labelName),
    );
  }
}
