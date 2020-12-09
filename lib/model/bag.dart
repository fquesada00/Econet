import 'dart:convert';

class Bag {
  BagSize size;
  BagWeight weight;
  int qty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Bag &&
              runtimeType == other.runtimeType &&
              size == other.size &&
              weight == other.weight;

  @override
  int get hashCode => size.hashCode ^ weight.hashCode;

  Bag(this.size, this.weight, this.qty);

  Bag.fromJson(Map<String, dynamic> json){
    this.size = bagSizeFromString(json['size']);
    this.weight = bagWeightFromString(json['weight']);
    this.qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'size': bagSizeToString(size),
      'weight': bagWeightToString(weight),
      'qty': qty
    };
  }

}

enum BagSize { small, medium, large, extraLarge }
enum BagWeight { light, heavy, veryHeavy }


String bagSizeToString(BagSize bagSize) {
  switch (bagSize) {
    case BagSize.small:
      return 'Small';
    case BagSize.medium:
      return 'Medium';
    case BagSize.large:
      return 'Large';
    case BagSize.extraLarge:
      return 'Extra Large';
    default:
      return null;
  }
}

String bagWeightToString(BagWeight bagWeight) {
  switch (bagWeight) {
    case BagWeight.light:
      return 'Light';
    case BagWeight.heavy:
      return 'Heavy';
    case BagWeight.veryHeavy:
      return 'Very Heavy';
    default:
      return null;
  }
}

  BagSize bagSizeFromString(String bagSize) {
    switch (bagSize) {
      case 'Small':
        return BagSize.small;
      case 'Medium':
        return BagSize.medium;
      case 'Large':
        return BagSize.large;
      case 'Extra Large':
        return BagSize.extraLarge;
      default:
        return null;
    }
  }

  BagWeight bagWeightFromString(String bagWeight) {
    switch (bagWeight) {
      case 'Light':
        return BagWeight.light;
      case 'Heavy':
        return BagWeight.heavy;
      case 'Very Heavy':
        return BagWeight.veryHeavy;
      default:
        return null;
    }
  }
