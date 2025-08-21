/// A builder class for creating a map of HTML attributes.
///
/// This utility helps in constructing the `Map<String, String>` of attributes
/// that can be passed to UI components. It provides convenient methods for adding
/// common types of attributes, such as standard HTML attributes, ARIA attributes,
/// and data attributes.
///
/// Example:
/// ```dart
/// final attributesBuilder = UiComponentAttributes()
///   ..add('tabindex', '0')
///   ..addAria('label', 'Close button')
///   ..addData('testid', 'submit-action')
///   ..addRole('button');
///
/// final Map<String, String> htmlAttributes = attributesBuilder.build();
/// ```
class UiComponentAttributes {
  /// Creates an instance of [UiComponentAttributes].
  ///
  /// An optional [initialAttributes] map can be provided to pre-populate
  /// the builder.
  UiComponentAttributes([Map<String, String>? initialAttributes])
    : _attributes = initialAttributes != null ? Map.from(initialAttributes) : <String, String>{};
  final Map<String, String> _attributes;

  /// Adds a standard HTML attribute.
  ///
  /// If an attribute with the same [name] already exists, its value will be overwritten.
  ///
  /// [name]: The name of the attribute (e.g., "href", "target").
  /// [value]: The value of the attribute.
  void add(String name, String value) {
    _attributes[name] = value;
  }

  /// Adds a standard HTML attribute only if the [condition] is true.
  ///
  /// If an attribute with the same [name] already exists and the condition is true,
  /// its value will be overwritten.
  ///
  /// [condition]: The boolean condition that determines if the attribute is added.
  /// [name]: The name of the attribute.
  /// [value]: The value of the attribute.
  void addIf(bool condition, String name, String value) {
    if (condition) {
      _attributes[name] = value;
    }
  }

  /// Adds an ARIA (Accessible Rich Internet Applications) attribute.
  /// The 'aria-' prefix will be automatically prepended to the [name].
  ///
  /// Example: `addAria('label', 'Description')` results in `aria-label="Description"`.
  /// If an attribute with the same 'aria-[name]' already exists, its value will be overwritten.
  ///
  /// [name]: The ARIA attribute name without the 'aria-' prefix (e.g., "label", "hidden").
  /// [value]: The value of the ARIA attribute.
  void addAria(String name, String value) {
    _attributes['aria-$name'] = value;
  }

  /// Adds a custom data attribute.
  /// The 'data-' prefix will be automatically prepended to the [name].
  ///
  /// Example: `addData('testid', 'user-profile')` results in `data-testid="user-profile"`.
  /// If an attribute with the same 'data-[name]' already exists, its value will be overwritten.
  ///
  /// [name]: The data attribute name without the 'data-' prefix (e.g., "testid", "custom-value").
  /// [value]: The value of the data attribute.
  void addData(String name, String value) {
    _attributes['data-$name'] = value;
  }

  /// Adds or updates the 'role' ARIA attribute.
  /// This is a convenience method for `addAttribute('role', role)`.
  ///
  /// [role]: The ARIA role value (e.g., "button", "navigation", "dialog").
  void addRole(String role) {
    _attributes['role'] = role;
  }

  /// Merges another map of attributes into the current set.
  ///
  /// Attributes from the [other] map will be added. If an attribute name
  /// exists in both the current set and the [other] map, the value from
  /// the [other] map will overwrite the existing value.
  ///
  /// If [other] is null, no changes are made.
  void merge(Map<String, String>? other) {
    if (other != null) {
      _attributes.addAll(other);
    }
  }

  /// Builds and returns an unmodifiable map of the configured attributes.
  ///
  /// This prevents accidental modification of the attribute map after it has been built.
  Map<String, String> build() {
    return Map.unmodifiable(_attributes);
  }

  /// Returns `true` if no attributes have been added.
  bool get isEmpty => _attributes.isEmpty;

  /// Returns `true` if at least one attribute has been added.
  bool get isNotEmpty => _attributes.isNotEmpty;
}
