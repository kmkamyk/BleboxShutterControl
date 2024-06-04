# ShutterBoxApp

ShutterBoxApp is a macOS application for controlling shutters by Blebox (shutterbox). The application works exclusively from the status bar, allowing users to add, remove, and adjust the position of shutters. Application uses the local API issued by shutterbox roller shutter controllers https://technical.blebox.eu/openapi_shutterbox/openAPI_shutterBox_20190911.html

## Features

- Add new shutters using their URL
- Remove existing shutters
- Adjust shutter positions using sliders
- Automatically save and load shutters from a JSON file
- Fetch and display current shutter positions
- Periodically refresh shutter positions every 5 seconds

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/ShutterBoxApp.git
    ```

2. Open the project in Xcode:
    ```bash
    cd ShutterBoxApp
    open Project/ShutterBoxApp.xcodeproj
    ```

3. Build and run the application:
    - Select the target device (e.g., "My Mac")
    - Click the "Run" button or press `Cmd+R`

## Usage

1. When the application starts, it will appear in the macOS status bar.

2. To add a new shutter:
    - Enter the shutter's base URL in the text field at the bottom of the application window.
    - Click "Add Shutter".

3. To adjust a shutter's position:
    - Use the slider next to the shutter's position label.
    - The position will update in real-time.

4. To remove a shutter:
    - Click the trash icon next to the corresponding shutter.

## File Structure

- `AppDelegate.swift`: Sets up the application and status bar controller.
- `ContentView.swift`: The main view of the application containing the list of shutters and controls for adding new shutters.
- `PopoverController.swift`: Manages the popover that displays the content view.
- `StatusBarController.swift`: Manages the status bar item and its interactions.
- `ShutterBoxAPI.swift`: Handles API requests, loading/saving shutters, and refreshing shutter positions.

## Classes

### `ShutterBoxAPI`

- Manages the list of shutters.
- Provides methods for fetching and setting shutter positions.
- Saves and loads shutters from a JSON file.

### `Shutter`

- Represents a single shutter with a base URL and position.

### `ShutterStateResponse`, `ShutterState`, `ShutterPosition`

- Models for decoding the API responses.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.

## License

This project is licensed under the GNU 3.0 - see the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or suggestions, feel free to open an issue or contact the project maintainer at your.email@example.com.
