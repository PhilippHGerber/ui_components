import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'steps.dart';

// --- Marker Interfaces for Type Safety ---

/// A marker interface for any utility that can be passed to a [Steps]'s `style` list.
abstract class StepsStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [Step]'s `style` list.
abstract class StepStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [StepIcon]'s `style` list.
abstract class StepIconStyling implements Styling {}

// --- Concrete Style Classes ---

/// Defines specific layout options for a [Steps] container component.
class StepsStyle extends ComponentStyle<StepsStyle>
    with Breakpoints<StepsStyle>
    implements StepsStyling {
  /// Constructs a [StepsStyle].
  const StepsStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  @override
  StepsStyle create(List<PrefixModifier> modifiers) {
    return StepsStyle(cssClass, type: type, modifiers: modifiers);
  }
}

/// Defines specific color and state options for an individual [Step] component.
class StepStyle extends ComponentStyle<StepStyle>
    with Breakpoints<StepStyle>
    implements StepStyling {
  /// Constructs a [StepStyle].
  const StepStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  @override
  StepStyle create(List<PrefixModifier> modifiers) {
    return StepStyle(cssClass, type: type, modifiers: modifiers);
  }
}

/// Defines specific styling options for a [StepIcon] component.
/// This class exists for architectural consistency, as `StepIcon` currently has no unique modifiers.
class StepIconStyle extends ComponentStyle<StepIconStyle>
    with Breakpoints<StepIconStyle>
    implements StepIconStyling {
  /// Constructs a [StepIconStyle].
  const StepIconStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  @override
  StepIconStyle create(List<PrefixModifier> modifiers) {
    return StepIconStyle(cssClass, type: type, modifiers: modifiers);
  }
}
