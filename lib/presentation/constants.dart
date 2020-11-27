library constants;
import 'package:flutter/material.dart';

//Paleta de colores
const Color GREEN_LIGHT = Color.fromRGBO(192, 222, 169, 1);
const Color GREEN_MEDIUM = Color.fromRGBO(163, 203, 143, 1);
const Color GREEN_DARK = Color.fromRGBO(100, 154, 59, 1);
const Color BROWN_DARK = Color.fromRGBO(179, 129, 110, 1);
const Color BROWN_MEDIUM = Color.fromRGBO(199, 162, 107, 1);
const Color BROWN_LIGHT = Color.fromRGBO(222, 210, 170, 1);
const Color BLUE_MEDIUM = Color(0xFF8F9CDF);
const Color RED_MEDIUM = Color(0xFFFF6868);
const Color RED_DARK = Color(0xFFBF4040);

//Colores de tags (residuos, filtros, etc)
const Color PAPER_COLOR = BROWN_MEDIUM;
const Color PLASTIC_COLOR = Color(0xFF6B7AC7);
const Color GLASS_COLOR = Color(0xFF6BB7C7);
const Color METAL_COLOR = Color(0xFFA8A8A8);
const Color ELECTRONICS_COLOR = Color(0xFF4EA77D);
const Color WOOD_COLOR = Color(0xFFB3816E);
const Color TEXTILE_COLOR = Color(0xFFC76BC7);

//Otros
const Color WARNING_COLOR = Color(0xFFFFA826);
const Color ERROR_COLOR = Color(0xFFAF0000);
const Color EDIT_COLOR = Color(0xFF9B9B9B);

const Map<String, Color> CHIP_DATA = {
  'Paper': PAPER_COLOR,
  'Plastic': PLASTIC_COLOR,
  'Glass': GLASS_COLOR,
  'Metal': METAL_COLOR,
  'Electronics': ELECTRONICS_COLOR,
  'Wood': WOOD_COLOR,
  'Textile': TEXTILE_COLOR,
  'Ecopoints Only': GREEN_DARK,
  'Recycling Plants Only': Colors.black,
};

const List<String> RECENT_SEARCHES_DATA = [
  'Address 5678',
  'Neighborhood X',
  'Address 1111',
  'Recycling Plant Z'
];
