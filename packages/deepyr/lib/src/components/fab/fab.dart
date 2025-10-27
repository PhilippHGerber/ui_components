import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart';

import '../../../deepyr.dart';
import '../../base/style_type.dart';
import 'fab_style.dart';

// #region JS-Interop for Focus Management

/// A JS-interop function that calls `.blur()` on the currently focused element in the document.
/// This is the most reliable way to remove focus from the FAB container and trigger its closing animation.
@JS('document.activeElement.blur')
external void _blurActiveElement();

/// A safe Dart wrapper for the JS interop function. It ensures the code only
/// runs on the client-side, preventing errors during server-side rendering (SSR).
void blurActiveElement() {
  if (kIsWeb) {
    try {
      _blurActiveElement();
    } catch (e) {
      // Log error if the JS call fails for any reason.
      print('Could not blur active element: $e');
    }
  }
}

// #endregion

// #region FAB Component System

/// A "smart container" for creating a Floating Action Button (FAB) with an optional
/// "Speed Dial" menu that appears on focus or click.
///
/// This component provides a high-level, compositional API that abstracts away
/// DaisyUI's specific DOM structure and the need for manual workarounds for browser
/// bugs (like the Safari focus issue), delivering a clean and type-safe developer experience.
///
/// ### API Structure:
/// The `Fab` component is built using named parameters for clarity:
/// - **`trigger`**: The main, always-visible button. You provide a standard `deepyr` component.
/// - **`actions`**: A list of `FabAction` components that appear when the FAB is open.
/// - **`mainAction` / `closeAction`**: Optional components to replace the trigger when open.
///
/// ### Interactivity Model:
/// The component's interactivity is based on the pure CSS `:focus-within` pseudo-class.
/// - The `Fab` component automatically wraps your `trigger` in a focusable `div`,
///   which acts as the focus entry point.
/// - When the `closeAction` or `mainAction` is clicked, they are rendered as
///   **non-focusable** elements. Their `onClick` event is intercepted to first
///   execute your callback and then programmatically blur the container, ensuring
///   the menu closes reliably across all browsers.
@immutable
class Fab extends UiComponent {
  /// Creates a Floating Action Button (FAB) container.
  ///
  /// - [trigger]: **Required.** The main button component that is always visible.
  ///   Typically a `deepyr` `Button` or a styled `Container` with an `Icon`.
  /// - [actions]: **Required.** A list of `FabAction` components that represent the
  ///   speed dial buttons revealed when the FAB is open.
  /// - [mainAction]: An optional `FabMainAction` that replaces the `trigger` when open,
  ///   representing a primary action.
  /// - [closeAction]: An optional `FabClose` that replaces the `trigger` when open,
  ///   providing an explicit close button.
  /// - [style]: A list of `FabStyling` modifiers, such as `Fab.flower`.
  const Fab({
    required this.trigger,
    required this.actions,
    this.mainAction,
    this.closeAction,
    super.tag = 'div',
    List<FabStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : assert(
         mainAction == null || closeAction == null,
         'A Fab component cannot have both a mainAction and a closeAction.',
       ),
       super(null, style: style);

  /// The main, always-visible button component that opens the speed dial.
  final Component trigger;

  /// The list of speed dial actions that appear when the FAB is open.
  final List<Component> actions;

  /// An optional primary action that replaces the trigger when the FAB is open.
  final FabMainAction? mainAction;

  /// An optional close button that replaces the trigger when the FAB is open.
  final FabClose? closeAction;

  @override
  String get baseClass => 'fab';

  /// A helper method to build the non-focusable wrappers for `closeAction` and `mainAction`.
  ///
  /// This is the core of the fix. It takes the user-provided action component,
  /// extracts its visual parts, and rebuilds it as a non-interactive `<span>`
  /// with a custom click handler.
  Component _buildActionWrapper(UiComponent actionComponent) {
    // Determine the base class ('fab-close' or 'fab-main-action').
    final baseClass = actionComponent.baseClass;
    final visualButton = actionComponent.children!.first as UiComponent;
    final label = (actionComponent is FabClose)
        ? actionComponent.label
        : (actionComponent is FabMainAction ? actionComponent.label : null);

    final userOnClick = (actionComponent is FabClose)
        ? actionComponent.onClick
        : (actionComponent is FabMainAction ? actionComponent.onClick : null);

    final buttonContent = <Component>[
      ...?visualButton.children,
      if (visualButton.child != null) visualButton.child!,
    ];

    final nonFocusableButton = span(
      buttonContent,
      classes: visualButton.combinedClasses,
    );

    return div(
      classes: baseClass,
      [
        ?label,
        nonFocusableButton,
      ],
      events: {
        'click': (dynamic rawEvent) {
          // First, execute the user's intended action, casting the event for type safety.
          userOnClick?.call(rawEvent as MouseEvent);
          // Then, programmatically blur the container to close the menu.
          blurActiveElement();
        },
      },
    );
  }

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: [
        // 1. The focusable trigger wrapper. This solves the Safari bug and
        //    provides a consistent focus target.
        div(
          attributes: {'tabindex': '0', 'role': 'button'},
          [trigger],
        ),

        // 2. The close or main action, processed to be non-focusable.
        if (closeAction != null) _buildActionWrapper(closeAction!),
        if (mainAction != null) _buildActionWrapper(mainAction!),

        // 3. The speed dial actions, which remain fully interactive.
        ...actions,
      ],
    );
  }

