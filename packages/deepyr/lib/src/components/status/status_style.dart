import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'status.dart';

/// A marker interface for any utility that can be passed to a [Status]'s `style` list.
///
/// This allows for type-safe application of styles for color and size.
abstract class StatusStyling implements Styling {}

/// Defines specific styling options for a [Status] component.
///
/// This is the concrete implementation class for status-specific modifiers.
/// It implements the [StatusStyling] interface, making it a valid type for the
/// `style` property of a [Status] component.
class StatusStyle extends ComponentStyle<StatusStyle>
    with Breakpoints<StatusStyle>
    implements StatusStyling {
  /// Constructs a [StatusStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "status-success").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const StatusStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [StatusStyle] with the provided modifiers.
  @override
  StatusStyle create(List<PrefixModifier> modifiers) {
    return StatusStyle(cssClass, type: type, modifiers: modifiers);
  }
}
