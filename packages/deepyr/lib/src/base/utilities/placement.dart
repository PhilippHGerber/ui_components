import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// A utility class for applying positioning coordinate styles (`top`, `right`, `bottom`, `left`).
///
/// These utilities only take effect on elements with a `position` property set to
/// `absolute`, `fixed`, `relative`, or `sticky`. Use this in combination with the
/// `Position` utility (e.g., `style: [Position.fixed, Placement.bottom(4)]`).
class Placement extends CommonStyle<Placement> {
  const Placement(super.cssClass, {super.modifiers}) : super(type: StyleType.layout);

  /// Creates a `top-{value}` or `-top-{value}` utility.
  factory Placement.top(double value, {bool negative = false}) =>
      Placement('${negative ? '-top-' : 'top-'}${_formatValue(value)}');

  /// Creates a `bottom-{value}` or `-bottom-{value}` utility.
  factory Placement.bottom(double value, {bool negative = false}) =>
      Placement('${negative ? '-bottom-' : 'bottom-'}${_formatValue(value)}');

  /// Creates a `left-{value}` or `-left-{value}` utility.
  factory Placement.left(double value, {bool negative = false}) =>
      Placement('${negative ? '-left-' : 'left-'}${_formatValue(value)}');

  /// Creates a `right-{value}` or `-right-{value}` utility.
  factory Placement.right(double value, {bool negative = false}) =>
      Placement('${negative ? '-right-' : 'right-'}${_formatValue(value)}');

  @override
  Placement create(List<PrefixModifier> modifiers) {
    return Placement(cssClass, modifiers: modifiers);
  }

  /// Helper to format value for Tailwind class (e.g., 2.5 -> 2.5, 2.0 -> 2)
  static String _formatValue(double value) {
    if (value == value.truncate()) {
      return value.truncate().toString();
    }
    return value.toString();
  }
}
