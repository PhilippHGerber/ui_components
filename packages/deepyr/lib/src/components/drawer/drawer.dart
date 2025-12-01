import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' show Event, HTMLInputElement, document;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'drawer_style.dart';

/// A responsive slide-out panel that follows the controlled component pattern.
///
/// The `Drawer` provides a flexible way to implement navigation sidebars and mobile
/// menus. Its visibility is managed entirely by a parent stateful component, making
// it a **controlled component**.
///
/// ### Design: Controlled & Self-Synchronizing
/// This component is fully controlled by its parent via the `isOpen` property. It is
/// also self-synchronizing: if you programmatically change `isOpen` (e.g., to close
/// the drawer after navigation), the component will automatically update the DOM
/// to reflect that change, ensuring the UI is always consistent.
///
/// ### Example Usage (in a StatefulComponent):
///
/// ```dart
/// class MyPage extends StatefulComponent {
///   @override
///   State<MyPage> createState() => _MyPageState();
/// }
///
/// class _MyPageState extends State<MyPage> {
///   bool _isDrawerOpen = false;
///   static const String _drawerId = 'my-unique-drawer-id';
///
///   @override
///   Component build(BuildContext context) {
///     return Drawer(
///       drawerId: _drawerId,
///       isOpen: _isDrawerOpen,
///       onToggle: (isOpen) => setState(() => _isDrawerOpen = isOpen),
///       classes: 'lg:drawer-open', // Always open on large screens
///       side: DrawerSide(menuContent: Menu([...])),
///       content: DrawerContent([
///         label(
///           htmlFor: _drawerId,
///           classes: 'btn drawer-button lg:hidden',
///           [Icon('menu')],
///         ),
///         // ... page content
///       ]),
///     );
///   }
/// }
/// ```
class Drawer extends UiComponent {
  /// Creates a controlled Drawer container component.
  ///
  /// - [content]: The main content area, wrapped in a [DrawerContent].
  /// - [side]: The slide-out panel, wrapped in a [DrawerSide].
  /// - [drawerId]: A stable, unique ID for the internal control checkbox.
  /// - [isOpen]: The current state of the drawer (`true` for open).
  /// - [onToggle]: A callback that fires when the drawer's state changes.
  /// - [style]: A list of [DrawerStyling] modifiers (e.g., [Drawer.end]).
  const Drawer({
    required this.content,
    required this.side,
    required this.drawerId,
    this.isOpen = false,
    this.onToggle,
    super.tag = 'div',
    List<DrawerStyling>? styles,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: styles);

  /// The main content area of the page.
  final DrawerContent content;

  /// The slide-out panel content.
  final DrawerSide side;

  /// The current state of the drawer. This directly controls the `checked` state
  /// of the internal checkbox, making this a controlled component.
  final bool isOpen;

  /// The callback for state management. It is triggered when the internal
  /// checkbox's state changes, providing the new state (`true` for open).
  final ValueChanged<bool>? onToggle;

  /// A unique ID used for the internal checkbox and for linking trigger labels.
  final String drawerId;

  @override
  String get baseClass => 'drawer';

  /// Creates a new instance of [Drawer] with the provided properties replaced.
  @override
  Drawer copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    DrawerContent? content,
    DrawerSide? side,
    bool? isOpen,
    ValueChanged<bool>? onToggle,
    String? drawerId,
  }) {
    return Drawer(
      content: content ?? this.content,
      side: side ?? this.side,
      isOpen: isOpen ?? this.isOpen,
      onToggle: onToggle ?? this.onToggle,
      drawerId: drawerId ?? this.drawerId,
      tag: tag,
      styles: style as List<DrawerStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  /// The public `Drawer` remains stateless and delegates its rendering to the
  /// private `_DrawerInternal` stateful component, which handles the synchronization logic.
  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: eventMap,
      children: [
        input(
          type: InputType.checkbox,
          id: drawerId,
          classes: 'drawer-toggle',
          // Jaspr bug see https://github.com/schultek/jaspr/issues/631
          checked: isOpen ? true : null,
          // Use the raw event parameter
          events: {
            'change': (dynamic rawEvent) {
              if (kIsWeb && onToggle != null) {
                final target = (rawEvent as Event).target! as HTMLInputElement;
                onToggle!(target.checked);
              }
            },
          },
        ),
        content,
        side.copyWith(htmlFor: drawerId),
        // Render the invisible synchronizer component, passing only primitive data.
        DrawerSynchronizer(
          checkboxId: drawerId,
          shouldBeOpen: isOpen,
        ),
      ],
    );
  }

  // --- Static Drawer Modifiers ---

  /// Changes the drawer to open from the right side. `drawer-end`
  static const DrawerStyle end = DrawerStyle('drawer-end', type: StyleType.layout);
}

