// Pseudo-class styling based on parent state
// Styling based on sibling state (peer-{modifier})
// https://tailwindcss.com/docs/hover-focus-and-other-states#styling-based-on-parent-state

import 'base_style.dart';

/// An enum representing the semantic category of a [PrefixModifier].
///
/// This is used internally to differentiate between various types of CSS prefixes,
/// such as min-width breakpoints (`md:`), max-width breakpoints (`max-md:`),
/// pseudo-classes (`hover:`), and others.
enum PrefixModifierType {
  /// A standard `min-width` breakpoint (e.g., `md:`), for styles that apply
  /// from a certain screen size and up.
  breakpoint,

  /// A `max-width` breakpoint (e.g., `max-md:`), for styles that apply only
  /// *up to* a certain screen size.
  maxWidthBreakpoint,

  /// A pseudo-class or pseudo-element (e.g., `hover:`, `focus:`, `::before`).
  pseudoClass,

  /// A color scheme variant, primarily for dark mode (e.g., `dark:`).
  darkMode,

  /// A feature or preference-based media query variant (e.g., `motion-reduce:`).
  variant,

  /// A device orientation variant (e.g., `portrait:`, `landscape:`).
  orientation,
}

/// Representing the Tailwind CSS prefix modifiers.
class PrefixModifier {
  const PrefixModifier(this._prefix, this.type);
  final String _prefix;
  final PrefixModifierType type;

  String get prefix => '$_prefix:';
}

enum Is implements PrefixModifier {
  /// `hover`
  hover('hover', PrefixModifierType.pseudoClass),

  /// `focus`
  focus('focus', PrefixModifierType.pseudoClass),

  /// `active`
  active('active', PrefixModifierType.pseudoClass),

  /// `first`
  first('first', PrefixModifierType.pseudoClass),

  /// `last`
  last('last', PrefixModifierType.pseudoClass),

  /// `odd`
  odd('odd', PrefixModifierType.pseudoClass),

  /// `even`
  even('even', PrefixModifierType.pseudoClass),

  /// `required`
  required('required', PrefixModifierType.pseudoClass),

  /// `invalid`
  invalid('invalid', PrefixModifierType.pseudoClass),

  /// `disabled`
  disabled('disabled', PrefixModifierType.pseudoClass),

  /// `::before`
  before('before', PrefixModifierType.pseudoClass),

  /// `::after`
  after('after', PrefixModifierType.pseudoClass),

  /// `::placeholder`
  placeholder('placeholder', PrefixModifierType.pseudoClass),

  /// `::file-selector-button`
  file('file', PrefixModifierType.pseudoClass),

  /// `::marker`
  marker('marker', PrefixModifierType.pseudoClass),

  /// `::selection`
  selection('selection', PrefixModifierType.pseudoClass),

  /// `::first-letter`
  firstLetter('first-letter', PrefixModifierType.pseudoClass),

  /// `::first-line`
  firstLine('first-line', PrefixModifierType.pseudoClass),

  /// `::backdrop`
  backdrop('backdrop', PrefixModifierType.pseudoClass);

  @override
  final String _prefix;

  @override
  final PrefixModifierType type;

  @override
  String get prefix => '$_prefix:';

  const Is(this._prefix, this.type);
}

// TODO Container queries @container @md:flex-row
// https://tailwindcss.com/docs/responsive-design#container-queries
enum Breakpoint implements PrefixModifier {
  /// `min-width: 640px`
  sm('sm', PrefixModifierType.breakpoint),

  /// `min-width: 768px`
  md('md', PrefixModifierType.breakpoint),

  /// `min-width: 1024px`
  lg('lg', PrefixModifierType.breakpoint),

  /// `min-width: 1280px`
  xl('xl', PrefixModifierType.breakpoint),

  /// `min-width: 1536px`
  xl2('2xl', PrefixModifierType.breakpoint);

  /// Breakpoint constructor
  const Breakpoint(this._prefix, this.type);

  @override
  final String _prefix;

  @override
  final PrefixModifierType type;

  @override
  String get prefix => '$_prefix:';
}

/// A mixin that provides convenience getters for applying responsive breakpoints
/// to a [BaseStyle] instance.
///
/// Example:
/// ```dart
/// final responsiveStyle = MyStyle().atSm;
/// ```
mixin Breakpoints<T extends BaseStyle<T>> on BaseStyle<T> {
  /// Applies the `sm` breakpoint.
  T get atSm => at(Breakpoint.sm);

  /// Applies the `md` breakpoint.
  T get atMd => at(Breakpoint.md);

  /// Applies the `lg` breakpoint.
  T get atLg => at(Breakpoint.lg);

  /// Applies the `xl` breakpoint.
  T get atXl => at(Breakpoint.xl);

  /// Applies the `2xl` breakpoint.
  T get at2xl => at(Breakpoint.xl2);
}

enum Media implements PrefixModifier {
  /// motion-reduce
  motionReduce('motion-reduce', PrefixModifierType.variant),

  /// motion-safe
  motionSafe('motion-safe', PrefixModifierType.variant),

  /// contrast-more
  contrastMore('contrast-more', PrefixModifierType.variant),

  /// contrast-less
  contrastLess('contrast-less', PrefixModifierType.variant),

  /// forced-colors
  forcedColors('forced-colors', PrefixModifierType.variant),

  // not-forced-colors
  notForcedColors('not-forced-colors', PrefixModifierType.variant),

  /// Landscape orientation
  landscape('landscape', PrefixModifierType.orientation),

  /// Portrait orientation
  portrait('portrait', PrefixModifierType.orientation),

  /// print
  print('print', PrefixModifierType.variant);

  const Media(this._prefix, this.type);

  // TODO @supports
  // https://tailwindcss.com/docs/hover-focus-and-other-states#supports

  // TODO @starting-style
  // https://tailwindcss.com/docs/hover-focus-and-other-states#starting-style

  @override
  final String _prefix;

  @override
  final PrefixModifierType type;

  @override
  String get prefix => '$_prefix:';
}
