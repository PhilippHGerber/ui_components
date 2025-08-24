import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// Utilities for controlling spacing (margin and padding).
class Spacing extends CommonStyle<Spacing> {
  const Spacing(super.cssClass, {super.modifiers})
      : super(type: StyleType.spacing);

  @override
  Spacing create(List<PrefixModifier> modifiers) {
    return Spacing(cssClass, modifiers: modifiers);
  }

  // --- Margin ---
  /// Margin on all sides. `m-{value}`
  static Spacing m(double value) => Spacing('m-${_formatValue(value)}');

  /// Margin on x-axis. `mx-{value}`
  static Spacing mx(double value) => Spacing('mx-${_formatValue(value)}');

  /// Margin on y-axis. `my-{value}`
  static Spacing my(double value) => Spacing('my-${_formatValue(value)}');

  /// Margin on top. `mt-{value}`
  static Spacing mt(double value) => Spacing('mt-${_formatValue(value)}');

  /// Margin on right. `mr-{value}` or `me-{value}` (end)
  static Spacing mr(double value) => Spacing('mr-${_formatValue(value)}');
  static Spacing me(double value) => Spacing('me-${_formatValue(value)}');

  /// Margin on bottom. `mb-{value}`
  static Spacing mb(double value) => Spacing('mb-${_formatValue(value)}');

  /// Margin on left. `ml-{value}` or `ms-{value}` (start)
  static Spacing ml(double value) => Spacing('ml-${_formatValue(value)}');
  static Spacing ms(double value) => Spacing('ms-${_formatValue(value)}');

  // --- Padding ---
  /// Padding on all sides. `p-{value}`
  static Spacing p(double value) => Spacing('p-${_formatValue(value)}');

  /// Padding on x-axis. `px-{value}`
  static Spacing px(double value) => Spacing('px-${_formatValue(value)}');

  /// Padding on y-axis. `py-{value}`
  static Spacing py(double value) => Spacing('py-${_formatValue(value)}');

  /// Padding on top. `pt-{value}`
  static Spacing pt(double value) => Spacing('pt-${_formatValue(value)}');

  /// Padding on right. `pr-{value}` or `pe-{value}` (end)
  static Spacing pr(double value) => Spacing('pr-${_formatValue(value)}');
  static Spacing pe(double value) => Spacing('pe-${_formatValue(value)}');

  /// Padding on bottom. `pb-{value}`
  static Spacing pb(double value) => Spacing('pb-${_formatValue(value)}');

  /// Padding on left. `pl-{value}` or `ps-{value}` (start)
  static Spacing pl(double value) => Spacing('pl-${_formatValue(value)}');
  static Spacing ps(double value) => Spacing('ps-${_formatValue(value)}');

  // Helper to format value for Tailwind class (e.g., 2.5 -> 2.5, 2.0 -> 2)
  static String _formatValue(double value) {
    if (value == value.truncate()) {
      return value.truncate().toString();
    }
    return value.toString();
  }

  // Predefined spacing values (examples)
  static const Spacing m0 = Spacing('m-0');
  static const Spacing m1 = Spacing('m-1');
  static const Spacing m2 = Spacing('m-2');
  static const Spacing m4 = Spacing('m-4');
  static const Spacing m6 = Spacing('m-6');
  static const Spacing m10 = Spacing('m-10');

  static const Spacing p0 = Spacing('p-0');
  static const Spacing p1 = Spacing('p-1');
  static const Spacing p2 = Spacing('p-2');
  static const Spacing p4 = Spacing('p-4');
  static const Spacing p6 = Spacing('p-6');
  static const Spacing p10 = Spacing('p-10');
}
