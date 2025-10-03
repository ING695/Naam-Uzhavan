# App Flow Diagram

This document describes the user flow and navigation structure of the Naam Uzhavan app.

## Authentication Flow

```
┌─────────────┐
│ Splash Page │
└──────┬──────┘
       │
       ▼
  Is User Logged In?
       │
       ├─── Yes ──────────────────┐
       │                          │
       ├─── No ───────┐           │
       │               │           │
       ▼               ▼           ▼
┌────────────┐   ┌──────────┐   ┌──────────┐
│ Login Page │   │          │   │   Home   │
│            │   │ Register │   │   Page   │
│  - Email   │◄──│   Page   │   │          │
│  - Password│   │          │   │          │
└──────┬─────┘   └────┬─────┘   └──────────┘
       │               │
       └───── Sign In/Register ──┘
                 Success
```

## Main Navigation Structure

```
┌────────────────────────────────────────────────────┐
│                    App Bar                         │
│  [Title]                          [Help] [Logout]  │
└────────────────────────────────────────────────────┘
│                                                    │
│                  Content Area                      │
│                                                    │
│                                                    │
└────────────────────────────────────────────────────┘
│          Bottom Navigation Bar                     │
│  [Home]  [New Plan]  [My Work]  [Account]        │
└────────────────────────────────────────────────────┘
```

## Feature Flows

### 1. Home Page Flow

```
┌──────────────────┐
│    Home Page     │
│                  │
│  ┌────────────┐  │
│  │ Welcome    │  │
│  │ Card       │  │
│  └────────────┘  │
│                  │
│  Quick Actions:  │
│  ┌──────┬──────┐ │
│  │New   │My    │ │
│  │Plan  │Work  │ │
│  ├──────┼──────┤ │
│  │My    │Supp- │ │
│  │Acc   │ort   │ │
│  └──────┴──────┘ │
│                  │
│  Recent Activity │
└──────────────────┘
```

### 2. New Plan Flow

```
┌───────────────┐
│  New Plan     │
│   Page        │
│               │
│ ┌───────────┐ │
│ │Crop Name  │ │
│ └───────────┘ │
│ ┌───────────┐ │
│ │Land Size  │ │
│ └───────────┘ │
│ ┌───────────┐ │
│ │Location   │ │
│ └───────────┘ │
│ ┌───────────┐ │
│ │Start Date │ │
│ └───────────┘ │
│ ┌───────────┐ │
│ │Harvest    │ │
│ │Date (opt) │ │
│ └───────────┘ │
│ ┌───────────┐ │
│ │Notes (opt)│ │
│ └───────────┘ │
│               │
│ [Create Plan] │
└───────┬───────┘
        │
        ▼
  Save to Firebase
        │
        ▼
  ┌────────────┐
  │  Success   │
  │  Message   │
  └────────────┘
        │
        ▼
   Return to
   Previous Page
```

### 3. My Work Flow

```
┌─────────────────┐
│   My Work       │
│   Page          │
│                 │
│ Load Plans from │
│    Firebase     │
│        │        │
│        ▼        │
│  Has Plans?     │
│   ┌──┴──┐       │
│   │     │       │
│  Yes   No       │
│   │     │       │
│   │     ▼       │
│   │ ┌────────┐  │
│   │ │ Empty  │  │
│   │ │ State  │  │
│   │ └────────┘  │
│   │             │
│   ▼             │
│ ┌─────────────┐ │
│ │  Plan Card  │ │
│ │  - Crop     │ │
│ │  - Size     │ │
│ │  - Location │ │
│ │  - Dates    │ │
│ │  - Days Left│ │
│ │  [Delete]   │ │
│ └─────────────┘ │
│                 │
│ [Refresh]       │
└─────────────────┘
```

### 4. My Account Flow

```
┌─────────────────┐
│  My Account     │
│   Page          │
│                 │
│ ┌─────────────┐ │
│ │   Avatar    │ │
│ └─────────────┘ │
│                 │
│ Profile Info:   │
│ - Name          │
│ - Email         │
│ - Phone         │
│ - User ID       │
│                 │
│ Settings:       │
│ - Notifications │
│ - Language      │
│ - About         │
│                 │
│ Actions:        │
│ - Change Pass   │
│ - Logout        │
└─────────────────┘
        │
        │ (Logout)
        ▼
  Confirm Dialog
        │
        ▼
   Sign Out
        │
        ▼
   Login Page
```

