import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

class Position extends CommonStyle<Position> {
  const Position(super.cssClass, {super.modifiers})
      : super(type: StyleType.layout);

  static const Position static = Position('static');
  static const Position fixed = Position('fixed');
  static const Position absolute = Position('absolute');
  static const Position relative = Position('relative');
  static const Position sticky = Position('sticky');

  @override
  Position create(List<PrefixModifier> modifiers) {
    return Position(cssClass, modifiers: modifiers);
  }
}
