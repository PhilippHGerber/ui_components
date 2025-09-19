import '../common_style.dart';
import '../style_type.dart' show StyleType;
import '../ui_prefix_modifier.dart';

class BgUtil extends CommonStyle<BgUtil> {
  const BgUtil(super.cssClass, {super.modifiers}) : super(type: StyleType.style);

  /// Creates a background opacity utility. `bg-opacity-{value}`
  ///
  /// [value]: The opacity percentage. Must be between 0 and 100,
  /// and a multiple of 5 (e.g., 0, 5, 10, ..., 95, 100).
  const BgUtil.opacity(int value)
      : assert(
          value >= 0 && value <= 100 && value % 5 == 0,
          'Opacity value must be between 0 and 100, in steps of 5.',
        ),
        super('bg-opacity-$value', type: StyleType.style);

  // Background colors
  static const BgUtil base100 = BgUtil('bg-base-100');
  static const BgUtil base200 = BgUtil('bg-base-200');
  static const BgUtil base300 = BgUtil('bg-base-300');
  static const BgUtil primary = BgUtil('bg-primary');
  static const BgUtil secondary = BgUtil('bg-secondary');
  static const BgUtil neutral = BgUtil('bg-neutral');

  // Background opacity
  static const BgUtil opacity75 = BgUtil('bg-opacity-75');
  static const BgUtil opacity60 = BgUtil('bg-opacity-60');
  static const BgUtil opacity50 = BgUtil('bg-opacity-50');
  static const BgUtil opacity25 = BgUtil('bg-opacity-25');
  static const BgUtil opacity0 = BgUtil('bg-opacity-0');

  // Background position
  static const BgUtil fixed = BgUtil('bg-fixed');
  static const BgUtil local = BgUtil('bg-local');

  @override
  BgUtil create(List<PrefixModifier> modifiers) {
    // Create a new instance with the original cssClass and new modifiers
    return BgUtil(cssClass, modifiers: modifiers);
  }
}
