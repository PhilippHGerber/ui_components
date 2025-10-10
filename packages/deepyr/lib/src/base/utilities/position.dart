import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// A utility class for controlling the CSS `position` property.
class Position extends CommonStyle<Position> {
  const Position(super.cssClass, {super.modifiers})
      : super(type: StyleType.layout);

  /// `position: static`
  static const Position static = Position('static');

  /// `position: fixed`
  static const Position fixed = Position('fixed');

  /// `position: absolute`
  static const Position absolute = Position('absolute');

  /// `position: relative`
  static const Position relative = Position('relative');

  /// `position: sticky`
  static const Position sticky = Position('sticky');

  @override
  Position create(List<PrefixModifier> modifiers) {
    return Position(cssClass, modifiers: modifiers);
  }
}
