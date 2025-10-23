import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'fab_style.dart';

/// A "smart container" for creating a Floating Action Button (FAB) with an optional
/// "Speed Dial" menu that appears on focus or click.
///
/// This component abstracts away daisyUI's specific DOM structure and the need for
/// manual workarounds for browser bugs (like the Safari focus issue), providing a
/// clean, compositional, and type-safe API.
///
/// The `Fab`'s interactivity is based on the pure CSS `:focus-within` pseudo-class.
///
/// ### API Structure:
/// - **`trigger`**: The main, always-visible button. You provide a standard `deepyr` component.
/// - **`actions`**: A list of `FabAction` components that appear when the FAB is open.
/// - **`mainAction` / `closeAction`**: Optional components to replace the trigger when open.
///
/// ### Safari Compatibility:
/// The component automatically renders the provided `trigger` within a
/// `<div tabindex="0" role="button">`, ensuring consistent focus behavior across all
/// modern browsers, including Safari, without requiring the developer to change how
/// they write their code.
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
       super(null, style: style); // Children are managed via named properties.

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

  @override
  Component build(BuildContext context) {
    final effectiveChildren = <Component>[];

    // 1. Abstract away the Safari focus bug by rendering the trigger inside a
    //    styled, focusable <div>.
    Component effectiveTrigger;
    if (trigger is UiComponent) {
      final triggerComponent = trigger as UiComponent;
      effectiveTrigger = div(
        // CORRECTED: Pass children as the first positional argument.
        triggerComponent.children ?? [if (triggerComponent.child != null) triggerComponent.child!],
        // Named arguments for other properties.
        attributes: {'tabindex': '0', 'role': 'button'},
        classes: triggerComponent.combinedClasses,
        styles: triggerComponent.css,
      );
    } else {
      // For primitive components, wrap them in a basic focusable div.
      effectiveTrigger = div(
        [trigger], // CORRECTED: Pass child in a list as the first argument.
        attributes: {'tabindex': '0', 'role': 'button'},
      );
    }
    effectiveChildren.add(effectiveTrigger);

    // 2. Add the main or close action if provided.
    if (mainAction != null) {
      effectiveChildren.add(mainAction!);
    }
    if (closeAction != null) {
      effectiveChildren.add(closeAction!);
    }

    // 3. Add the list of speed dial actions.
    effectiveChildren.addAll(actions);

    // 4. Render the final container with the processed children.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: effectiveChildren,
    );
  }

  // --- Static Style Modifiers ---

  /// Renders the speed dial actions in a quarter-circle "flower" arrangement.
  /// This can fit 1 to 4 action buttons.
  static const FabStyle flower = FabStyle('fab-flower', type: StyleType.layout);
}

/// A structural component that wraps a single speed dial action, optionally with a label.
/// It handles the layout for the label and the button.
class FabAction extends UiComponent {
  /// Creates a single speed dial action.
  ///
  /// - [child]: **Required.** The `deepyr` component for the action, typically a `Button`.
  /// - [label]: An optional `Component` (e.g., `text('Label')`) to display next to the button.
  FabAction({
    required Component child,
    this.label,
    super.tag = 'div', // Rendered as a div only if there is a label.
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
  String get baseClass => ''; // No base class for the wrapper itself.

  @override
  Component build(BuildContext context) {
    // CORRECTED: The single child component is the first element in the 'children' list.
    final actionButton = children!.first;

    // If there is no label, render the child directly to avoid an unnecessary <div> wrapper.
    if (label == null) {
      return actionButton;
    }
    // If a label exists, render the wrapper div with the label and child.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: [label!, actionButton],
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
    // CORRECTED: Access the child from the 'children' list.
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

/// A specialized action that replaces the trigger button when the FAB is open,
/// providing an explicit "close" button.
class FabClose extends UiComponent {
  /// Creates a close action for a `Fab`.
  ///
  /// - [child]: **Required.** The `deepyr` component for the close button, typically a `Button` with an '✕' icon.
  /// - [label]: An optional `Component` to display next to the close button.
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
    super.key,
  }) : super([child]);

  /// An optional text label displayed next to the close button.
  final Component? label;

  @override
  String get baseClass => 'fab-close';

  @override
  Component build(BuildContext context) {
    // CORRECTED: The single child component is the first element in the 'children' list.
    final actionButton = children!.first;

    if (label == null) {
      // If the child is a UiComponent, use copyWith to safely add the class.
      if (actionButton is UiComponent) {
        return actionButton.copyWith(classes: mergeClasses(actionButton.classes, baseClass));
      }
      // For primitive components, wrap them in a div with the class.
      return div([actionButton], classes: baseClass);
    }
    // If a label exists, the baseClass is on the container itself.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses, // combinedClasses already includes baseClass
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: [label!, actionButton],
    );
  }

  @override
  FabClose copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    // CORRECTED: Access the child from the 'children' list.
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
      key: key ?? this.key,
    );
  }
}

/// A specialized action that replaces the trigger button when the FAB is open,
/// providing a primary or default action.
class FabMainAction extends UiComponent {
  /// Creates a main action for a `Fab`.
  ///
  /// - [child]: **Required.** The `deepyr` `Button` component for the main action.
  /// - [label]: An optional `Component` to display next to the main action button.
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
    super.key,
  }) : super([child]);

  /// An optional text label displayed next to the main action button.
  final Component? label;

  @override
  String get baseClass => 'fab-main-action';

  @override
  Component build(BuildContext context) {
    // CORRECTED: The single child component is the first element in the 'children' list.
    final actionButton = children!.first;

    if (label == null) {
      // If the child is a UiComponent, use copyWith to safely add the class.
      if (actionButton is UiComponent) {
        return actionButton.copyWith(classes: mergeClasses(actionButton.classes, baseClass));
      }
      // For primitive components, wrap them in a div with the class.
      return div([actionButton], classes: baseClass);
    }
    // If a label exists, the baseClass is on the container itself.
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses, // combinedClasses already includes baseClass
      styles: this.css,
      attributes: componentAttributes,
      events: this.events,
      children: [label!, actionButton],
    );
  }

  @override
  FabMainAction copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    // CORRECTED: Access the child from the 'children' list.
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
      key: key ?? this.key,
    );
  }
}
