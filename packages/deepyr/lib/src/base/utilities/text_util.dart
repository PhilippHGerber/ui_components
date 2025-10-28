import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';
import 'font_util.dart'; // Though not directly used, it's good context.

/// A utility class for applying text-specific styles, focusing on appearance and layout.
///
/// This class provides a comprehensive, type-safe API for controlling properties
/// like font size, text alignment, color, decoration, transformation, and line height.
/// It is designed to be used in the `style` list of any `deepyr` component.
///
/// For properties related to the font face itself, such as font family, weight,
/// and letter spacing, please use the [FontUtil] class.
class TextUtil extends CommonStyle<TextUtil> {
  /// Creates a [TextUtil] instance.
  ///
  /// This constructor is used internally by the static constants.
  const TextUtil(super.cssClass, {super.modifiers}) : super(type: StyleType.typography);

  /// Creates a new instance of [TextUtil] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  TextUtil create(List<PrefixModifier> modifiers) {
    return TextUtil(cssClass, modifiers: modifiers);
  }

  // --- Font Size ---
  // Controls the font size of an element.
  // See: https://tailwindcss.com/docs/font-size

  /// `font-size: 0.75rem` (12px)
  static const TextUtil xs = TextUtil('text-xs');

  /// `font-size: 0.875rem` (14px)
  static const TextUtil sm = TextUtil('text-sm');

  /// `font-size: 1rem` (16px). This is often the default.
  static const TextUtil base = TextUtil('text-base');

  /// `font-size: 1.125rem` (18px)
  static const TextUtil lg = TextUtil('text-lg');

  /// `font-size: 1.25rem` (20px)
  static const TextUtil xl = TextUtil('text-xl');

  /// `font-size: 1.5rem` (24px)
  static const TextUtil xl2 = TextUtil('text-2xl');

  /// `font-size: 1.875rem` (30px)
  static const TextUtil xl3 = TextUtil('text-3xl');

  /// `font-size: 2.25rem` (36px)
  static const TextUtil xl4 = TextUtil('text-4xl');

  /// `font-size: 3rem` (48px)
  static const TextUtil xl5 = TextUtil('text-5xl');

  /// `font-size: 3.75rem` (60px)
  static const TextUtil xl6 = TextUtil('text-6xl');

  /// `font-size: 4.5rem` (72px)
  static const TextUtil xl7 = TextUtil('text-7xl');

  /// `font-size: 6rem` (96px)
  static const TextUtil xl8 = TextUtil('text-8xl');

  /// `font-size: 8rem` (128px)
  static const TextUtil xl9 = TextUtil('text-9xl');

  // --- Text Alignment ---
  // Controls the horizontal alignment of text.
  // See: https://tailwindcss.com/docs/text-align

  /// `text-align: left`
  static const TextUtil left = TextUtil('text-left');

  /// `text-align: center`
  static const TextUtil center = TextUtil('text-center');

  /// `text-align: right`
  static const TextUtil right = TextUtil('text-right');

  /// `text-align: justify`
  static const TextUtil justify = TextUtil('text-justify');

  /// `text-align: start`. Aligns text to the start based on the writing direction (left in LTR, right in RTL).
  static const TextUtil start = TextUtil('text-start');

  /// `text-align: end`. Aligns text to the end based on the writing direction (right in LTR, left in RTL).
  static const TextUtil end = TextUtil('text-end');

  // --- Text Decoration ---
  // Controls the decoration of text.
  // See: https://tailwindcss.com/docs/text-decoration

  /// `text-decoration-line: underline`
  static const TextUtil underline = TextUtil('underline');

  /// `text-decoration-line: overline`
  static const TextUtil overline = TextUtil('overline');

  /// `text-decoration-line: line-through`
  static const TextUtil lineThrough = TextUtil('line-through');

  /// `text-decoration-line: none`
  static const TextUtil noUnderline = TextUtil('no-underline');

  // --- Text Transform ---
  // Controls the capitalization of text.
  // See: https://tailwindcss.com/docs/text-transform

  /// `text-transform: uppercase`
  static const TextUtil uppercase = TextUtil('uppercase');

  /// `text-transform: lowercase`
  static const TextUtil lowercase = TextUtil('lowercase');

  /// `text-transform: capitalize`
  static const TextUtil capitalize = TextUtil('capitalize');

  /// `text-transform: none`
  static const TextUtil normalCase = TextUtil('normal-case');

  // --- Line Height (Leading) ---
  // Controls the vertical spacing between lines of text.
  // See: https://tailwindcss.com/docs/line-height

  /// `line-height: 1`
  static const TextUtil leadingNone = TextUtil('leading-none');

  /// `line-height: 1.25`
  static const TextUtil leadingTight = TextUtil('leading-tight');

  /// `line-height: 1.375`
  static const TextUtil leadingSnug = TextUtil('leading-snug');

  /// `line-height: 1.5`
  static const TextUtil leadingNormal = TextUtil('leading-normal');

  /// `line-height: 1.625`
  static const TextUtil leadingRelaxed = TextUtil('leading-relaxed');

  /// `line-height: 2`
  static const TextUtil leadingLoose = TextUtil('leading-loose');

  // --- Text Colors (Theme-based) ---
  /// Applies white color to text. `text-white`
  static const TextUtil white = TextUtil('text-white');

  /// Applies black color to text. `text-black`
  static const TextUtil black = TextUtil('text-black');

  /// Applies the primary theme color to text. `text-primary`
  static const TextUtil primary = TextUtil('text-primary');

  /// Applies the primary content color, for text on a primary background. `text-primary-content`
  static const TextUtil primaryContent = TextUtil('text-primary-content');

  /// Applies the secondary theme color to text. `text-secondary`
  static const TextUtil secondary = TextUtil('text-secondary');

  /// Applies the secondary content color. `text-secondary-content`
  static const TextUtil secondaryContent = TextUtil('text-secondary-content');

  /// Applies the accent theme color to text. `text-accent`
  static const TextUtil accent = TextUtil('text-accent');

  /// Applies the accent content color. `text-accent-content`
  static const TextUtil accentContent = TextUtil('text-accent-content');

  /// Applies the neutral theme color to text. `text-neutral`
  static const TextUtil neutral = TextUtil('text-neutral');

  /// Applies the neutral content color. `text-neutral-content`
  static const TextUtil neutralContent = TextUtil('text-neutral-content');

  /// Applies the base-100 theme color to text. `text-base-100`
  static const TextUtil base100 = TextUtil('text-base-100');

  /// Applies the base-200 theme color to text. `text-base-200`
  static const TextUtil base200 = TextUtil('text-base-200');

  /// Applies the base-300 theme color to text. `text-base-300`
  static const TextUtil base300 = TextUtil('text-base-300');

  /// Applies the base content color, for text on a base background. `text-base-content`
  static const TextUtil baseContent = TextUtil('text-base-content');

  /// Applies the info theme color to text. `text-info`
  static const TextUtil info = TextUtil('text-info');

  /// Applies the info content color. `text-info-content`
  static const TextUtil infoContent = TextUtil('text-info-content');

  /// Applies the success theme color to text. `text-success`
  static const TextUtil success = TextUtil('text-success');

  /// Applies the success content color. `text-success-content`
  static const TextUtil successContent = TextUtil('text-success-content');

  /// Applies the warning theme color to text. `text-warning`
  static const TextUtil warning = TextUtil('text-warning');

  /// Applies the warning content color. `text-warning-content`
  static const TextUtil warningContent = TextUtil('text-warning-content');

  /// Applies the error theme color to text. `text-error`
  static const TextUtil error = TextUtil('text-error');

  /// Applies the error content color. `text-error-content`
  static const TextUtil errorContent = TextUtil('text-error-content');
}
