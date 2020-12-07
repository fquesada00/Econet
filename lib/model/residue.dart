enum Residue { paper, plastic, glass, electronics, textile, wood, metal }

const List<String> RESIDUES = [
  'Paper',
  'Plastic',
  'Glass',
  'Electronics',
  'Textile',
  'Wood',
  'Metal'
];

String residueToString(Residue residue) {
  switch (residue) {
    case Residue.paper:
      return RESIDUES[0];
    case Residue.plastic:
      return RESIDUES[1];
    case Residue.glass:
      return RESIDUES[2];
    case Residue.electronics:
      return RESIDUES[3];
    case Residue.textile:
      return RESIDUES[4];
    case Residue.wood:
      return RESIDUES[5];
    case Residue.metal:
      return RESIDUES[6];
    default:
      return '';
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
