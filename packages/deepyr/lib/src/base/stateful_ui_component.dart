import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart';

import 'styling.dart';
import 'ui_component_attributes.dart';
import 'ui_component_interface.dart';
import 'ui_component_logic_mixin.dart';
import 'ui_events.dart';

/// The abstract base class for all **stateful** UI components in the `deepyr` library.
///
/// This class holds the immutable properties for a stateful component (the "widget" part).
/// It implements [UiComponentInterface] to guarantee a consistent API with its stateless
/// counterpart, `UiComponent`. The actual logic, mutable state, and rendering are handled
/// by a corresponding [StatefulUiComponentState] class.
abstract class StatefulUiComponent extends StatefulComponent implements UiComponentInterface {
  /// Creates the base for a stateful UI component.
  ///
  const StatefulUiComponent(
    this.children, {
    required this.tag,
    this.style,
    this.id,
    this.classes,
    this.css,
    Map<String, String>? attributes,
    this.onMouseEnter,
    this.onMouseLeave,
    this.onKeyDown,
    this.onKeyUp,
    this.onClick,
    this.onInput,
    this.onChange,
    Map<String, List<UiEventHandler>>? eventHandlers,
    super.key,
  }) : _userProvidedAttributes = attributes,
       eventHandlers = eventHandlers ?? const {};

  // Store attributes internally
  final Map<String, String>? _userProvidedAttributes;

  // UiComponentInterface Properties (Identical to stateless version)
  @override
  final List<Component>? children;
  @override
  final String tag;
  @override
  final List<Styling>? style;
  @override
  final String? id;
  @override
  final String? classes;
  @override
  final Styles? css;
  // Expose via the Interface getter
  @override
  Map<String, String> get userProvidedAttributes => _userProvidedAttributes ?? const {};
  @override
  final Map<String, List<UiEventHandler>> eventHandlers;
  @override
  final UiMouseEventHandler? onMouseEnter;
  @override
  final UiMouseEventHandler? onMouseLeave;
  @override
  final UiKeyboardEventHandler? onKeyDown;
  @override
  final UiKeyboardEventHandler? onKeyUp;
  @override
  final UiMouseEventHandler? onClick;
  @override
  final UiInputEventHandler? onInput;
  @override
  final UiInputEventHandler? onChange;

  @override
  void configureAttributes(UiComponentAttributes attributes) {}

  @override
  String get baseClass;
}

/// A private intermediate base class that bridges `State<T>` with `UiComponentInterface`.
///
/// This class is the key to solving the mixin constraint. It extends `State<T>`
/// and implements `UiComponentInterface` by delegating all property getters to
/// the `component` (the widget).
///
/// Because this class fulfills the `UiComponentInterface` contract, the `UiComponentLogicMixin`
/// can then be safely applied to any class that extends this one.
abstract class _StatefulUiComponentStateBase<T extends StatefulUiComponent> extends State<T>
    implements UiComponentInterface {
  // Delegate all Interface calls to the 'component' property provided by State<T>
  @override
  List<Component>? get children => component.children;
  @override
  String get tag => component.tag;
  @override
  List<Styling>? get style => component.style;
  @override
  String? get id => component.id;
  @override
  String? get classes => component.classes;
  @override
  Styles? get css => component.css;
  @override
  Map<String, String> get userProvidedAttributes => component.userProvidedAttributes;
  @override
  Map<String, List<UiEventHandler>> get eventHandlers => component.eventHandlers;
  @override
  UiMouseEventHandler? get onMouseEnter => component.onMouseEnter;
  @override
  UiMouseEventHandler? get onMouseLeave => component.onMouseLeave;
  @override
  UiKeyboardEventHandler? get onKeyDown => component.onKeyDown;
  @override
  UiKeyboardEventHandler? get onKeyUp => component.onKeyUp;
  @override
  UiMouseEventHandler? get onClick => component.onClick;
  @override
  UiInputEventHandler? get onInput => component.onInput;
  @override
  UiInputEventHandler? get onChange => component.onChange;
}

/// The base `State` class for a [StatefulUiComponent].
///
/// This class contains the actual implementation logic for stateful components.
/// Concrete state classes (e.g., `_SwapState`) should extend this class instead of
/// Jaspr's `State` directly.
///
/// It extends the `_StatefulUiComponentStateBase` and now correctly applies the
/// `UiComponentLogicMixin` *after* the interface contract has been satisfied,
/// inheriting all the shared computational logic.
abstract class StatefulUiComponentState<T extends StatefulUiComponent>
    extends _StatefulUiComponentStateBase<T>
    with UiComponentLogicMixin {
  @override
  void configureAttributes(UiComponentAttributes attributes) {
    component.configureAttributes(attributes);
  }

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses, // Calculated by Mixin
      styles: css,
      attributes: componentAttributes, // Calculated by Mixin
      events: eventMap, // Calculated by Mixin
      children: children,
    );
  }
}
