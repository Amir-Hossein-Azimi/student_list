# Student List Flutter Project

A cross-platform mobile application built with Flutter for managing a list of students. The app demonstrates a clean architecture, API integration, and fundamental Flutter UI development.

## What the Project Does

This application provides a simple interface to view, add, and edit student information. It is designed to be a client for a backend server, fetching and persisting student data through a REST API.

## Features

- View a list of all students.
- Add a new student to the list.
- Edit the details of an existing student.
- Cross-platform support (Android, iOS, Web, Desktop) from a single codebase.

## Project Structure

The core application logic is organized within the `lib` directory, promoting separation of concerns and maintainability.

```
lib/
├── app.dart                  # The root widget of the application (e.g., MaterialApp).
├── constants.dart            # Application-wide constants.
├── main.dart                 # The entry point of the Flutter application.
├── models/
│   └── user.dart             # Defines the data model for a student/user.
├── screens/
│   ├── user_edit_screen.dart # The screen for adding or editing a student.
│   └── users_list_screen.dart# The main screen that displays the list of students.
├── services/
│   └── api_service.dart      # Handles all communication with the backend REST API.
└── widgets/
    └── user_list_item.dart   # A reusable widget for displaying a single student in the list.
```

## Benefits

- **Clean Architecture:** The separation of UI (screens), data models (models), business logic (services), and reusable components (widgets) makes the code easy to understand, scale, and maintain.
- **API Integration:** Provides a practical example of how to connect a Flutter application to a remote backend service for data management.
- **Cross-Platform:** Built with Flutter, this single codebase can be deployed on multiple platforms, saving development time and resources.
- **State Management Ready:** The structure is well-suited for integrating a state management solution (like Provider, BLoC, or Riverpod) to handle application state more efficiently.

## Reproducible Environment with Nix Flake

This project uses a [Nix Flake](https://nixos.wiki/wiki/Flakes) (`flake.nix`) to define a completely reproducible development environment. This ensures that all developers are using the exact same versions of the Flutter SDK, Dart, and other system-level dependencies.

**Benefits:**
- Eliminates "it works on my machine" problems.
- Simplifies setup to a single command.
- Guarantees a consistent environment across different machines and operating systems.

If you have Nix installed with Flakes enabled, you can activate this environment by running the following command in the project root:

```sh
nix develop
```

**Important:** This Flake is configured with a hardcoded path for the Android SDK. To build for Android, you **must** edit the `flake.nix` file and change the `ANDROID_SDK_ROOT` and `ANDROID_HOME` variables to point to the location of the Android SDK on your own machine.

This project is also configured to work with `direnv`. If you have `direnv` installed and configured, you can simply run `direnv allow` once in the project directory. Afterward, the Nix environment will be loaded automatically whenever you `cd` into the project folder.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- A configured IDE (like VS Code or Android Studio).
- A running instance of the backend API that this app is intended to connect to.

### Installation & Running

1.  Clone the repository:
    ```sh
    git clone <your-repository-url>
    ```
2.  Navigate to the project directory:
    ```sh
    cd student_list
    ```
3.  Install dependencies:
    ```sh
    flutter pub get
    ```
4.  Run the application:
    ```sh
    flutter run
    ```
