import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart' show Component;

import 'styling.dart';
import 'ui_component_attributes.dart';
import 'ui_component_logic_mixin.dart' show UiComponentLogicMixin;
import 'ui_events.dart';

/// An abstract interface that defines the core contract for all UI components in the `deepyr` library.
///
/// This interface establishes a consistent set of properties and methods that both
/// stateless (`UiComponent`) and stateful (`StatefulUiComponent`) components must adhere to.
///
/// By implementing this interface, a component guarantees that it provides the necessary
/// data for the [UiComponentLogicMixin] to correctly compute classes, attributes, and events.
/// This pattern ensures maximum code reuse and type safety across the component hierarchy.
abstract interface class UiComponentInterface {
  /// The list of child components to be rendered within this component.
  List<Component>? get children;

  /// The HTML tag for the root element of this component (e.g., "div", "button").
  String get tag;

  /// A list of type-safe [Styling] instances (general or component-specific
  /// utility classes) to apply for styling.
  List<Styling>? get style;

  /// The HTML `id` for the root element.
  String? get id;

  /// A string of additional, space-separated CSS classes to apply directly.
  /// This is an escape hatch for utilities not yet abstracted by `deepyr`
  /// or for applying styles to primitive Jaspr components.
  String? get classes;

  /// A Jaspr [Styles] object for applying inline CSS to the root element.
  Styles? get css;

  /// A map of user-provided HTML attributes. These will be merged with
  /// attributes configured by the component, with user-provided ones taking precedence.
  Map<String, String> get userProvidedAttributes;

  /// A map for custom or less common event handlers.
  /// The key is the event name (e.g., "focus", "blur"), and the value is a list of handlers.
  Map<String, List<UiEventHandler>>? get eventHandlers;

  // Standard, common event handlers for convenience.
  UiMouseEventHandler? get onClick;
  UiInputEventHandler? get onInput;
  UiInputEventHandler? get onChange;
  UiMouseEventHandler? get onMouseEnter;
  UiMouseEventHandler? get onMouseLeave;
  UiKeyboardEventHandler? get onKeyDown;
  UiKeyboardEventHandler? get onKeyUp;

  /// Gets the base CSS class for this component (e.g., "btn" for a button).
  ///
  /// This class is fundamental to the component's DaisyUI styling.
  /// Must be implemented by concrete subclasses. If a component has no
  /// specific base class, this should return an empty string.
  String get baseClass;

  /// Configures component-specific HTML attributes.
  ///
  /// Subclasses must implement this method to add their default or computed
  /// attributes (e.g., `role`, `type`, `aria-*`) using the provided
  /// [attributes] builder. This method is called internally when computing
  /// the final attribute map for the component.
  void configureAttributes(UiComponentAttributes attributes);
}
