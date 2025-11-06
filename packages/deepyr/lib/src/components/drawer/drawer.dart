import 'package:jaspr/jaspr.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'drawer_style.dart';

/// A responsive slide-out panel (drawer) that follows the controlled component pattern.
///
/// The `Drawer` provides a flexible way to implement navigation sidebars and mobile
/// menus. Its visibility is managed entirely by a parent stateful component.
///
/// ### Design: Controlled Component
/// This is a **controlled component**. Its open/closed state is not managed internally.
/// You must:
/// 1. Own the state (e.g., a `bool _isDrawerOpen`) in a parent `StatefulComponent`.
/// 2. Pass this state to the `Drawer` via the `isOpen` property.
/// 3. Provide an `onToggle` callback to update your state when the user interacts
///    with the drawer.
///
/// ### Responsive Behavior
/// To make the drawer permanently visible on large screens while remaining toggleable
/// on mobile, apply the `lg:drawer-open` class to the `Drawer`'s `classes` property.
/// The `isOpen` state will then only control the mobile overlay behavior.
///
/// ### Internal Mechanism
/// The drawer uses a hidden, **controlled** checkbox (`<input type="checkbox">`) that
/// is linked to trigger elements (`<label>`) to manage its state via CSS. This
/// component abstracts that complexity away.
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
///   // 1. Parent component owns the state.
///   bool _isDrawerOpen = false;
///
///   @override
///   Component build(BuildContext context) {
///     return Drawer(
///       // 2. Control the state from the parent.
///       isOpen: _isDrawerOpen,
///       // 3. Update the state via the callback.
///       onToggle: (isOpen) => setState(() => _isDrawerOpen = isOpen),
///       // Apply responsive visibility using a standard CSS class.
///       classes: 'lg:drawer-open',
///       side: DrawerSide(menuContent: Menu([...])),
///       content: DrawerContent([
///         DrawerTrigger([ Button([Icon('menu')]) ]),
///         // ... your other page content
///       ]),
///     );
///   }
/// }
/// ```
class Drawer extends UiComponent {
  /// Creates a controlled Drawer container component.
  ///
  /// - [content]: The main content area, wrapped in a [DrawerContent]. This is
  ///   where you should place your [DrawerTrigger].
  /// - [side]: The slide-out panel, wrapped in a [DrawerSide].
  /// - [drawerId]: Stable ID for the internal control checkbox. This ID must be
  ///   unique on the page and is used to link trigger to the drawer.
  /// - [isOpen]: The current state of the drawer (`true` for open). This is the
  ///   single source of truth for the drawer's interactive state.
  /// - [onToggle]: A callback that fires when the drawer's state changes,
  ///   allowing the parent to update its state.
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

  /// Whether the drawer is currently open. This directly controls the `checked` state
  /// of the internal checkbox, making this a controlled component.
  final bool isOpen;

  /// This callback is crucial for state management. It is triggered when the internal
  /// checkbox's state changes, providing the new state (`true` for open, `false` for closed).
  final ValueChanged<bool>? onToggle;

  /// A unique ID used for the internal checkbox and for linking labels (like the overlay) to it.
  final String drawerId;

  @override
  String get baseClass => 'drawer';

  /// Creates a new instance of [Drawer] with the provided properties replaced.
  ///
  /// This method is essential for the "smart container" pattern, allowing parent
  /// components to programmatically clone and modify their children.
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
        input(
          type: InputType.checkbox,
          id: drawerId,
          classes: 'drawer-toggle',
          // Jaspr bug see https://github.com/schultek/jaspr/issues/631
          checked: isOpen ? true : null,
          // Use the raw event parameter
          events: {
            'change': (_) {
              if (kIsWeb && onToggle != null) {
                // Toggle based on current state
                onToggle!(!isOpen);
              }
            },
          },
        ),
        content,
        side.copyWith(htmlFor: drawerId),
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
/// It is essential to place your [DrawerTrigger] within this component to ensure
/// proper functionality. All other page content should also be nested here.
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

  /// Creates a new instance of [DrawerContent] with the provided properties replaced.
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
/// interactive overlay. It is composed of two key parts:
/// 1. A `<label>` that acts as a clickable overlay to close the drawer.
/// 2. The `menuContent` you provide, which is the actual sidebar UI.
///
/// The `htmlFor` property is automatically managed by the parent [Drawer] to link
/// the overlay to the internal control checkbox.
class DrawerSide extends UiComponent {
  /// Creates a DrawerSide component.
  ///
  /// - [menuContent]: The actual content to display within the slide-out panel.
  /// - [htmlFor]: The 'for' attribute for the overlay label, injected by parent Drawer.
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

  /// Creates a new instance of [DrawerSide] with the provided properties replaced.
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
    // This solves the SSR flash: we conditionally add the `hidden` attribute
    // during Server-Side Rendering to prevent the flash of content.
    final ssrAttributes = !kIsWeb ? {'hidden': ''} : null;

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: this.css,
      attributes: {
        if (ssrAttributes != null) ...ssrAttributes,
        ...componentAttributes,
      },
      events: this.events,
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
