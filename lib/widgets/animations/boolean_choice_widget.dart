import 'package:flutter/material.dart';

typedef SelectedWidgetBuilder = Widget Function(bool);

class BooleanChoiceWidget extends StatefulWidget {
  final int smallWidthFlex;
  final int bigWidthFlex;
  final SelectedWidgetBuilder leftWidget;
  final SelectedWidgetBuilder rightWidget;
  final VoidCallback? onLeftChosen;
  final VoidCallback? onRightChosen;
  final Duration animationDuration;

  const BooleanChoiceWidget({
    Key? key,
    required this.leftWidget,
    required this.rightWidget,
    this.onLeftChosen,
    this.onRightChosen,
    this.animationDuration = const Duration(milliseconds: 500),
    this.smallWidthFlex = 2,
    this.bigWidthFlex = 3,
  }) : super(key: key);

  @override
  _BooleanChoiceWidgetState createState() => _BooleanChoiceWidgetState();
}

class _BooleanChoiceWidgetState extends State<BooleanChoiceWidget> {
  bool _isLeftSelected = true;

  int get totalFlex => widget.smallWidthFlex + widget.bigWidthFlex;
  ColorFilter get greyFilter => const ColorFilter.mode(
        Colors.grey,
        BlendMode.saturation,
      );

  ColorFilter get noFilter => const ColorFilter.mode(
        Colors.transparent,
        BlendMode.saturation,
      );

  @override
  Widget build(BuildContext context) {
    int leftWidthFlex =
        _isLeftSelected ? widget.bigWidthFlex : widget.smallWidthFlex;
    int rightWidthFlex = totalFlex - leftWidthFlex;

    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;

      return SizedBox(
        height: 200,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if (widget.onLeftChosen != null) {
                  widget.onLeftChosen!();
                }
                setState(() {
                  _isLeftSelected = true;
                });
              },
              child: AnimatedContainer(
                width: width * (leftWidthFlex / totalFlex),
                duration: widget.animationDuration,
                child: ColorFiltered(
                    colorFilter: _isLeftSelected ? noFilter : greyFilter,
                    child: widget.leftWidget(_isLeftSelected)),
              ),
            ),
            InkWell(
              onTap: () {
                if (widget.onRightChosen != null) {
                  widget.onRightChosen!();
                }
                setState(() {
                  _isLeftSelected = false;
                });
              },
              child: AnimatedContainer(
                width: width * (rightWidthFlex / totalFlex),
                duration: widget.animationDuration,
                child: ColorFiltered(
                    colorFilter: _isLeftSelected ? greyFilter : noFilter,
                    child: widget.rightWidget(!_isLeftSelected)),
              ),
            )
          ],
        ),
      );
    });
  }
}
