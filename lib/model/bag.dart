class Bag {
  BagSize _size;
  BagWeight _weight;
  int _qty;

  Bag(this._size, this._weight, this._qty);

  BagSize get size => _size;

  BagWeight get weight => _weight;

  int get qty => _qty;
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
