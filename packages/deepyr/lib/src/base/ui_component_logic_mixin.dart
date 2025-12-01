import 'package:jaspr/jaspr.dart' show EventCallback;
import 'package:universal_web/web.dart' show Event, KeyboardEvent, MouseEvent;

import 'styling.dart';
import 'ui_component_attributes.dart';
import 'ui_component_interface.dart';

/// A mixin that provides the shared implementation logic for all `deepyr` UI components.
///
/// This mixin is constrained to classes that implement [UiComponentInterface],
/// guaranteeing that all required properties (like `style`, `classes`, `baseClass`, etc.)
/// are available for its methods. It handles the computation of the final CSS class string,
/// the merging of component-defined and user-provided attributes, and the construction
/// of the event handler map.
///
/// By centralizing this logic, we ensure consistency and avoid code duplication
/// between stateless and stateful components.
mixin UiComponentLogicMixin on UiComponentInterface {
  /// Computes the combined string of CSS classes to be applied to the component's root element.
  ///
  /// This method intelligently combines:
  /// 1. The component's `baseClass` (e.g., "btn").
  /// 2. All classes generated from the type-safe `style` list.
  /// 3. Any additional classes provided via the `classes` string property.
  String get combinedClasses {
    // Convert each Styling object in the list to its string representation (which includes prefixes).
    final utilityClasses = style?.map((Styling s) => s.toString()).join(' ') ?? '';
    // Combine all sources, filtering out any empty strings to produce clean output.
    return [
      baseClass,
      utilityClasses,
      classes ?? '',
    ].where((String c) => c.isNotEmpty).join(' ');
  }

  /// Gets the final map of HTML attributes for the component.
  Map<String, String> get componentAttributes {
    final builder = UiComponentAttributes();

    // 1. Allow the concrete component to configure its specific attributes.
    configureAttributes(builder);

    // 2. Merge user-provided attributes.
    if (userProvidedAttributes.isNotEmpty) {
      builder.merge(userProvidedAttributes);
    }

    return builder.build();
  }

  /// Constructs the map of event handlers for the underlying `DomComponent`.
  ///
  /// This method combines the convenient, strongly-typed event callbacks (like `onClick`)
  /// with the flexible `eventHandlers` map into a single map that Jaspr can use.
  Map<String, EventCallback> get eventMap {
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

    // Standard input/change events
    if (onInput != null) {
      eventMap['input'] = (dynamic rawEvent) => onInput!(rawEvent as String);
    }
    if (onChange != null) {
      eventMap['change'] = (dynamic rawEvent) => onChange!(rawEvent as String);
    }

    // Custom event handlers
    if (eventHandlers != null && eventHandlers!.isNotEmpty) {
      final eventEntries = eventHandlers!.entries;

      for (final entry in eventEntries) {
        final eventName = entry.key;
        final handlers = entry.value;

        eventMap[eventName] = (dynamic rawEvent) {
          // Attempt to cast to a more specific event type based on common event names
          // to provide better type safety for custom handlers.
          final Event event;
          switch (eventName) {
            case 'click':
            case 'mousedown':
            case 'mouseup':
            case 'mousemove':
            case 'mouseenter':
            case 'mouseleave':
              event = rawEvent as MouseEvent;
            case 'keydown':
            case 'keyup':
            case 'keypress':
              event = rawEvent as KeyboardEvent;
            case 'input':
            case 'change':
              // For input/change, Jaspr provides a String value. We wrap it in a generic Event
              // to match the UiEventHandler signature, though handlers should be aware of this.
              event = Event(rawEvent as String);
            default:
              event = rawEvent as Event;
          }

          for (final handler in handlers) {
            handler(event);
          }
        };
      }
    }
    return eventMap;
  }

  /// Merges two CSS class strings, safely handling null or empty inputs.
  ///
  /// This utility is used internally by `copyWith` methods to add programmatic
  /// classes without overwriting any classes already provided by the user.
  String? mergeClasses(String? originalClasses, String? newClasses) {
    if (originalClasses == null || originalClasses.isEmpty) {
      return newClasses;
    }
    if (newClasses == null || newClasses.isEmpty) {
      return originalClasses;
    }
    return '$originalClasses $newClasses';
  }
}
