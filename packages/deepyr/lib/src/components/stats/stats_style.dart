import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'stats.dart';

// Marker Interfaces for Type Safety

/// A marker interface for any utility that can be passed to a [Stats]'s `style` list.
abstract class StatsStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [Stat]'s `style` list.
abstract class StatStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [StatFigure]'s `style` list.
abstract class StatFigureStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [StatTitle]'s `style` list.
abstract class StatTitleStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [StatValue]'s `style` list.
abstract class StatValueStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [StatDesc]'s `style` list.
abstract class StatDescStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [StatActions]'s `style` list.
abstract class StatActionsStyling implements Styling {}

// Concrete Style Class (Only for Stats, as it has unique modifiers)

/// Defines specific layout options for a [Stats] container component.
class StatsStyle extends ComponentStyle<StatsStyle>
    with Breakpoints<StatsStyle>
    implements StatsStyling {
  /// Constructs a [StatsStyle].
  const StatsStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  @override
  StatsStyle create(List<PrefixModifier> modifiers) {
    return StatsStyle(cssClass, type: type, modifiers: modifiers);
  }
}
