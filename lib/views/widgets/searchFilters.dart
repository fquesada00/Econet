import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget _createCustomChip({String text, Color color}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.5),
      child: Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: color,
        //necesario por que sino deja una sombra
        label: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'SFProDisplayBold',
          ),
        ),
      ),
    ),
  );
}

class AlwaysVisibleScrollbarPainter extends ScrollbarPainter {
  AlwaysVisibleScrollbarPainter()
      : super(
          color: Color(0xFFAAAAAA),
          textDirection: TextDirection.ltr,
          thickness: 4,
          fadeoutOpacityAnimation: const AlwaysStoppedAnimation(1.0),
        );

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    _scrollable?.position?.removeListener(_onScrollChanged);
    _scrollable = value;
    _scrollable?.position?.addListener(_onScrollChanged);
    _onScrollChanged();
  }

  void _onScrollChanged() {
    update(_scrollable.position, _scrollable.axisDirection);
  }

  @override
  void dispose() {
    _scrollable?.position?.removeListener(notifyListeners);
    super.dispose();
  }
}

class SearchFilters extends StatelessWidget {
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: 340,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Text(
              'Filters',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'SFProDisplayBold',
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 310,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFFE5E2E2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CupertinoScrollbar(
                  isAlwaysShown: true,
                  controller: _controller,
                  child: ListView(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _createCustomChip(
                        text: 'Paper',
                        color: Color(0xFFC7A26B),
                      ),
                      _createCustomChip(
                        text: 'Plastic',
                        color: Color(0xFF6B7AC7),
                      ),
                      _createCustomChip(
                        text: 'Ecopoints Only',
                        color: Color(0xFF649A3B),
                      ),
                      _createCustomChip(
                        text: 'Metal',
                        color: Color(0xFFA8A8A8),
                      ),
                      _createCustomChip(
                        text: 'Glass',
                        color: Color(0xFF6BB7C7),
                      ),
                      _createCustomChip(
                        text: 'Recycling Plants Only',
                        color: Color(0xFF313131),
                      ),
                      _createCustomChip(
                        text: 'Electronics',
                        color: Color(0xFF4EA77D),
                      ),
                      _createCustomChip(
                        text: 'Textile',
                        color: Color(0xFF313131),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
