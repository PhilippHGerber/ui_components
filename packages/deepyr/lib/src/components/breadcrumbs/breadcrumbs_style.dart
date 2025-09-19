import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'breadcrumbs.dart';

/// A marker interface for any utility that can be passed to a [Breadcrumbs]'
/// `style` list.
///
/// This allows for type-safe application of styles. `Breadcrumbs` has no specific
/// modifiers of its own, so this interface is primarily used to allow general
/// utilities (like `TextUtil`) to be applied.
abstract class BreadcrumbsStyling implements Styling {}

/// Defines specific styling options for a [Breadcrumbs] component.
///
/// This is the concrete implementation class for breadcrumbs-specific modifiers.
/// It implements the [BreadcrumbsStyling] interface. Currently, there are no
/// predefined static modifiers for `Breadcrumbs`, but this class provides a
/// consistent and extensible structure.
class BreadcrumbsStyle extends ComponentStyle<BreadcrumbsStyle>
    with Breakpoints<BreadcrumbsStyle>
    implements BreadcrumbsStyling {
  /// Constructs a [BreadcrumbsStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier.
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const BreadcrumbsStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [BreadcrumbsStyle] with the provided modifiers.
  @override
  BreadcrumbsStyle create(List<PrefixModifier> modifiers) {
    return BreadcrumbsStyle(cssClass, type: type, modifiers: modifiers);
  }
}
