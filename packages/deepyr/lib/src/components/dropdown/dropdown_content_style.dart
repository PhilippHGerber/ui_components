import '../../base/component_style.dart';
import '../../base/style_type.dart' show StyleType;
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'dropdown.dart';

/// Marker interface for any utility that can be passed to a [DropdownContent]'s `modifiers` list.
abstract class DropdownContentStyling implements Styling {}

/// Defines specific styling options for a [DropdownContent] component,
/// such as styling it as a menu or a card.
/// Implements the [DropdownContentStyling] interface.
///
/// This class is used to create concrete instances of dropdown content-specific modifiers.
/// Static definitions for common patterns (e.g., `DropdownContent.menu`) are typically
/// found within the `DropdownContent` component class.
class DropdownContentStyle extends ComponentStyle<DropdownContentStyle>
    with Breakpoints<DropdownContentStyle>
    implements DropdownContentStyling {
  /// Constructs a [DropdownContentStyle].
  ///
  /// [cssClass]: The core CSS class string (e.g., "menu").
  /// [type]: The [StyleType] categorizing this modifier.
  /// [modifiers]: An optional list of [PrefixModifier]s already applied.
  const DropdownContentStyle(super.cssClass,
      {required super.type, super.modifiers});

  @override
  DropdownContentStyle create(List<PrefixModifier> modifiers) {
    return DropdownContentStyle(cssClass, type: type, modifiers: modifiers);
  }
}
