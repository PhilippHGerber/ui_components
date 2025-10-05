import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// A utility class for applying font-specific styles.
///
/// This includes utilities for setting font family, weight, style, smoothing,
/// numeric variants, and letter spacing.
class FontUtil extends CommonStyle<FontUtil> {
  const FontUtil(super.cssClass, {super.modifiers}) : super(type: StyleType.typography);
  @override
  FontUtil create(List<PrefixModifier> modifiers) {
    return FontUtil(cssClass, modifiers: modifiers);
  }

  // --- Font Family ---
  /// Use the default sans-serif font family. `font-sans`
  static const FontUtil sans = FontUtil('font-sans');

  /// Use the default serif font family. `font-serif`
  static const FontUtil serif = FontUtil('font-serif');

  /// Use the default monospace font family. `font-mono`
  static const FontUtil mono = FontUtil('font-mono');

  // --- Font Smoothing ---
  /// Renders text with anti-aliasing. `antialiased`
  static const FontUtil antialiased = FontUtil('antialiased');

  /// Renders text with subpixel anti-aliasing. `subpixel-antialiased`
  static const FontUtil subpixelAntialiased = FontUtil('subpixel-antialiased');

  // --- Font Weight ---
  /// `font-weight: 100`
  static const FontUtil thin = FontUtil('font-thin');

  /// `font-weight: 200`
  static const FontUtil extralight = FontUtil('font-extralight');

  /// `font-weight: 300`
  static const FontUtil light = FontUtil('font-light');

  /// `font-weight: 400`
  static const FontUtil normal = FontUtil('font-normal');

  /// `font-weight: 500`
  static const FontUtil medium = FontUtil('font-medium');

  /// `font-weight: 600`
  static const FontUtil semibold = FontUtil('font-semibold');

  /// `font-weight: 700`
  static const FontUtil bold = FontUtil('font-bold');

  /// `font-weight: 800`
  static const FontUtil extrabold = FontUtil('font-extrabold');

  /// `font-weight: 900`
  static const FontUtil black = FontUtil('font-black');

  // --- Font Style ---
  /// `font-style: italic`
  static const FontUtil italic = FontUtil('italic');

  /// `font-style: normal`
  static const FontUtil notItalic = FontUtil('not-italic');

  // --- Font Variant Numeric ---
  /// Disables all numeric font variants. `normal-nums`
  static const FontUtil normalNums = FontUtil('normal-nums');

  /// Enables ordinal markers (e.g., 1st, 2nd). `ordinal`
  static const FontUtil ordinal = FontUtil('ordinal');

  /// Enables slashed zeros to distinguish from 'O'. `slashed-zero`
  static const FontUtil slashedZero = FontUtil('slashed-zero');

  /// Enables lining figures (uniform height). `lining-nums`
  static const FontUtil liningNums = FontUtil('lining-nums');

  /// Enables old-style figures (variable height). `oldstyle-nums`
  static const FontUtil oldstyleNums = FontUtil('oldstyle-nums');

  /// Enables proportional figures (variable width). `proportional-nums`
  static const FontUtil proportionalNums = FontUtil('proportional-nums');

  /// Enables tabular figures (uniform width). `tabular-nums`
  static const FontUtil tabularNums = FontUtil('tabular-nums');

  /// Enables diagonal fractions. `diagonal-fractions`
  static const FontUtil diagonalFractions = FontUtil('diagonal-fractions');

  /// Enables stacked fractions. `stacked-fractions`
  static const FontUtil stackedFractions = FontUtil('stacked-fractions');

  // --- Letter Spacing (Tracking) ---
  /// `letter-spacing: -0.05em`
  static const FontUtil trackingTighter = FontUtil('tracking-tighter');

  /// `letter-spacing: -0.025em`
  static const FontUtil trackingTight = FontUtil('tracking-tight');

  /// `letter-spacing: 0em`
  static const FontUtil trackingNormal = FontUtil('tracking-normal');

  /// `letter-spacing: 0.025em`
  static const FontUtil trackingWide = FontUtil('tracking-wide');

  /// `letter-spacing: 0.05em`
  static const FontUtil trackingWider = FontUtil('tracking-wider');

  /// `letter-spacing: 0.1em`
  static const FontUtil trackingWidest = FontUtil('tracking-widest');
}
