import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/econet_chip.dart';

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

class SearchFilters extends StatefulWidget {
  @override
  _SearchFiltersState createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        height: 150,
        width: 340,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Filters',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 290,
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
                    children: List.from(CHIP_DATA.keys)
                        .map(
                          (k) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: EconetChip(k, CHIP_DATA[k], true),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ]));
  }
}
