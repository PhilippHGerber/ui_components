import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'fieldset.dart';

/// A marker interface for any utility that can be passed to a [Fieldset]'s
/// `style` list.
///
/// This allows for type-safe application of styles. `Fieldset` currently has
/// no specific modifiers, so this is used for applying general utilities.
abstract class FieldsetStyling implements Styling {}

/// Defines specific styling options for a [Fieldset] component.
///
/// This is the concrete implementation class for fieldset-specific modifiers.
/// It implements the [FieldsetStyling] interface. Currently, there are no
/// predefined static modifiers for `Fieldset`.
class FieldsetStyle extends ComponentStyle<FieldsetStyle>
    with Breakpoints<FieldsetStyle>
    implements FieldsetStyling {
  /// Constructs a [FieldsetStyle].
  const FieldsetStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [FieldsetStyle] with the provided modifiers.
  @override
  FieldsetStyle create(List<PrefixModifier> modifiers) {
    return FieldsetStyle(cssClass, type: type, modifiers: modifiers);
  }
}

/// A marker interface for any utility that can be passed to a [Legend]'s
/// `style` list.
abstract class LegendStyling implements Styling {}

/// Defines specific styling options for a [Legend] component.
///
/// This is the concrete implementation class for legend-specific modifiers.
/// It implements the [LegendStyling] interface. Currently, there are no
/// predefined static modifiers for `Legend`.
class LegendStyle extends ComponentStyle<LegendStyle>
    with Breakpoints<LegendStyle>
    implements LegendStyling {
  /// Constructs a [LegendStyle].
  const LegendStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [LegendStyle] with the provided modifiers.
  @override
  LegendStyle create(List<PrefixModifier> modifiers) {
    return LegendStyle(cssClass, type: type, modifiers: modifiers);
  }
}
