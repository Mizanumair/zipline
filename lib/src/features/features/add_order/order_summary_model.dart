// sender_name : "Sarita Kuamri"
// receiver_name : "Vishnu Pathak"
//  charges : "123.00"
//  delivery_required : "Yes"
//  category : "Priority"
//  weight : "0.67"
//  size : "12x12.5x14"

class OrderSummaryModel {
  OrderSummaryModel({
    String? senderName,
    String? receiverName,
    String? charges,
    String? deliveryRequired,
    String? category,
    String? type,
    String? weight,
    String? size,
  }) {
    _senderName = senderName;
    _receiverName = receiverName;
    _charges = charges;
    _deliveryRequired = deliveryRequired;
    _category = category;
    _type = type;
    _weight = weight;
    _size = size;
  }

  OrderSummaryModel.fromJson(dynamic json) {
    _senderName = json['sender_name'];
    _receiverName = json['receiver_name'];
    _charges = json['charges'];
    _deliveryRequired = json['delivery_required'];
    _category = json['category'];
    _type = json['Type'];
    _weight = json['weight'];
    _size = json['size'];
  }

  String? _senderName;
  String? _receiverName;
  String? _charges;
  String? _deliveryRequired;
  String? _category;
  String? _type;
  String? _weight;
  String? _size;

  OrderSummaryModel copyWith({
    String? senderName,
    String? receiverName,
    String? charges,
    String? deliveryRequired,
    String? category,
    String? type,
    String? weight,
    String? size,
  }) =>
      OrderSummaryModel(
        senderName: senderName ?? _senderName,
        receiverName: receiverName ?? _receiverName,
        charges: charges ?? _charges,
        deliveryRequired: deliveryRequired ?? _deliveryRequired,
        category: category ?? _category,
        type: type ?? _type,
        weight: weight ?? _weight,
        size: size ?? _size,
      );

  String? get senderName => _senderName;

  String? get receiverName => _receiverName;

  String? get charges => _charges;

  String? get deliveryRequired => _deliveryRequired;

  String? get category => _category;

  String? get type => _type;

  String? get weight => _weight;

  String? get size => _size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender_name'] = _senderName;
    map['receiver_name'] = _receiverName;
    map['charges'] = _charges;
    map['delivery_required'] = _deliveryRequired;
    map['category'] = _category;
    map['Type'] = _type;
    map['weight'] = _weight;
    map['size'] = _size;
    return map;
  }
}
