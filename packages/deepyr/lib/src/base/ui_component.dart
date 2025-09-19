import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart';

import 'styling.dart';
import 'ui_component_attributes.dart';
import 'ui_events.dart';

// UtilityClassType might be needed if configureAttributes makes decisions based on modifier types
// import 'ui_utility_class_type.dart';

/// Base class for all UI components in the `deepyr` library.
///
/// This class provides common functionality for HTML tag rendering, styling (via CSS classes,
/// inline styles, and utility modifiers), attribute management, and event handling.
/// It is designed to be extended by concrete UI components like buttons, cards, etc.
///
/// Components extending [UiComponent] must implement the [baseClass] getter,
/// and can optionally override [configureAttributes] to define component-specific
/// HTML attributes.
@immutable
abstract class UiComponent extends StatelessComponent {
  /// Creates a [UiComponent].
  ///
  /// - [children] or [child]: The content to render within this component.
  ///   Only one of [children] or [child] should be provided.
  /// - [tag]: The HTML tag for the root element of this component (e.g., "div", "button").
  /// - [style]: A list of [Styling] instances (general or component-specific
  ///   utility classes) to apply for styling.
  /// - [id]: The HTML ID for the root element. This is passed directly to the underlying [DomComponent].
  /// - [classes]: A string of additional space-separated CSS classes to apply.
  /// - [css]: Inline CSS styles to apply to the root element.
  /// - [attributes]: A map of user-provided HTML attributes. These will be merged with
  ///   attributes configured by the component, with user-provided ones taking precedence.
  /// - Event handlers like [onClick], [onInput], etc., for common DOM events.
  /// - [eventHandlers]: A map for custom or less common event handlers.
  /// - [key]: A [Key] for Jaspr's reconciliation algorithm.
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
       eventHandlers = eventHandlers ?? const <String, List<UiEventHandler>>{},
       assert(
         !(child != null && children != null),
         'Either child or children must be provided, but not both.',
       );

