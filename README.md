## 📦 flutter_refresh_bus
```
A lightweight event-based refresh bus for Flutter that lets you trigger UI updates (like list reloads) across widgets without heavy state management.

Perfect for cross-screen refresh, pull-to-refresh, and programmatic UI updates.
```
## ✨ Features
```
🔁 Global refresh events

🧩 Multiple listeners support

🏷️ Optional tag-based refresh

📜 Stream-based (Dart native)

🚫 No BuildContext required

⚡ Extremely lightweight

🧲 Ideal for ListView / RecyclerView-style refresh

```
## Preview


https://github.com/user-attachments/assets/0dde3447-5a00-41f3-82e1-f7e20e95a6d2




## 📦 Installation
Add this to your pubspec.yaml:
```
dependencies:
  flutter_refresh_bus: ^1.0.0
```
Then run:
```
flutter pub get
```

## 🚀 Basic Usage
Trigger a refresh
```
RefreshBus().fire(tag: 'list_refresh');
```
Listen for refresh events

```
late StreamSubscription subscription;

@override
void initState() {
  super.initState();
  subscription = RefreshBus().stream.listen((event) {
    if (event.tag == 'list_refresh') {
      setState(() {
        // reload UI or API data
      });
    }
  });
}

@override
void dispose() {
  subscription.cancel();
  super.dispose();
}
```
## 🧲 Pull-to-Refresh Example
```
RefreshIndicator(
  onRefresh: () async {
    RefreshBus().fire(tag: 'list_refresh');
  },
  child: ListView.builder(
    itemCount: items.length,
    itemBuilder: (_, index) => ListTile(
      title: Text(items[index]),
    ),
  ),
);
```
## Project structure
```
flutter_refresh_bus/
│
├── lib/
│   ├── flutter_refresh_bus.dart
│   └── src/
│       ├── refresh_bus.dart
│       └── refresh_event.dart
│
├── main.dart
│ 
```
## 📄 License
```
MIT License

Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```
