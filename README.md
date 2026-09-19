# Renon

### Nigerian Marketplace & Delivery Platform

Renon is a Nigerian local marketplace and delivery platform designed to connect customers, vendors, and riders within one ecosystem.

The project focuses on building a polished product experience for discovering products and services, managing orders, and supporting marketplace and delivery workflows.

## Features

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
* Vendor dashboard foundation
* Product management foundation
* Order management foundation

### Rider

* Rider onboarding and verification flows
* Delivery dashboard
* Active delivery workflow
* Delivery details
* Earnings
* Notifications
* Vehicle and profile management
* Rider settings and support

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

## Screenshots

### Welcome & Authentication

![Renon Welcome](screenshots/Renon%20Welcome.png)

![Account Type](screenshots/Accounty%20Type.png)

![Customer Sign Up](screenshots/Renon%20Customer%20SignUp.png)

![Sign In](screenshots/Renon%20SignIn.png)

![OTP Verification](screenshots/Renon%20OTP.png)

### Customer

![Customer Dashboard](screenshots/Customer%20Dashboard.png)

![Vendor Listing](screenshots/Renon%20Customer%20VendorListing.png)

### Vendor

![Vendor Dashboard](screenshots/Renon%20Vendor%20Dashboard.png)

![Add Product](screenshots/Add%20Product.png)

![Store Management](screenshots/Renon%20Store%20Management.png)

### Rider

![Rider Dashboard](screenshots/Renon%20Rider%20Dashboard.png)

![Rider Deliveries](screenshots/Renon%20Rider%20Deliveries.png)

![Rider Earnings](screenshots/Renon%20Rider%20Earning.png)

![Rider Profile](screenshots/Renon%20Rider%20Profile.png)

![Rider Verification](screenshots/Renon%20Rider%20Verification.png)

![Rider Help & Support](screenshots/Renon%20Rider%20Help%26Support.png)

````

**Save it.**

The critical fix is this part immediately after the architecture tree:

```text
└── widgets/
````

followed by:

```text
```

That closes the code block **before** `## Screenshots`.

Once you've replaced it and saved it, **don't commit yet**. Tell me when it's saved and we'll verify the filenames first.
