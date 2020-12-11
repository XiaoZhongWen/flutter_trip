import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/models/commom_model.dart';

class SubNav extends StatelessWidget {

  final List<CommonModel> subNavList;
  const SubNav({Key key, this.subNavList}): super(key: key);

  _generateGridItem(BuildContext context, int index) {
    CommonModel commonModel = this.subNavList[index];
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(commonModel.icon, width: 25, height: 25,),
          Text(commonModel.title, style: TextStyle(fontSize: 13),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 107,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white
      ),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio:1.5),
          itemCount: this.subNavList.length,
          itemBuilder: (BuildContext context, int index){
            return _generateGridItem(context, index);
          }),
    );
  }
}