### 5. Support Flow

```
┌─────────────────┐
│  Support        │
│   Page          │
│                 │
│ Contact Us:     │
│ - Email         │
│ - Phone         │
│ - Live Chat     │
│                 │
│ FAQs:           │
│ ┌─────────────┐ │
│ │ Question 1  │ │
│ │ [Expand]    │ │
│ └─────────────┘ │
│ ┌─────────────┐ │
│ │ Question 2  │ │
│ │ [Expand]    │ │
│ └─────────────┘ │
│                 │
│ Feedback Form:  │
│ ┌─────────────┐ │
│ │  Textarea   │ │
│ └─────────────┘ │
│ [Submit]        │
└─────────────────┘
```

## Data Flow Architecture

```
┌──────────┐
│   UI     │
│ (Widget) │
└────┬─────┘
     │ User Action
     ▼
┌──────────┐
│  Event   │
└────┬─────┘
     │
     ▼
┌──────────┐
│   BLoC   │
└────┬─────┘
     │ Business Logic
     ▼
┌──────────┐
│Repository│
└────┬─────┘
     │
     ▼
┌──────────┐
│ Firebase │
│ Backend  │
└────┬─────┘
     │ Response
     ▼
┌──────────┐
│  Model   │
└────┬─────┘
     │
     ▼
┌──────────┐
│  Entity  │
└────┬─────┘
     │
     ▼
┌──────────┐
│  State   │
└────┬─────┘
     │
     ▼
┌──────────┐
│   UI     │
│ Update   │
└──────────┘
```

## State Transitions

### Authentication States

```
AuthInitial
    │
    ▼
AuthLoading ──┐
    │         │
    ▼         │
AuthAuthenticated  │
    │              │
    ▼              │
AuthLoading       │
    │              │
    ▼              │
AuthUnauthenticated◄┘
    │
    ▼
AuthError
    │
    ▼
AuthUnauthenticated
```

### Plan Management States

```
PlanInitial
    │
    ▼
PlanLoading
    │
    ├──► PlanCreated ──► PlanInitial
    │
    ├──► PlansLoaded
    │        │
    │        ▼
    │    PlanLoading
    │        │
    │        ▼
    │    PlanDeleted ──► PlansLoaded
    │
    └──► PlanError ──► PlansLoaded/PlanInitial
```

## Screen Navigation Map

```
Splash
  │
  ├─► Login ──► Register
  │      │
  │      └────► Home ──┬─► New Plan ──┐
  │                    │              │
  └──────────────────► │              │
                       ├─► My Work ◄──┘
                       │      │
                       │      └─► Plan Details
                       │             │
                       │             └─► Delete Confirm
                       │
                       ├─► My Account ──┬─► Settings
                       │                │
                       │                └─► About
                       │
                       └─► (via AppBar) Support ──┬─► FAQs
                                                   │
                                                   └─► Contact
```

## User Journey Examples

### First Time User

```
1. Open App → Splash Screen
2. Not Logged In → Login Page
3. Click Register → Register Page
4. Fill Details → Submit
5. Auto Login → Home Page
6. See Welcome Card
7. Click "New Plan" → New Plan Page
8. Fill Plan Details → Submit
9. Success Message → Return to Home
10. Click "My Work" → See Created Plan
```

### Returning User

```
1. Open App → Splash Screen
2. Already Logged In → Home Page
3. See Quick Actions
4. Click "My Work" → View All Plans
5. Review Plans
6. Click Account → View Profile
7. Logout → Login Page
```

## Error Handling Flow

```
User Action
    │
    ▼
Try Operation
    │
    ├─► Success ──► Show Success UI
    │
    └─► Error ──┬─► Network Error ──► Show Retry
                │
                ├─► Auth Error ──► Redirect to Login
                │
                ├─► Validation Error ──► Show Form Error
                │
                └─► Unknown Error ──► Show Generic Error
```

## Offline/Online Behavior

```
User Performs Action
    │
    ▼
Check Network
    │
    ├─► Online ──► Proceed Normally
    │
    └─► Offline ──► Show Offline Message
                    │
                    └─► Cache Data (future feature)
```

This flow diagram provides a comprehensive view of how users navigate through the Naam Uzhavan app and how data flows through the system.
