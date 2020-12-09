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
