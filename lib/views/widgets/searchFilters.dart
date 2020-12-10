import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/econet_display_chip.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import 'econet_filter_chip.dart';

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
  LinkedScrollControllerGroup _controllers;
  ScrollController _controller1 = new ScrollController();
  ScrollController _controller2 = new ScrollController();

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _controller1 = _controllers.addAndGet();
    _controller2 = _controllers.addAndGet();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: 190,
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
                height: 110,
                decoration: BoxDecoration(
                  color: Color(0xFFE5E2E2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: ListView(
                          padding: EdgeInsets.only(left: 15, right: 100),
                          shrinkWrap: true,
                          controller: _controller1,
                          scrollDirection: Axis.horizontal,
                          children: List.from(
                            CHIP_DATA.keys
                                .take(((CHIP_DATA.keys.length + 1) / 2).round())
                                .map(
                                  (k) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: EconetFilterChip(k, CHIP_DATA[k]),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: CupertinoScrollbar(
                          isAlwaysShown: true,
                          controller: _controller2,
                          child: ListView(
                            padding: EdgeInsets.only(left: 15),
                            shrinkWrap: true,
                            controller: _controller2,
                            scrollDirection: Axis.horizontal,
                            children: List.from(
                              CHIP_DATA.keys
                                  .skip(((CHIP_DATA.keys.length) / 2).round())
                                  .map(
                                    (k) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: EconetFilterChip(k, CHIP_DATA[k]),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]));
  }
}
