enum Residue { paper, plastic, glass, electronics, textile, wood, metal }

String residueToString(Residue residue) {
  switch (residue) {
    case Residue.paper:
      return 'Paper';
    case Residue.plastic:
      return 'Plastic';
    case Residue.glass:
      return 'Glass';
    case Residue.electronics:
      return 'Electronics';
    case Residue.textile:
      return 'Textile';
    case Residue.wood:
      return 'Wood';
    default:
      return 'Metal';
  }
}

Residue residueFromString(String residueName) {
  switch (residueName.toLowerCase()) {
    case 'paper':
      return Residue.paper;
    case 'plastic':
      return Residue.plastic;
    case 'glass':
      return Residue.glass;
    case 'electronics':
      return Residue.electronics;
    case 'textile':
      return Residue.textile;
    case 'wood':
      return Residue.wood;
    case 'metal':
      return Residue.metal;
    default:
      return null;
  }
}
