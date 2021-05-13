import 'package:equatable/equatable.dart';
import 'parents/service_model.dart';

class DiemDuLichModel extends ServiceModel with EquatableMixin {
  List<TravelPrice> priceList;

  DiemDuLichModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['price'] != null) {
      priceList = [];
      json['price'].forEach((v) {
        priceList.add(new TravelPrice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    if (this.priceList != null) {
      data['price'] = this.priceList.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => super.props..add(priceList);
}

class TravelPrice {
  String name;
  String amount;

  TravelPrice({this.name, this.amount});

  TravelPrice.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}
