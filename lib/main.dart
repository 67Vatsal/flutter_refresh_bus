import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_refresh_bus/flutter_refresh_bus.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Refresh Bus List Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription _subscription;
  List<String> items = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();

    _subscription = RefreshBus().stream.listen((event) {
      if (event.tag == 'list_refresh') {
        _loadData();
      }
    });
  }

  Future<void> _loadData() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      items = List.generate(
        10,
            (index) =>
        'Item ${index + 1} (updated at ${DateTime.now().toLocal().toIso8601String().substring(11, 19)})',
      );
      isLoading = false;
    });
  }

  void _triggerRefresh() {
    RefreshBus().fire(tag: 'list_refresh');
  }

  Future<void> _onPullToRefresh() async {
    RefreshBus().fire(tag: 'list_refresh');
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refresh Bus - Pull to Refresh'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _triggerRefresh,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onPullToRefresh,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.list),
              title: Text(items[index]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _triggerRefresh,
        icon: const Icon(Icons.sync),
        label: const Text('Refresh'),
      ),
    );
  }
}