  /// Creates a copy of this component with the given fields replaced with new values.
  ///
  /// This method is primarily used by container components (e.g., `Join`) to apply
  /// generic DOM attributes to their children programmatically.
  ///
  /// It intentionally omits component-specific properties (like `children`, `tag`,
  /// or the strongly-typed `style` list) to preserve the child's original
  /// identity and type safety. A parent should only modify a child's
  /// outer attributes, not its core content or specialized behavior.
  ///
  /// @param id The new HTML ID for the component.
  /// @param classes Additional CSS classes to **merge** with any existing classes.
  /// @param css The new inline CSS styles.
  /// @param attributes A new map of user-provided HTML attributes.
  /// @param key A new [Key] for Jaspr's reconciliation algorithm.
  ///
  /// @return A new instance of the component with the updated properties.
  UiComponent copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  });

  /// The HTML tag for the root element of this component.
  final String tag;

  /// A list of utility classes to apply for styling.
  /// These can be general utilities (like Spacing, Typography) or component-specific ones.
  final List<Styling>? style;

  /// The HTML ID for the root element.
  final String? id;

  /// Additional space-separated CSS classes to apply to the root element.
  final String? classes;

  /// Inline CSS styles for the root element.
  final Styles? css;

  /// User-provided HTML attributes. These are merged with component-defined attributes,
  /// with these taking precedence in case of conflicts.
  final Map<String, String>? _userProvidedAttributes;

  /// A single child component. Use this or [children], but not both.
  final Component? child;

  /// A list of child components. Use this or [child], but not both.
  final List<Component>? children;

  // --- Event Handlers ---
  /// Callback for the 'mouseenter' DOM event.
  final UiMouseEventHandler? onMouseEnter;

  /// Callback for the 'mouseleave' DOM event.
  final UiMouseEventHandler? onMouseLeave;

  /// Callback for the 'keydown' DOM event.
  final UiKeyboardEventHandler? onKeyDown;

  /// Callback for the 'keyup' DOM event.
  final UiKeyboardEventHandler? onKeyUp;

  /// Callback for the 'click' DOM event.
  final UiMouseEventHandler? onClick;

  /// Callback for the 'input' DOM event.
  final UiInputEventHandler? onInput;

  /// Callback for the 'change' DOM event.
  final UiInputEventHandler? onChange;

  /// A map for custom or less common event handlers.
  /// The key is the event name (e.g., "focus", "blur"), and the value is a list of handlers.
  final Map<String, List<UiEventHandler>> eventHandlers;

  /// Gets the base CSS class for this component (e.g., "btn" for a button).
  ///
  /// This class is fundamental to the component's DaisyUI styling.
  /// Must be implemented by concrete subclasses. If a component has no
  /// specific base class (e.g., a generic `<div>` wrapper), this can return an empty string.
  String get baseClass;

  /// Gets the attributes directly provided by the user when the component was instantiated.
  /// Returns an empty map if no attributes were provided.
  @protected
  Map<String, String> get userProvidedAttributes =>
      _userProvidedAttributes ?? const <String, String>{};

  /// Computes the combined string of CSS classes to be applied to the component.
  ///
  /// This includes the [baseClass], classes derived from [style],
  /// and any explicitly provided [classes].
  String get combinedClasses {
    // Convert each modifier in the list to its string representation (which includes prefixes)
    final utilityClasses = style?.map((Styling m) => m.toString()).join(' ') ?? '';
    return <String>[
      baseClass,
      utilityClasses,
      classes ?? '',
    ].where((String c) => c.isNotEmpty).join(' ');
  }

  /// Merges two CSS class strings, safely handling null or empty inputs.
  ///
  /// This utility is used internally by components (e.g., in `copyWith` or by
  /// a parent like `Join`) to add programmatic classes without overwriting
  /// any classes already provided by the user.
  @protected
  String? mergeClasses(String? originalClasses, String? newClasses) {
    if (originalClasses == null || originalClasses.isEmpty) {
      return newClasses;
    }
    if (newClasses == null || newClasses.isEmpty) {
      return originalClasses;
    }
    return '$originalClasses $newClasses';
  }

  /// Constructs the map of event handlers for the [DomComponent].
  Map<String, EventCallback> get events {
    final eventMap = <String, EventCallback>{};

    // Standard mouse events
    if (onMouseEnter != null) {
      eventMap['mouseenter'] = (dynamic rawEvent) => onMouseEnter!(rawEvent as MouseEvent);
    }
    if (onMouseLeave != null) {
      eventMap['mouseleave'] = (dynamic rawEvent) => onMouseLeave!(rawEvent as MouseEvent);
    }
    if (onClick != null) {
      eventMap['click'] = (dynamic rawEvent) => onClick!(rawEvent as MouseEvent);
    }

    // Standard keyboard events
    if (onKeyDown != null) {
      eventMap['keydown'] = (dynamic rawEvent) => onKeyDown!(rawEvent as KeyboardEvent);
    }
    if (onKeyUp != null) {
      eventMap['keyup'] = (dynamic rawEvent) => onKeyUp!(rawEvent as KeyboardEvent);
    }

    // Standard input/change events (assuming they pass a String value from Jaspr)
    if (onInput != null) {
      eventMap['input'] = (dynamic rawEvent) => onInput!(rawEvent as String);
    }
    if (onChange != null) {
      eventMap['change'] = (dynamic rawEvent) => onChange!(rawEvent as String);
    }

    // Custom event handlers
    for (final entry in eventHandlers.entries) {
      final eventName = entry.key;
      final handlers = entry.value;

      eventMap[eventName] = (dynamic rawEvent) {
        // Attempt to cast to a more specific event type based on common event names
        // This provides better type safety for handlers if they expect specific event properties.
        final event = switch (eventName) {
          'click' ||
          'mousedown' ||
          'mouseup' ||
          'mousemove' ||
          'mouseenter' ||
          'mouseleave' => rawEvent as MouseEvent,
          'keydown' || 'keyup' || 'keypress' => rawEvent as KeyboardEvent,
          'focus' || 'blur' => rawEvent as Event,
          'submit' => rawEvent as Event,
          'input' || 'change' => Event(rawEvent as String),
          _ => rawEvent as Event,
        };

        for (final handler in handlers) {
          handler(event);
        }
      };
    }
    return eventMap;
  }

  /// Configures component-specific HTML attributes.
  ///
  /// Subclasses should override this method to add their default or computed
  /// attributes (e.g., `role`, `type`, `aria-*`, `data-*`) using the provided
  /// [attributes] builder.
  ///
  /// This method is called internally when the [componentAttributes] getter is accessed.
  /// Attributes added here can be overridden by user-provided attributes.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void configureAttributes(UiComponentAttributes attributes) {
  ///   super.configureAttributes(attributes); // Good practice
  ///   attributes.addRole('button');
  ///   if (isToggle) {
  ///     attributes.addAria('pressed', isPressed.toString());
  ///   }
  /// }
  /// ```
  @protected
  void configureAttributes(UiComponentAttributes attributes) {
    // Base implementation is empty.
    // Subclasses override to add their specific attributes.
    // Consider calling super.configureAttributes(attributes) in overrides
    // if this base class ever adds default attributes.
  }

  /// Gets the map of HTML attributes for this component.
  /// (component-defined and user-provided).
  ///
  /// The `id` is handled separately and passed directly to [DomComponent].
  /// This getter orchestrates the collection of attributes by:
  /// 1. Calling [configureAttributes] to allow the component to define its specific attributes.
  /// 2. Merging any [_userProvidedAttributes], which will override any identically named
  ///    attributes set by [configureAttributes].
  Map<String, String> get componentAttributes {
    final builder = UiComponentAttributes();

    // 1. Allow the concrete component to configure its specific attributes.
    configureAttributes(builder);

    // 2. Merge user-provided attributes. These take precedence.
    if (_userProvidedAttributes != null) {
      builder.merge(_userProvidedAttributes);
    }

    return builder.build();
  }

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: events,
      children: children ?? [?child],
    );
  }
}
