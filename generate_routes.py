import os
from string import Template

# List of component names to generate pages for.
# 'Button' and 'Home' are excluded as we've already created them.
COMPONENTS = [
    "alert",
    "badge",
    "card",
    "checkbox",
    "divider",
    "input",
    "link",
    "loading",
    "progress",
    "radio",
    "select",
    "textarea",
    "toggle",
]

# The target directory for the generated files.
# This path is relative to the root of your `ui_components` project.
TARGET_DIR = os.path.join("examples", "deepyr_example", "lib", "pages", "component_routes")

# The template for the Dart file content.
# Using string.Template with $placeholders to avoid conflict with Dart's {} syntax.
DART_TEMPLATE = Template("""import 'package:jaspr/jaspr.dart';
import '../preview/$preview_file_name';

/// The page that showcases the `$component_name_pascal_case` component.
///
/// This is a simple wrapper component that renders the `${component_name_pascal_case}Preview`,
/// which contains all the interactive examples and code snippets.
class ${component_name_pascal_case}Page extends StatelessComponent {
  const ${component_name_pascal_case}Page({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ${component_name_pascal_case}Preview();
  }
}
""")


def generate_files():
    """
    Generates the Dart route page files for each component.
    """
    # Create the target directory if it doesn't exist.
    if not os.path.exists(TARGET_DIR):
        os.makedirs(TARGET_DIR)
        print(f"Created directory: {TARGET_DIR}")

    print("\\nStarting file generation...")
    # Loop through each component name to create its corresponding file.
    for name in COMPONENTS:
        # Convert the name to PascalCase (e.g., "alert" -> "Alert").
        pascal_case_name = name.capitalize()

        # Define the file names based on the component name.
        file_name = f"{name}_page.dart"
        preview_file_name = f"{name}_preview.dart"

        # Construct the full path for the new file.
        file_path = os.path.join(TARGET_DIR, file_name)

        # Create a dictionary with the values for the placeholders.
        substitutions = {
            "file_name": file_name,
            "preview_file_name": preview_file_name,
            "component_name_pascal_case": pascal_case_name,
        }

        # Fill the template with the specific component names.
        content = DART_TEMPLATE.substitute(substitutions)

        # Write the generated content to the file.
        with open(file_path, "w") as f:
            f.write(content)

        print(f"  -> Successfully created {file_path}")

    print("\\nFile generation complete!\\n")


if __name__ == "__main__":
    generate_files()
