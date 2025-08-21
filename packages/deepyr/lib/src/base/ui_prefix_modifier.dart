// Pseudo-class styling based on parent state
// Styling based on sibling state (peer-{modifier})
// https://tailwindcss.com/docs/hover-focus-and-other-states#styling-based-on-parent-state

import 'base_style.dart';

enum PrefixModifierType {
  breakpoint,
  pseudoClass,
  darkMode,
  variant,
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
  /// Hover pseudo-class
  hover('hover', PrefixModifierType.pseudoClass),

  /// Focus pseudo-class
  focus('focus', PrefixModifierType.pseudoClass),

  /// Active pseudo-class
  active('active', PrefixModifierType.pseudoClass),

  /// First pseudo-class
  first('first', PrefixModifierType.pseudoClass),

  /// Last pseudo-class
  last('last', PrefixModifierType.pseudoClass),

  /// Odd pseudo-class
  odd('odd', PrefixModifierType.pseudoClass),

  /// Even pseudo-class
  even('even', PrefixModifierType.pseudoClass),

  /// Form state required
  required('required', PrefixModifierType.pseudoClass),

  /// Form state invalid
  invalid('invalid', PrefixModifierType.pseudoClass),

  /// Form state disabled
  disabled('disabled', PrefixModifierType.pseudoClass),

  /// ::before pseudo-element
  before('before', PrefixModifierType.pseudoClass),

  /// ::after pseudo-element
  after('after', PrefixModifierType.pseudoClass),

  /// ::placeholder pseudo-element
  placeholder('placeholder', PrefixModifierType.pseudoClass),

  /// ::file
  file('file', PrefixModifierType.pseudoClass),

  /// ::marker
  marker('marker', PrefixModifierType.pseudoClass),

  /// ::selection
  selection('selection', PrefixModifierType.pseudoClass),

  /// ::first-letter
  firstLetter('first-letter', PrefixModifierType.pseudoClass),

  /// ::first-line
  firstLine('first-line', PrefixModifierType.pseudoClass),

  /// ::backdrop
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
  /// Small breakpoint
  sm('sm', PrefixModifierType.breakpoint),

  /// Medium breakpoint
  md('md', PrefixModifierType.breakpoint),

  /// Large breakpoint
  lg('lg', PrefixModifierType.breakpoint),

  /// Extra large breakpoint
  xl('xl', PrefixModifierType.breakpoint),

  /// 2xl breakpoint
  xl2('2xl', PrefixModifierType.breakpoint);

  @override
  final String _prefix;

  @override
  final PrefixModifierType type;

  @override
  String get prefix => '$_prefix:';

  const Breakpoint(this._prefix, this.type);
}

mixin Breakpoints<T extends BaseStyle<T>> on BaseStyle<T> {
  T get atSm => at(Breakpoint.sm);
  T get atMd => at(Breakpoint.md);
  T get atLg => at(Breakpoint.lg);
  T get atXl => at(Breakpoint.xl);
  T get at2xl => at(Breakpoint.xl2);
}

enum Theme implements PrefixModifier {
  /// Dark mode
  dark('dark', PrefixModifierType.darkMode);

  @override
  final String _prefix;

  @override
  final PrefixModifierType type;

  @override
  String get prefix => '$_prefix:';

  const Theme(this._prefix, this.type);
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

  const Media(this._prefix, this.type);
}
