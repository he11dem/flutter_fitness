import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  List<String> _items = [];
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _items = [
          'Fullbody Workout',
          'Lowebody Workout',
          'AB Workout',
        ];
        _filteredItems = _items; // Первоначальная фильтрация
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      _filteredItems = _items
          .where((item) => item.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Добавляем кнопку "Назад"
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Enter a search query',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _onSearchTextChanged,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _items.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator()) // Индикатор загрузки
                  : ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_filteredItems[index]),
                          onTap: () {
                            Navigator.popAndPushNamed(context, '/');
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
