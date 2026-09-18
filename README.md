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

## Project Structure

The application separates core responsibilities into reusable layers:

* **app/** — Application-level configuration, routing, and setup
* **models/** — Data models and application entities
* **screens/** — Feature-specific user interfaces organized by workflow and role
* **services/** — Authentication and application service logic
* **theme/** — Shared colors, typography, spacing, and UI styling
* **widgets/** — Reusable UI components

## Status

Renon is currently under active development, with the core customer, vendor, and rider experiences being built incrementally.

## Purpose

Renon was created as a portfolio project exploring how a multi-role marketplace and delivery platform can be designed and implemented with Flutter.

The project demonstrates:

* Role-based application flows
* Responsive Flutter UI development
* Reusable component architecture
* Marketplace UX patterns
* Delivery workflow design
* Multi-role product thinking
* Git and GitHub-based development

```

**One important thing:** because Renon is not launched yet, I intentionally kept phrases like **“foundation,” “currently under active development,”** and **“portfolio project.”** That makes the README credible without implying that Renon already has real customers, vendors, riders, payments, or deliveries.

And since you’re using this for your **GitHub/LinkedIn portfolio**, this gives you a much stronger presentation than simply listing screens.
```

