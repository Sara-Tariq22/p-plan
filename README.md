Project Title
# P-PLAN 📱💸
P-PLAN: Personal Finance & Bill-Tracking App

Research Problem
People often struggle to track their true disposable income because they forget to mentally deduct upcoming bills and subscriptions from their bank balance. Existing financial apps are often too complex or require linking sensitive bank accounts, creating a need for a simple, manual tracker.

Motivation
This project provides a simple, privacy-focused tool for everyday financial tracking. By automatically deducting entered bills and subscriptions from the user's main balance, the app ensures users always see exactly what they can actually afford, helping to prevent overspending.

Control Flow
Launch: App opens to the Welcome Screen. User taps "Enter".

Dashboard: Loads the main hub, showing a starting balance of 0.0, and empty bill/subscription lists.

Update Balance: User taps "+/-" to manually add or remove funds via a pop-up.

Add Expense: User taps "Add Bill" or "Add Sub", navigating to a new data-entry screen.

Auto-Calculate: User saves the expense. The app returns to the Dashboard, adds the item to the list, and instantly deducts the cost from the main balance.

Implementation Strategy
Tech Stack: Built using Dart and the Flutter framework.

File Structure: Code is divided into modular files (e.g., dashboard_screen.dart, bills_screen.dart) to keep it clean and organized.

Data Models: Uses custom Dart classes (BillItem, SubscriptionItem) to store the name and amount of each expense.

State Management: Relies on Flutter's native StatefulWidget. The DashboardScreen holds the "master memory" (the main state).

Data Flow: Uses "callback functions" to pass data from the individual expense screens back up to the Dashboard so the math updates in real-time.
