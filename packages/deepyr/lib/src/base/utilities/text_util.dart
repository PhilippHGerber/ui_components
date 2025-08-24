import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

class TextUtil extends CommonStyle<TextUtil> {
  const TextUtil(super.cssClass, {super.modifiers})
      : super(type: StyleType.typography);

  // --- Font Size ---
  // https://tailwindcss.com/docs/font-size
  static const TextUtil xs = TextUtil('text-xs');
  static const TextUtil sm = TextUtil('text-sm');
  static const TextUtil base = TextUtil('text-base');
  static const TextUtil lg = TextUtil('text-lg');
  static const TextUtil xl = TextUtil('text-xl');
  static const TextUtil xl2 = TextUtil('text-2xl');
  static const TextUtil xl3 = TextUtil('text-3xl');
  static const TextUtil xl4 = TextUtil('text-4xl');
  static const TextUtil xl5 = TextUtil('text-5xl');
  static const TextUtil xl6 = TextUtil('text-6xl');
  static const TextUtil xl7 = TextUtil('text-7xl');
  static const TextUtil xl8 = TextUtil('text-8xl');
  static const TextUtil xl9 = TextUtil('text-9xl');

  // --- Font Weight ---
  // Todo move to FontUtil
  // https://tailwindcss.com/docs/font-weight
  static const TextUtil thin = TextUtil('font-thin'); // 100
  static const TextUtil extralight = TextUtil('font-extralight'); // 200
  static const TextUtil light = TextUtil('font-light'); // 300
  static const TextUtil normal = TextUtil('font-normal'); // 400 (Default)
  static const TextUtil medium = TextUtil('font-medium'); // 500
  static const TextUtil semibold = TextUtil('font-semibold'); // 600
  static const TextUtil bold = TextUtil('font-bold'); // 700
  static const TextUtil extrabold = TextUtil('font-extrabold'); // 800
  static const TextUtil black = TextUtil('font-black'); // 900

  // --- Text Alignment ---
  // https://tailwindcss.com/docs/text-align
  static const TextUtil left = TextUtil('text-left');
  static const TextUtil center = TextUtil('text-center');
  static const TextUtil right = TextUtil('text-right');
  static const TextUtil justify = TextUtil('text-justify');
  // Respects LTR/RTL
  static const TextUtil start = TextUtil('text-start');
  // Respects LTR/RTL
  static const TextUtil end = TextUtil('text-end');

  // --- Text Decoration ---
  /// `text-decoration-line: underline`
  static const TextUtil underline = TextUtil('underline');

  /// `text-decoration-line: overline`
  static const TextUtil overline = TextUtil('overline');

  /// `text-decoration-line: line-through`
  static const TextUtil lineThrough = TextUtil('line-through');

  /// `text-decoration-line: none`
  static const TextUtil noUnderline = TextUtil(
    'no-underline',
  ); // Effectively text-decoration: none

  // --- Text Transform ---
  /// `text-transform: uppercase`
  static const TextUtil uppercase = TextUtil('uppercase');

  /// `text-transform: lowercase`
  static const TextUtil lowercase = TextUtil('lowercase');

  /// `text-transform: capitalize`
  static const TextUtil capitalize = TextUtil('capitalize');

  /// `text-transform: none`
  static const TextUtil normalCase = TextUtil('normal-case');

  // Aliases for common text colors
  static const TextUtil primary = TextUtil('text-primary');
  static const TextUtil primaryContent = TextUtil('text-primary-content');
  static const TextUtil secondary = TextUtil('text-secondary');
  static const TextUtil secondaryContent = TextUtil('text-secondary-content');
  static const TextUtil accent = TextUtil('text-accent');
  static const TextUtil accentContent = TextUtil('text-accent-content');
  static const TextUtil neutral = TextUtil('text-neutral');
  static const TextUtil neutralContent = TextUtil('text-neutral-content');
  static const TextUtil base100 = TextUtil('text-base-100');
  static const TextUtil base200 = TextUtil('text-base-200');
  static const TextUtil base300 = TextUtil('text-base-300');
  static const TextUtil baseContent = TextUtil('text-base-content');
  static const TextUtil info = TextUtil('text-info');
  static const TextUtil infoContent = TextUtil('text-info-content');
  static const TextUtil success = TextUtil('text-success');
  static const TextUtil successContent = TextUtil('text-success-content');
  static const TextUtil warning = TextUtil('text-warning');
  static const TextUtil warningContent = TextUtil('text-warning-content');
  static const TextUtil error = TextUtil('text-error');
  static const TextUtil errorContent = TextUtil('text-error-content');

  // TODO: Add utilities for text opacity, font smoothing, font style (italic), font variant numeric,
  // letter spacing, line height, list style type/position, text decoration color/style/thickness,
  // text underline offset, text overflow, text indent, vertical align, whitespace, word break, hyphens, content.

  @override
  TextUtil create(List<PrefixModifier> modifiers) {
    // Create a new instance with the original cssClass and new modifiers
    return TextUtil(cssClass, modifiers: modifiers);
  }
}
