class Bag {
  BagSize _size;
  BagWeight _weight;
  int qty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bag &&
          runtimeType == other.runtimeType &&
          _size == other._size &&
          _weight == other._weight;

  @override
  int get hashCode => _size.hashCode ^ _weight.hashCode;

  Bag(this._size, this._weight, this.qty);

  BagSize get size => _size;

  BagWeight get weight => _weight;
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
