import '../common_style.dart';
import '../style_type.dart' show StyleType;
import '../ui_prefix_modifier.dart';

class BgUtil extends CommonStyle<BgUtil> {
  const BgUtil(super.cssClass, {super.modifiers})
      : super(type: StyleType.style);

  // Hintergrundfarben
  static const BgUtil base100 = BgUtil('bg-base-100');
  static const BgUtil base200 = BgUtil('bg-base-200');
  static const BgUtil base300 = BgUtil('bg-base-300');
  static const BgUtil primary = BgUtil('bg-primary');
  static const BgUtil secondary = BgUtil('bg-secondary');

  static const BgUtil neutral = BgUtil('bg-neutral');

  // Hintergrund-Opacity
  static const BgUtil opacity75 = BgUtil('bg-opacity-75');
  static const BgUtil opacity50 = BgUtil('bg-opacity-50');

  // Hintergrund-Verhalten
  static const BgUtil fixed = BgUtil('bg-fixed');
  static const BgUtil local = BgUtil('bg-local');

  @override
  BgUtil create(List<PrefixModifier> modifiers) {
    // Create a new instance with the original cssClass and new modifiers
    return BgUtil(cssClass, modifiers: modifiers);
  }
}
