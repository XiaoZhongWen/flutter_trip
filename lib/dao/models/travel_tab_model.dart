class TravelTabModel {
  final String url;
  final Map params;
  final List<TravelTab> tabs;

  TravelTabModel({this.url, this.params, this.tabs});

  factory TravelTabModel.fromJson(Map<String, dynamic> json) {
    List<TravelTab> tabs = [];
    if (json['tabs'] != null) {
      List list = json['tabs'] as List;
      tabs = list.map((tab) => TravelTab.fromJson(tab)).toList();
    }
    return TravelTabModel(
        url: json['url'],
        params: json['params'],
        tabs: tabs
    );
  }

}

class TravelTab {
  final String labelName;
  final String groupChannelCode;

  TravelTab({this.labelName, this.groupChannelCode});

  factory TravelTab.fromJson(Map<String, dynamic> json) {
    return TravelTab(
      labelName: json['labelName'],
      groupChannelCode: json['groupChannelCode']
    );
  }
}