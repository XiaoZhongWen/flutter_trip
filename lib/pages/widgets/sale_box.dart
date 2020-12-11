import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/models/sales_box_model.dart';
import 'package:flutter_trip/dao/models/commom_model.dart';

class SaleBox extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SaleBox({Key key, this.salesBox}) : super(key: key);

  _generateCard(BuildContext context, CommonModel commonModel) {
    return Container(
      child: Image.network(commonModel.icon,),
    );
  }

  _generateBigView(BuildContext context) {
    return Container(
      height: 140,
      child: Row(
        children: [
          Expanded(child: _generateCard(context, this.salesBox.bigCard1),),
          Expanded(child: _generateCard(context, this.salesBox.bigCard2),)
        ],
      ),
    );
  }

  _generateSmallView(BuildContext context, CommonModel smallCard1, CommonModel smallCard2) {
    return Container(
      height: 86,
      child: Row(
        children: [
          Expanded(child: _generateCard(context, smallCard1),),
          Expanded(child: _generateCard(context, smallCard2),)
        ],
      ),
    );
  }

  _generateBannerView(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            this.salesBox.icon,
            height: 15,
            fit: BoxFit.contain,
          ),
          Chip(
            backgroundColor: Color(0xffff6cc9),
            label: Text(
              "获取更多福利>",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Column(
          children: [
            _generateBannerView(context),
            _generateBigView(context),
            _generateSmallView(context, this.salesBox.smallCard1, this.salesBox.smallCard2),
            _generateSmallView(context, this.salesBox.smallCard3, this.salesBox.smallCard4),
          ],
        ),
      ),
    );
  }
}
