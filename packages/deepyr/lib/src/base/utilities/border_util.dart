import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// A utility class for applying border styles.
///
/// This includes utilities for setting border width, color, style, and radius.
class BorderUtil extends CommonStyle<BorderUtil> {
  const BorderUtil(super.cssClass, {super.modifiers}) : super(type: StyleType.border);

  @override
  BorderUtil create(List<PrefixModifier> modifiers) {
    return BorderUtil(cssClass, modifiers: modifiers);
  }

  // --- Border Width ---
  /// `border-width: 1px`. The most common border.
  static const BorderUtil border = BorderUtil('border');

  /// `border-width: 0px`.
  static const BorderUtil border0 = BorderUtil('border-0');

  /// `border-width: 2px`.
  static const BorderUtil border2 = BorderUtil('border-2');

  /// `border-width: 4px`.
  static const BorderUtil border4 = BorderUtil('border-4');

  /// `border-width: 8px`.
  static const BorderUtil border8 = BorderUtil('border-8');

  // --- Border Color (From DaisyUI Theme) ---
  /// `border-color: primary`.
  static const BorderUtil primary = BorderUtil('border-primary');

  /// `border-color: primary-content`.
  static const BorderUtil primaryContent = BorderUtil('border-primary-content');

  /// `border-color: secondary`.
  static const BorderUtil secondary = BorderUtil('border-secondary');

  /// `border-color: accent`.
  static const BorderUtil accent = BorderUtil('border-accent');

  /// `border-color: neutral`.
  static const BorderUtil neutral = BorderUtil('border-neutral');

  /// `border-color: base-100`.
  static const BorderUtil base100 = BorderUtil('border-base-100');

  /// `border-color: base-200`.
  static const BorderUtil base200 = BorderUtil('border-base-200');

  /// `border-color: base-300`. **This is the one you asked about.**
  static const BorderUtil base300 = BorderUtil('border-base-300');

  /// `border-color: info`.
  static const BorderUtil info = BorderUtil('border-info');

  /// `border-color: success`.
  static const BorderUtil success = BorderUtil('border-success');

  /// `border-color: warning`.
  static const BorderUtil warning = BorderUtil('border-warning');

  /// `border-color: error`.
  static const BorderUtil error = BorderUtil('border-error');

  // --- Border Style ---
  /// `border-style: solid`.
  static const BorderUtil solid = BorderUtil('border-solid');

  /// `border-style: dashed`.
  static const BorderUtil dashed = BorderUtil('border-dashed');

  /// `border-style: dotted`.
  static const BorderUtil dotted = BorderUtil('border-dotted');

  /// `border-style: double`.
  static const BorderUtil double = BorderUtil('border-double');

  /// `border-style: none`.
  static const BorderUtil none = BorderUtil('border-none');

  // Note: Border radius is correctly handled by the `Effects` utility
  // (e.g., `Effects.rounded`, `Effects.roundedBox`) as it relates to
  // clipping and visual effects, not just the border property itself.
}
