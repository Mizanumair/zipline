/// status : "Completed"
/// order_id : 8
/// sender_name : "Daniel Brown"
/// sender_contactNo : "1115678901"
/// sender_emailAddress : "daniel@example.com"
/// sender_address : "H-306, Maple Ave., Villagetown, 98765"
/// receiver_name : "Isabella Harris"
/// receiver_contactNo : "7773456789"
/// receiver_emailAddress : "isabella@example.com"
/// receiver_address : "M-303, Tulip Ave., Blossomtown, 78901"
/// item_name : "Books"
/// item_image_url : "https://courier.hnktrecruitment.in/item-images/books.jpg"
/// item_size : "Large"
/// item_weight : "5.00"
/// item_type : "Paperback"
/// item_category : "Classified"
/// delivery_required : "Yes"
/// charges : "35.99"

class OrderDetailsModel {
  OrderDetailsModel({
    String? status,
    int? orderId,
    String? senderName,
    String? senderContactNo,
    String? senderEmailAddress,
    String? senderAddress,
    String? receiverName,
    String? receiverContactNo,
    String? receiverEmailAddress,
    String? receiverAddress,
    String? itemName,
    String? itemImageUrl,
    String? itemSize,
    String? itemWeight,
    String? itemType,
    String? itemCategory,
    String? deliveryRequired,
    String? charges,
  }) {
    _status = status;
    _orderId = orderId;
    _senderName = senderName;
    _senderContactNo = senderContactNo;
    _senderEmailAddress = senderEmailAddress;
    _senderAddress = senderAddress;
    _receiverName = receiverName;
    _receiverContactNo = receiverContactNo;
    _receiverEmailAddress = receiverEmailAddress;
    _receiverAddress = receiverAddress;
    _itemName = itemName;
    _itemImageUrl = itemImageUrl;
    _itemSize = itemSize;
    _itemWeight = itemWeight;
    _itemType = itemType;
    _itemCategory = itemCategory;
    _deliveryRequired = deliveryRequired;
    _charges = charges;
  }

  OrderDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _orderId = json['order_id'];
    _senderName = json['sender_name'];
    _senderContactNo = json['sender_contactNo'];
    _senderEmailAddress = json['sender_emailAddress'];
    _senderAddress = json['sender_address'];
    _receiverName = json['receiver_name'];
    _receiverContactNo = json['receiver_contactNo'];
    _receiverEmailAddress = json['receiver_emailAddress'];
    _receiverAddress = json['receiver_address'];
    _itemName = json['item_name'];
    _itemImageUrl = json['item_image_url'];
    _itemSize = json['item_size'];
    _itemWeight = json['item_weight'];
    _itemType = json['item_type'];
    _itemCategory = json['item_category'];
    _deliveryRequired = json['delivery_required'];
    _charges = json['charges'];
  }

  String? _status;
  int? _orderId;
  String? _senderName;
  String? _senderContactNo;
  String? _senderEmailAddress;
  String? _senderAddress;
  String? _receiverName;
  String? _receiverContactNo;
  String? _receiverEmailAddress;
  String? _receiverAddress;
  String? _itemName;
  String? _itemImageUrl;
  String? _itemSize;
  String? _itemWeight;
  String? _itemType;
  String? _itemCategory;
  String? _deliveryRequired;
  String? _charges;

  OrderDetailsModel copyWith({
    String? status,
    int? orderId,
    String? senderName,
    String? senderContactNo,
    String? senderEmailAddress,
    String? senderAddress,
    String? receiverName,
    String? receiverContactNo,
    String? receiverEmailAddress,
    String? receiverAddress,
    String? itemName,
    String? itemImageUrl,
    String? itemSize,
    String? itemWeight,
    String? itemType,
    String? itemCategory,
    String? deliveryRequired,
    String? charges,
  }) =>
      OrderDetailsModel(
        status: status ?? _status,
        orderId: orderId ?? _orderId,
        senderName: senderName ?? _senderName,
        senderContactNo: senderContactNo ?? _senderContactNo,
        senderEmailAddress: senderEmailAddress ?? _senderEmailAddress,
        senderAddress: senderAddress ?? _senderAddress,
        receiverName: receiverName ?? _receiverName,
        receiverContactNo: receiverContactNo ?? _receiverContactNo,
        receiverEmailAddress: receiverEmailAddress ?? _receiverEmailAddress,
        receiverAddress: receiverAddress ?? _receiverAddress,
        itemName: itemName ?? _itemName,
        itemImageUrl: itemImageUrl ?? _itemImageUrl,
        itemSize: itemSize ?? _itemSize,
        itemWeight: itemWeight ?? _itemWeight,
        itemType: itemType ?? _itemType,
        itemCategory: itemCategory ?? _itemCategory,
        deliveryRequired: deliveryRequired ?? _deliveryRequired,
        charges: charges ?? _charges,
      );

  String? get status => _status;

  int? get orderId => _orderId;

  String? get senderName => _senderName;

  String? get senderContactNo => _senderContactNo;

  String? get senderEmailAddress => _senderEmailAddress;

  String? get senderAddress => _senderAddress;

  String? get receiverName => _receiverName;

  String? get receiverContactNo => _receiverContactNo;

  String? get receiverEmailAddress => _receiverEmailAddress;

  String? get receiverAddress => _receiverAddress;

  String? get itemName => _itemName;

  String? get itemImageUrl => _itemImageUrl;

  String? get itemSize => _itemSize;

  String? get itemWeight => _itemWeight;

  String? get itemType => _itemType;

  String? get itemCategory => _itemCategory;

  String? get deliveryRequired => _deliveryRequired;

  String? get charges => _charges;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['order_id'] = _orderId;
    map['sender_name'] = _senderName;
    map['sender_contactNo'] = _senderContactNo;
    map['sender_emailAddress'] = _senderEmailAddress;
    map['sender_address'] = _senderAddress;
    map['receiver_name'] = _receiverName;
    map['receiver_contactNo'] = _receiverContactNo;
    map['receiver_emailAddress'] = _receiverEmailAddress;
    map['receiver_address'] = _receiverAddress;
    map['item_name'] = _itemName;
    map['item_image_url'] = _itemImageUrl;
    map['item_size'] = _itemSize;
    map['item_weight'] = _itemWeight;
    map['item_type'] = _itemType;
    map['item_category'] = _itemCategory;
    map['delivery_required'] = _deliveryRequired;
    map['charges'] = _charges;
    return map;
  }
}