  @override
  Fab copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Fab(
      trigger: trigger,
      actions: actions,
      mainAction: mainAction,
      closeAction: closeAction,
      tag: tag,
      style: style as List<FabStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  /// Renders the speed dial actions in a quarter-circle "flower" arrangement.
  static const FabStyle flower = FabStyle('fab-flower', type: StyleType.layout);
}

/// A structural component that wraps a single speed dial action, optionally with a label.
@immutable
class FabAction extends UiComponent {
  /// Creates a single speed dial action.
  ///
  /// - [child]: **Required.** The `deepyr` component for the action, typically a `Button`.
  /// - [label]: An optional `Component` (e.g., `text('Label')`) to display next to the button.
  FabAction({
    required Component child,
    this.label,
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super([child]);

  /// An optional text label displayed next to the action button.
  final Component? label;

  @override
  String get baseClass => '';

  @override
  Component build(BuildContext context) {
    // If there is no label, render the child directly to avoid an unnecessary <div> wrapper.
    if (label == null) {
      return children!.first;
    }
    // If a label exists, render the wrapper div with the label and child.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: [label!, children!.first],
    );
  }

  @override
  FabAction copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return FabAction(
      child: children!.first,
      label: label,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}

/// A specialized component that provides a close button to replace the trigger when the FAB is open.
@immutable
class FabClose extends UiComponent {
  /// Creates a close action for a `Fab`.
  ///
  /// - [child]: **Required.** The `deepyr` component for the close button, typically a `Button`.
  /// - [label]: An optional `Component` to display next to the close button.
  /// - [onClick]: An optional callback to execute when the close button is clicked.
  FabClose({
    required Component child,
    this.label,
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.onClick,
    super.key,
  }) : super([child]);

  /// An optional text label displayed next to the close button.
  final Component? label;

  @override
  String get baseClass => 'fab-close';

  @override
  FabClose copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return FabClose(
      child: children!.first,
      label: label,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      onClick: onClick,
      key: key ?? this.key,
    );
  }
}

/// A specialized component that provides a primary action to replace the trigger when the FAB is open.
@immutable
class FabMainAction extends UiComponent {
  /// Creates a main action for a `Fab`.
  ///
  /// - [child]: **Required.** The `deepyr` `Button` component for the main action.
  /// - [label]: An optional `Component` to display next to the main action button.
  /// - [onClick]: An optional callback to execute when the main action is clicked.
  FabMainAction({
    required Component child,
    this.label,
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.onClick,
    super.key,
  }) : super([child]);

  /// An optional text label displayed next to the main action button.
  final Component? label;

  @override
  String get baseClass => 'fab-main-action';

  @override
  FabMainAction copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return FabMainAction(
      child: children!.first,
      label: label,
      tag: tag,
      style: style,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      onClick: onClick,
      key: key ?? this.key,
    );
  }
}

// #endregion
