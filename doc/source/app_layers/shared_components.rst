Shared Components Layer
=======================

Overview
--------

The Shared Components layer contains reusable UI components used across different features of the MS-dTMT application. These components ensure consistency in the user interface, reduce code duplication, and speed up development by providing ready-to-use solutions for common UI patterns.

Key Components
--------------

Custom Buttons
^^^^^^^^^^^^^^

**CustomPrimaryButton**

The CustomPrimaryButton is a full-width primary action button with the following features:

- Configurable background color that defaults to the app's primary color
- Enabled/disabled states with appropriate visual feedback
- Responsive sizing based on device type (tablet or phone)
- Consistent padding and border radius
- Proper text styling with weight and color adjustments

This button is used for primary actions throughout the application, such as form submissions, navigation to the next step, or confirming actions.

**CustomSecondaryButton**

The CustomSecondaryButton is a text-based button used for secondary actions with:

- Minimal visual weight compared to primary buttons
- Consistent tap target size for accessibility
- Theme-appropriate text styling
- Compact design for use in tight layouts
- Visual feedback on interaction

This button is typically used for actions like "Cancel", "Back", or other secondary options that don't represent the main flow.

Navigation Components
^^^^^^^^^^^^^^^^^^^^^

**CustomAppBar**

The CustomAppBar provides a consistent navigation header across the application with:

- Standardized back button with proper icon
- Configurable title with appropriate typography
- Optional action buttons in the header
- Proper theming based on light/dark mode
- Consistent height and styling
- Configurable center title option

This component ensures navigation consistency and provides users with familiar patterns throughout the application.

Dialog Components
^^^^^^^^^^^^^^^^^

**CustomDialog**

The CustomDialog provides standardized dialog implementations for:

1. **SingleButton** mode:

   - Simple dialog with a single action button
   - Used for informational messages or simple confirmations

2. **TwoMainButtons** mode:

   - Dialog with two prominent buttons side by side
   - Used for presenting two equal choices
   - Support for left and right button configuration

3. **ConfirmCancel** mode:

   - Dialog with primary action and cancel option
   - Used for confirmation flows requiring explicit approval or cancellation

Features include:

- Customizable title and content
- Flexible button configurations with customizable text
- Callback support for user decisions
- Responsive sizing and proper theming
- Optional dismissible behavior control

These dialog components provide consistent user interaction patterns for common dialog scenarios.

Text Components
^^^^^^^^^^^^^^^

**HeaderText**

The HeaderText component is used for section headings across the application with:

- Standardized font size and weight
- Proper color based on current theme
- Consistent styling using the theme's headlineMedium style
- Simple implementation to ensure heading consistency

This component maintains visual hierarchy in screens and ensures consistent section identification.

Benefits of Shared Components
-----------------------------

1. **Consistency**: Ensures a cohesive user interface with consistent patterns
2. **Efficiency**: Speeds up development by reusing pre-built components
3. **Maintainability**: Centralizes UI component logic for easier updates
4. **Adaptability**: Supports theming and responsive design
5. **Accessibility**: Components maintain proper sizing and touch targets

The Shared Components layer is fundamental to maintaining design system principles and ensuring a professional, consistent user experience across the MS-dTMT application. By abstracting common UI patterns into reusable components, the layer also improves development speed and code quality.