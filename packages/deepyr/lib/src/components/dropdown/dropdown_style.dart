import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'dropdown.dart';

/// Marker interface for any utility that can be passed to a [Dropdown]'s `modifiers` list.
abstract class DropdownStyling implements Styling {}

/// Defines specific styling and behavioral options for a [Dropdown] container component.
/// Implements the [DropdownStyling] interface.
///
/// This class is used to create concrete instances of dropdown-specific modifiers.
/// The static definitions for these modifiers (e.g., `Dropdown.top`) are typically
/// located within the `Dropdown` component class itself for easier discovery.
class DropdownStyle extends ComponentStyle<DropdownStyle>
    with Breakpoints<DropdownStyle>
    implements DropdownStyling {
  /// Constructs a [DropdownStyle].
  ///
  /// [cssClass]: The core CSS class string (e.g., "dropdown-top").
  /// [type]: The [StyleType] categorizing this modifier.
  /// [modifiers]: An optional list of [PrefixModifier]s already applied.
  const DropdownStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  @override
  DropdownStyle create(List<PrefixModifier> modifiers) {
    return DropdownStyle(cssClass, type: type, modifiers: modifiers);
  }
}
