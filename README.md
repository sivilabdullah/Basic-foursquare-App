# Foursquare Clone

This project is a simple Foursquare clone where users can save the names, descriptions, types, and locations of the places they visit. Additionally, it integrates with Apple Maps to provide a navigation feature. The project is developed using Swift programming language and utilizes Parse and Back4App for backend functionality.


## Features

- Users can sign up and log in to the application.
- Users can add new places they visit by providing the name, description, type, and location.
- Users can view a list of places they have added.
- Users can view details of a specific place, including its name, description, type, and location on the map.
- Users can navigate to a place using Apple Maps integration.

| Screenshot 1 | Screenshot 2 |
| ------------ | ------------ |
| ![Screenshot 2023-05-26 at 4 26 00 PM](https://github.com/sivilabdullah/Basic-foursquare-App/assets/57291537/9245eff3-e638-4f5c-9886-2f8f70a8d5c1)| ![Screenshot 2023-05-26 at 4 22 29 PM](https://github.com/sivilabdullah/Basic-foursquare-App/assets/57291537/0334ec8a-7412-49c2-878f-d63ddf25f822) |
| ![Screenshot 2023-05-26 at 4 23 59 PM](https://github.com/sivilabdullah/Basic-foursquare-App/assets/57291537/48ab8be0-dd6a-45a5-a71b-933c31de70d9) | ![Screenshot 2023-05-26 at 4 23 43 PM](https://github.com/sivilabdullah/Basic-foursquare-App/assets/57291537/c2ed7d90-baa0-420a-b1a3-1d3e1433bc78) |
## Installation

1. Clone or download this project.
2. Install the required dependencies using Cocoapods. Run the following command in the project directory:
```
pod install
```
3. Open the `FoursquareClone.xcworkspace` file in Xcode.
4. Configure the Parse and Back4App credentials in the project's configuration file (`AppDelegate.swift`) with your own Parse and Back4App account information.
5. Build and run the project in Xcode.
6. The application will run on the simulator or a physical device.

## Usage

- Upon launching the application, you will see a login or registration screen where users can sign up or log in.
- After signing up or logging in, you will be taken to the main screen where you can add new places or view the list of places you have added.
- To add a new place, click on the "Add Place" button and provide the required information (name, description, type, and location).
- To view the details of a specific place, click on a place from the list. You will see the name, description, type, and location of the place, as well as the option to navigate to it using Apple Maps.

## Dependencies

This project relies on the following dependencies, which are managed using Cocoapods:

- Parse: A backend-as-a-service platform for managing data and user authentication.
- Back4App: A Parse hosting and backend service provider.

For more information about these dependencies, please refer to their respective documentation.

## Contributing

Contributions to this project are welcome. If you would like to contribute, please follow the guidelines outlined in the `CONTRIBUTING.md` file and submit a pull request.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). For more information, please see the `LICENSE` file.

## Contact

If you have any issues, suggestions, or questions, please use pull request
