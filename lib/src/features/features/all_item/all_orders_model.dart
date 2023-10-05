/// order_token : "CRC34770653"
/// date : "8/4/2023, 6:31:13 PM"
/// status : "Pickup Pending"
/// sender_name : "Sender 1"
/// receiver_name : "Receiver 1"
/// item_name : "item 1"

class AllOrdersModel {
  AllOrdersModel({
    String? orderToken,
    String? date,
    String? status,
    String? senderName,
    String? receiverName,
    String? itemName,
    String? itemImageUrl,
  }) {
    _orderToken = orderToken;
    _date = date;
    _status = status;
    _senderName = senderName;
    _receiverName = receiverName;
    _itemName = itemName;
    _itemImageUrl = itemImageUrl;
  }

  AllOrdersModel.fromJson(dynamic json) {
    _orderToken = json['order_token'];
    _date = json['date'] ?? json['order_date'];
    _status = json['status'];
    _senderName = json['sender_name'];
    _receiverName = json['receiver_name'];
    _itemName = json['item_name'];
    _itemImageUrl = json['item_image_url'];
  }

  String? _orderToken;
  String? _date;
  String? _status;
  String? _senderName;
  String? _receiverName;
  String? _itemName;
  String? _itemImageUrl;

  AllOrdersModel copyWith({
    String? orderToken,
    String? date,
    String? status,
    String? senderName,
    String? receiverName,
    String? itemName,
    String? itemImageUrl,
  }) =>
      AllOrdersModel(
          orderToken: orderToken ?? _orderToken,
          date: date ?? _date,
          status: status ?? _status,
          senderName: senderName ?? _senderName,
          receiverName: receiverName ?? _receiverName,
          itemName: itemName ?? _itemName,
          itemImageUrl: itemImageUrl ?? _itemImageUrl);

  String? get orderToken => _orderToken;

  String? get date => _date;

  String? get status => _status;

  String? get senderName => _senderName;

  String? get receiverName => _receiverName;

  String? get itemName => _itemName;

  String? get itemImageUrl => _itemImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_token'] = _orderToken;
    map['date'] = _date;
    map['status'] = _status;
    map['sender_name'] = _senderName;
    map['receiver_name'] = _receiverName;
    map['item_name'] = _itemName;
    map['item_image_url'] = _itemImageUrl;
    return map;
  }
}
