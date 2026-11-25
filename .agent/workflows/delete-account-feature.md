---
description: How to implement a Delete Account feature with red styling and confirmation dialog
---

# Delete Account Feature Implementation Guide

This guide covers implementing a complete Delete Account feature with:
- API integration
- Cubit state management
- Red-styled confirmation dialog
- Red drawer menu item

---

## 1. Repository Layer

Add this method to your profile repository (e.g., `profile/domain/repository/repository.dart`):

```dart
Future<bool?> deleteAccount() async {
  try {
    final response = await dioService.deleteData(
      url: "delete-account",
      loading: true,
    );
    if (response.isError == false) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return null;
  }
}
```

---

## 2. Cubit State

Add this state to your profile states file (e.g., `profile/cubit/profile_states.dart`):

```dart
class DeleteAccountSuccess extends ProfileStates {}
```

---

## 3. Cubit Method

Add this method to your profile cubit (e.g., `profile/cubit/profile_cubit.dart`):

```dart
Future<void> deleteAccount() async {
  final response = await profileRepository.deleteAccount();
  if (response == true) {
    Utils.clearUser();
    emit(DeleteAccountSuccess());
  }
}
```

---

## 4. Delete Account Dialog Widget

Create a new file `widgets/delete_account_dialog.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:your_app/core/localization/localization_helper.dart';
import 'package:your_app/features/profile/cubit/profile_cubit.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close, color: Colors.grey, size: 24),
            ),
          ),
          const SizedBox(height: 16),
          
          // Red delete icon
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.delete_forever, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 24),
          
          // Title (red)
          Text(
            LocalizationHelper.tr.delete_account,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          
          // Subtitle
          Text(
            LocalizationHelper.tr.are_you_sure,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          // Action buttons
          Row(
            children: [
              // Delete button (red)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ProfileCubit.get(context).deleteAccount();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(LocalizationHelper.tr.delete),
                ),
              ),
              const SizedBox(width: 16),
              
              // Cancel button (black)
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(LocalizationHelper.tr.cancel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

---

## 5. Menu Item Model Update

Add `textColor` property to your `MenuItemModel`:

```dart
class MenuItemModel {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final Color? textColor; // Add this property

  MenuItemModel({
    required this.title,
    required this.icon,
    required this.onTap,
    this.textColor,
  });
}
```

---

## 6. Drawer Item Widget Update

Update `DrawerItem` to use `textColor`:

```dart
class DrawerItem extends StatelessWidget {
  final MenuItemModel item;

  const DrawerItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(item.icon, color: item.textColor ?? Colors.white),
      title: Text(
        item.title,
        style: TextStyle(color: item.textColor ?? Colors.white), // Use textColor
      ),
      onTap: item.onTap,
    );
  }
}
```

---

## 7. Add Delete Account Menu Item

Add the menu item with red text in your drawer:

```dart
MenuItemModel(
  title: LocalizationHelper.tr.delete_account,
  icon: SvgAssets.delete,
  textColor: Colors.red, // Red text for destructive action
  onTap: () {
    Alerts.bottomSheet(
      context,
      child: BlocProvider.value(
        value: ProfileCubit.get(context),
        child: const DeleteAccountDialog(),
      ),
    );
  },
),
```

---

## 8. BlocConsumer Listener

Handle `DeleteAccountSuccess` state in your listener:

```dart
listener: (context, state) {
  if (state is LogoutSuccess || state is DeleteAccountSuccess) {
    NavigationHelper.pushNamedReplaceAll(Routes.LoginSignupToggleScreen);
  }
},
```

---

## 9. Required Localizations

Add these keys to your localization files:

### English (`app_en.arb`):
```json
{
  "delete_account": "Delete Account",
  "are_you_sure": "Are you sure?",
  "delete": "Delete",
  "cancel": "Cancel"
}
```

### Arabic (`app_ar.arb`):
```json
{
  "delete_account": "حذف الحساب",
  "are_you_sure": "هل أنت متأكد؟",
  "delete": "حذف",
  "cancel": "إلغاء"
}
```

---

## Summary Checklist

- [ ] Add `deleteAccount()` method to repository
- [ ] Add `DeleteAccountSuccess` state
- [ ] Add `deleteAccount()` method to cubit
- [ ] Create `DeleteAccountDialog` widget with red styling
- [ ] Add `textColor` property to `MenuItemModel`
- [ ] Update `DrawerItem` to use `textColor`
- [ ] Add red delete account menu item to drawer
- [ ] Handle `DeleteAccountSuccess` in BlocConsumer listener
- [ ] Add localization strings
