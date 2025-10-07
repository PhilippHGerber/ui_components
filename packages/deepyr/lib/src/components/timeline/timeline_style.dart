import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'timeline.dart';

/// A marker interface for any utility that can be passed to a [Timeline]'s `style` list.
///
/// This allows for type-safe application of styles for layout and behavior.
abstract class TimelineStyling implements Styling {}

/// Defines specific styling options for a [Timeline] container component.
///
/// This is the concrete implementation class for timeline-specific modifiers.
/// It implements the [TimelineStyling] interface, making it a valid type for the
/// `style` property of a [Timeline] component.
class TimelineStyle extends ComponentStyle<TimelineStyle>
    with Breakpoints<TimelineStyle>
    implements TimelineStyling {
  /// Constructs a [TimelineStyle].
  const TimelineStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  TimelineStyle create(List<PrefixModifier> modifiers) {
    return TimelineStyle(cssClass, type: type, modifiers: modifiers);
  }
}

/// A marker interface for any utility that can be passed to a [TimelineStart] or
/// [TimelineEnd] component's `style` list.
abstract class TimelineContentStyling implements Styling {}

/// Defines specific styling options for a [TimelineStart] or [TimelineEnd] component.
///
/// This class is used for modifiers like `timeline-box`.
class TimelineContentStyle extends ComponentStyle<TimelineContentStyle>
    with Breakpoints<TimelineContentStyle>
    implements TimelineContentStyling {
  /// Constructs a [TimelineContentStyle].
  const TimelineContentStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  TimelineContentStyle create(List<PrefixModifier> modifiers) {
    return TimelineContentStyle(cssClass, type: type, modifiers: modifiers);
  }
}
