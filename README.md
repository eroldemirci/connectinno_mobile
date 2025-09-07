# ConnectInno Case Flutter Note App

## Overview
This project is a modern, robust note-taking application built with Flutter. It demonstrates best practices in clean architecture, state management, and offline-first design. The app allows users to register, log in, and perform full CRUD (Create, Read, Update, Delete) operations on their notes, with seamless offline support and real-time synchronization when connectivity is restored.

## Features
- **User Authentication**: Register and login with secure authentication (Supabase backend).
- **Note CRUD**: Create, read, update, and delete notes. Notes are user-specific and securely stored.
- **Offline Support**: Notes can be created, updated, and deleted offline. All changes are automatically synchronized with the backend when the device is online.
- **State Management**: Bloc/Cubit is used for robust, testable, and scalable state management.
- **Navigation**: auto_route is used for type-safe, declarative navigation.
- **Clean Architecture**: The codebase is organized by feature and responsibility, following MVVM and clean architecture principles.
- **Dependency Injection**: get_it is used for dependency management.
- **Networking**: Dio is used for HTTP requests. FastAPI is used as the backend API.
- **Supabase Integration**: User authentication and data storage are handled via Supabase.
- **Modern UI**: Responsive, platform-aware, and user-friendly interface.

## Technologies Used
- **Flutter**: UI toolkit for building natively compiled applications.
- **Bloc/Cubit**: State management solution for predictable and testable business logic.
- **auto_route**: Declarative, type-safe routing and navigation.
- **get_it**: Simple service locator for dependency injection.
- **Dio**: Powerful HTTP client for Dart/Flutter.
- **Supabase**: Open source Firebase alternative for authentication and database.
- **FastAPI**: High-performance Python backend for RESTful APIs.
- **flutter_secure_storage**: Secure local storage for sensitive data and offline cache.
- **MVVM**: Model-View-ViewModel pattern for separation of concerns.
- **Clean Architecture**: Layered structure for maintainability and scalability.

## Project Structure
```
lib/
	core/
		models/         # Data models (NoteModel, UserModel, etc.)
		services/       # API and data services (NoteServices, AuthServices, etc.)
		managers/       # Cache, network, and auth managers
		routing/        # App routing (auto_route)
	ui/
		pages/          # Feature pages (login, register, home, note details, etc.)
			...
		shared/         # Shared widgets, styles, and base classes
```

## How It Works
- **Authentication**: Users register and log in via Supabase. Auth state is managed globally.
- **Notes**: Each note is tied to a user. Notes are fetched from the backend and cached locally. When offline, notes are read/written from cache. When back online, offline changes are synced to the backend.
- **State Management**: Bloc/Cubit classes manage all business logic and UI state, ensuring a responsive and robust user experience.
- **Navigation**: auto_route provides declarative, type-safe navigation between pages.
- **Offline Sync**: When the app detects connectivity, it automatically syncs any notes created or updated offline with the backend.

## Main Flows
- **Login/Register**: Secure authentication with Supabase.
- **Home Page**: Displays the user's notes. Supports pull-to-refresh, offline cache, and real-time sync.
- **Note Details**: Create or edit a note. Changes are saved offline if needed and synced when online.
- **Delete Note**: Slide-to-delete with confirmation dialog. Works offline and syncs when online.
- **Logout**: Securely logs out and clears sensitive data.

## Backend
- **Supabase**: Handles authentication and stores user/note data.
- **FastAPI**: Provides RESTful endpoints for note CRUD operations.

## Clean Architecture Principles
- **Separation of Concerns**: UI, business logic, and data layers are clearly separated.
- **Testability**: Bloc/Cubit and service layers are easily testable.
- **Scalability**: The structure supports adding new features and modules with minimal refactoring.

## Getting Started
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Configure your Supabase and FastAPI endpoints in the environment files.
4. Run the app on your preferred device or emulator.


## License
MIT License
# connectinno_case

A new Flutter project.
