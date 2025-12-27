import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart';

import 'styling.dart';
import 'ui_component_attributes.dart';
import 'ui_component_interface.dart';
import 'ui_component_logic_mixin.dart';
import 'ui_events.dart';

/// A private intermediate class that correctly combines the superclass, interface, and mixin.
///
/// This class exists to solve a Dart language constraint where a mixin's `on` clause
/// is checked against the superclass. By creating a class that `extends StatelessComponent`
/// and `implements UiComponentInterface` *before* applying the `with UiComponentLogicMixin`,
/// we satisfy the compiler's requirements in a clean, encapsulated way.
///
/// Concrete components will extend the public `UiComponent`, not this class.
@immutable
abstract class _UiComponentBase extends StatelessComponent implements UiComponentInterface {
  /// Creates the base for a stateless UI component.
  const _UiComponentBase({super.key});
}

/// The abstract base class for all **stateless** UI components in the `deepyr` library.
///
/// This class provides a common foundation for components that are purely presentational
/// and whose appearance is determined entirely by the properties passed to them.
///
/// It extends a private base class (`_UiComponentBase`) which handles the complex
/// task of combining the `StatelessComponent` superclass with the necessary
/// `UiComponentInterface` and `UiComponentLogicMixin`.
///
/// Concrete components extending [UiComponent] must implement:
/// 1. The [baseClass] getter.
/// 2. The `copyWith` method.
/// 3. The `configureAttributes` method (if needed).
@immutable
abstract class UiComponent extends _UiComponentBase with UiComponentLogicMixin {
  /// Creates the base for a stateless UI component.
  const UiComponent(
    this.children, {
    required this.tag,
    this.style,
    this.id,
    this.classes,
    this.css,
    Map<String, String>? attributes,
    this.child,
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
       eventHandlers = eventHandlers ?? const {},
       assert(
         !(child != null && children != null),
         'A component can have either a child or children, but not both.',
       );

  /// User-provided HTML attributes. These are merged with component-defined attributes,
  /// with these taking precedence in case of conflicts.
  final Map<String, String>? _userProvidedAttributes;

  @override
  final List<Component>? children;

  @override
  final Component? child;

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

  /// Gets the attributes directly provided by the user when the component was instantiated.
  /// Returns an empty map if no attributes were provided.
  @override
  @protected
  Map<String, String> get userProvidedAttributes =>
      _userProvidedAttributes ?? const <String, String>{};

  /// An abstract method that concrete components must implement to create a copy
  /// of themselves with new values.
  UiComponent copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  });

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    // Default implementation is empty.
  }

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: eventMap,
      children: children ?? [?child],
    );
  }
}