/// The main content area of a [Drawer].
///
/// This component acts as a container for the primary content of your page.
/// It is essential to place your drawer trigger (a `<label>`) within this component.
class DrawerContent extends UiComponent {
  const DrawerContent(
    super.children, {
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.child,
    super.key,
  });

  @override
  String get baseClass => 'drawer-content';

  @override
  DrawerContent copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    List<Component>? children,
    Component? child,
  }) {
    return DrawerContent(
      children ?? this.children ?? [],
      child: child ?? this.child,
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

/// Represents the slide-out panel (sidebar) of a [Drawer].
///
/// This component serves as the container for the drawer's visible content and the
/// interactive overlay. The `htmlFor` property is automatically managed by the parent
/// [Drawer] to link the overlay to the internal control checkbox.
class DrawerSide extends UiComponent {
  const DrawerSide({
    required this.menuContent,
    this.htmlFor,
    super.tag = 'div',
    super.style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null);

  /// The sidebar content to display in the slide-out panel.
  final Component menuContent;

  /// The `for` attribute of the overlay label, injected by the parent `Drawer`.
  final String? htmlFor;

  @override
  String get baseClass => 'drawer-side';

  @override
  DrawerSide copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
    Component? menuContent,
    String? htmlFor,
  }) {
    return DrawerSide(
      menuContent: menuContent ?? this.menuContent,
      htmlFor: htmlFor ?? this.htmlFor,
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

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: componentAttributes,
      events: eventMap,
      children: [
        // This label acts as the overlay that closes the drawer when clicked.
        label(
          htmlFor: htmlFor,
          classes: 'drawer-overlay',
          attributes: {'aria-label': 'close sidebar'},
          [],
        ),
        menuContent,
      ],
    );
  }
}

/// An invisible, client-side only stateful component that synchronizes the
/// DOM state of the drawer's checkbox with the declarative `isOpen` property.
///
/// This component accepts only primitive, serializable types, allowing it to
/// safely cross the server-client boundary in Jaspr. It renders nothing to the
/// DOM and exists solely to encapsulate the imperative synchronization logic.
@client
class DrawerSynchronizer extends StatefulComponent {
  const DrawerSynchronizer({
    required this.checkboxId,
    required this.shouldBeOpen,
  });

  final String checkboxId;
  final bool shouldBeOpen;

  @override
  State<DrawerSynchronizer> createState() => DrawerSynchronizerState();
}

class DrawerSynchronizerState extends State<DrawerSynchronizer> {
  /// Schedules a client-side DOM update to synchronize the checkbox state.
  void synchronizeCheckboxState() {
    // This logic is guaranteed to run only on the client because the
    // component is marked with @client.
    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      final checkbox = document.getElementById(component.checkboxId) as HTMLInputElement?;
      if (checkbox != null && checkbox.checked != component.shouldBeOpen) {
        checkbox.checked = component.shouldBeOpen;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      synchronizeCheckboxState();
    }
  }

  @override
  void didUpdateComponent(DrawerSynchronizer oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (kIsWeb) {
      synchronizeCheckboxState();
    }
  }

  @override
  Component build(BuildContext context) {
    // This component renders nothing. Its only purpose is its lifecycle methods.
    return const Component.empty();
  }
}
