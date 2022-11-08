import 'package:core/core.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final void Function(int index)? onChanged;
  final int? value;
  final IconData? filledStar;
  final IconData? unfilledStar;

  const StarRating({
    Key? key,
    @required this.onChanged,
    this.value = 0,
    this.filledStar,
    this.unfilledStar,
  })  : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor =
        ColorsCollection.cYellow; //Theme.of(context).accentColor;
    final disabledColor = ColorsCollection.cDisableColor;
    final size = 40.0;
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return Expanded(
            child: IconButton(
                onPressed: onChanged != null
                    ? () {
                        onChanged!(value == index + 1 ? index : index + 1);
                      }
                    : null,
                color: index < value! ? selectedColor : disabledColor,
                iconSize: size,
                icon: Icon(index < value!
                    ? filledStar ?? Icons.star
                    : unfilledStar ?? Icons.star),
                padding: EdgeInsets.zero,
                tooltip: "${index + 1} of 5"),
          );
        }));
  }
}
