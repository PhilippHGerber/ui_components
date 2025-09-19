import 'package:jaspr/jaspr.dart';

/// A component that renders an HTML `<datalist>` element.
///
/// A datalist is used to provide an "autocomplete" feature for `<input>`
/// elements. It contains a set of `<option>` elements that represent the
/// predefined values for the input. The datalist itself is not displayed;
/// it is just a container for the options.
///
/// To associate a datalist with an input, the `id` of the datalist must
/// match the `list` attribute of the input.
///
/// Example:
/// ```dart
/// Input(
///   attributes: {'list': 'browsers'},
///   // ... other properties
/// ),
/// Datalist(
///   id: 'browsers',
///   [
///     option(attributes: {'value': 'Edge'}),
///     option(attributes: {'value': 'Firefox'}),
///     option(attributes: {'value': 'Chrome'}),
///     option(attributes: {'value': 'Opera'}),
///     option(attributes: {'value': 'Safari'}),
///   ],
/// ),
/// ```
class Datalist extends StatelessComponent {
  /// Creates a Datalist component.
  ///
  /// - [id]: **Required.** The unique ID for this datalist. This ID is used by
  ///   an `<input>` element's `list` attribute to bind them together.
  /// - [children]: A list of Jaspr `option()` components that define the
  ///   predefined values for the associated input.
  const Datalist(
    this.children, {
    required this.id,
    super.key,
  });

  /// The list of `option()` components.
  final List<Component> children;

  /// The unique ID for the datalist.
  final String id;

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'datalist',
      id: id,
      children: children,
    );
  }
}
