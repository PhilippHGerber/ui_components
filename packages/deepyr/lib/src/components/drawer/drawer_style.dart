import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'drawer.dart';

/// A marker interface for any utility that can be passed to a [Drawer]'s `style` list.
///
/// This allows for type-safe application of styles, ensuring only relevant modifiers
/// like placement can be applied to the container.
abstract class DrawerStyling implements Styling {}

/// Defines specific styling, sizing, and behavioral options for a [Drawer] container component.
///
/// Implements the [DrawerStyling] interface, making it a valid type for the `style`
/// property of a [Drawer] component.
class DrawerStyle extends ComponentStyle<DrawerStyle>
    with Breakpoints<DrawerStyle>
    implements DrawerStyling {
  /// Constructs a [DrawerStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "drawer-end").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive or state-based styling.
  const DrawerStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [DrawerStyle] with the provided modifiers.
  /// This is an internal method used by the fluent API (`.at()`, `.on()`).
  @override
  DrawerStyle create(List<PrefixModifier> modifiers) {
    return DrawerStyle(cssClass, type: type, modifiers: modifiers);
  }
}

/// A type-safe representation of DaisyUI's custom `is-drawer-open:` and `is-drawer-close:`
/// variants. This allows for conditional styling of elements within a `DrawerSide`
/// based on the drawer's state, using pure CSS.
///
/// Use this with the `.when()` method on a `deepyr` style utility to create powerful,
/// state-aware styles without client-side logic.
///
/// ### Example:
/// ````dart
/// // This will generate the class "is-drawer-open:w-64"
/// Size.w64.when(DrawerIs.open)
///
/// // This will generate the class "is-drawer-close:hidden"
/// Layout.hidden.when(DrawerIs.close)
/// ````
enum DrawerIs implements PrefixModifier {
  /// The `is-drawer-open:` variant, for styles that apply when the drawer is open.
  open('is-drawer-open', PrefixModifierType.variant),

  /// The `is-drawer-close:` variant, for styles that apply when the drawer is closed.
  close('is-drawer-close', PrefixModifierType.variant);

  /// DrawerIs constructor
  const DrawerIs(this._prefix, this.type);

  final String _prefix;

  /// The type of prefix modifier.
  @override
  final PrefixModifierType type;

  /// The prefix string used in CSS class generation.
  @override
  String get prefix => '$_prefix:';
}
