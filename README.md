# Renon

### Nigerian Marketplace & Delivery Platform

Renon is a Nigerian local marketplace and delivery platform designed to connect customers, vendors, and riders within one ecosystem.

The project explores how a single platform can support product discovery, vendor management, and local delivery workflows while maintaining a consistent user experience across different roles.

## Project Status

**Portfolio project — actively developed**

Renon is currently a development and portfolio project. The core user experiences and role-based workflows have been implemented, with additional features and refinements planned for future development.

## What I Built

Renon was built with a role-based architecture supporting three primary user experiences:

### Customer

* Account registration and authentication flows
* Customer profile setup
* Marketplace categories
* Product and vendor discovery
* Search experience
* Vendor listings
* Product cards and marketplace components

### Vendor

* Vendor account flow
* Vendor dashboard
* Product management foundation
* Store management
* Order management foundation
* Add product workflow

### Rider

* Rider onboarding and verification flows
* Delivery dashboard
* Delivery management
* Active delivery workflow
* Delivery details
* Earnings
* Notifications
* Vehicle and profile management
* Rider settings and support

## Screenshots

### Welcome & Authentication

![Renon Welcome](Screenshots/Renon%20Welcome.png)

![Account Type](Screenshots/Account%20Type.png)

![Customer Sign Up](Screenshots/Renon%20Customer%20SignUp.png)

![Sign In](Screenshots/Renon%20SignIn.png)

![OTP Verification](Screenshots/Renon%20OTP.png)

### Customer

![Customer Dashboard](Screenshots/Customer%20Dashboard.png)

![Vendor Listing](Screenshots/Renon%20Customer%20VendorListing.png)

### Vendor

![Vendor Dashboard](Screenshots/Renon%20Vendor%20Dashboard.png)

![Add Product](Screenshots/Add%20Product.png)

![Store Management](Screenshots/Renon%20Store%20Management.png)

### Rider

![Rider Dashboard](Screenshots/Renon%20Rider%20Dashboard.png)

![Rider Deliveries](Screenshots/Renon%20Rider%20Deliveries.png)

![Rider Earnings](Screenshots/Renon%20Rider%20Earning.png)

![Rider Profile](Screenshots/Renon%20Rider%20Profile.png)

![Rider Verification](Screenshots/Renon%20Rider%20Verification.png)

![Rider Help & Support](Screenshots/Renon%20Rider%20Help%26Support.png)

## Demo

A full product walkthrough video will be added here.

<!-- Add demo video or GIF here -->

## Tech Stack

* Flutter
* Dart
* Material Design
* Responsive UI
* Git & GitHub

## Architecture

Renon is structured around reusable application layers and role-based workflows.

```text
lib/
├── app/
├── models/
├── screens/
│   ├── auth/
│   ├── customer/
│   ├── rider/
│   └── vendor/
├── services/
├── theme/
└── widgets/
```

## Challenges & Learning

Building Renon has been an opportunity to work through the challenges of developing a multi-role application rather than a single-user interface.

Some of the areas I worked through include:

* Structuring Flutter screens around different user roles and workflows
* Building reusable UI components
* Managing navigation across multiple application flows
* Designing marketplace, vendor, and delivery experiences within one product
* Maintaining consistency across different parts of the application
* Working with Git and GitHub throughout development
* Thinking about responsive layouts for different screen sizes
* Turning a product idea into a structured application rather than a collection of individual screens

The project has also helped me better understand the difference between building individual interfaces and thinking about the experience of an entire product.

## Purpose

Renon started from an interest in solving everyday local marketplace and delivery problems in Nigeria.

The project is also part of my journey toward becoming a stronger software developer by taking an idea from concept to a structured, multi-role Flutter application.

## Future Development

Potential future development includes:

* Backend/API integration
* Persistent authentication
* Real payment integration
* Real-time order and delivery tracking
* Production database
* Vendor and rider verification systems
* Notifications
* Deployment and production testing

## Author

**Adeola Adeniyi Hephzibah**

Built with Flutter & Dart.
