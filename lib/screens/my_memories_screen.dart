// File: lib/screens/my_memories_screen.dart
// This screen displays the user's personal memorials in a UI-rich format,
// offering both grid and list views, and a dedicated filter/sort menu.

import 'package:flutter/material.dart';
import 'package:solace/screens/create_memorial_screen.dart';
import 'package:solace/screens/memorial_detail_screen.dart';

// The main screen for the user's personal memorials.
class MyMemoriesScreen extends StatefulWidget {
  const MyMemoriesScreen({super.key});

  @override
  State<MyMemoriesScreen> createState() => _MyMemoriesScreenState();
}

class _MyMemoriesScreenState extends State<MyMemoriesScreen> {
  // We'll use this boolean to toggle between grid and list views.
  bool isGridView = true;

  // Sample data for user-created memorials.
  final List<Map<String, String>> myMemorials = [
    {
      'name': 'My Loving Mother',
      'dates': '1950 - 2021',
      'image': 'https://placehold.co/600x400/AD9492/FFF?text=Mom',
      'tribute': 'A beacon of love and strength. Her memory is a constant source of comfort and guidance.',
    },
    {
      'name': 'My Dearest Father',
      'dates': '1948 - 2019',
      'image': 'https://placehold.co/600x400/90A4AE/FFF?text=Dad',
      'tribute': 'A man of great wisdom and humor. He taught me everything I needed to know.',
    },
    {
      'name': 'My Sister',
      'dates': '1980 - 2024',
      'image': 'https://placehold.co/600x400/A0AE90/FFF?text=Sister',
      'tribute': 'A free spirit and my best friend. Her adventurous soul will be missed every day.',
    },
    {
      'name': 'My Grandfather',
      'dates': '1925 - 2015',
      'image': 'https://placehold.co/600x400/607D8B/FFF?text=Grandpa',
      'tribute': 'A hero and a storyteller. His tales of the past will live on forever.',
    },
    {
      'name': 'My Best Friend',
      'dates': '1985 - 2023',
      'image': 'https://placehold.co/600x400/A52A2A/FFF?text=Bestie',
      'tribute': 'A true friend who was always there for me. You are deeply missed.',
    },
    {
      'name': 'Our Dog, Max',
      'dates': '2010 - 2022',
      'image': 'https://placehold.co/600x400/808000/FFF?text=Max',
      'tribute': 'The best boy. You brought so much joy to our family.',
    },
  ];

  // Helper function to navigate to the create memorial screen.
  void _navigateToCreateMemorial() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateMemorialScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Memories'),
        elevation: 0,
        actions: [
          // A button to toggle between grid and list view.
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
          // A menu button for filtering and sorting.
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (String result) {
              // Action for sorting/filtering.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sorted by $result')),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Recents',
                child: Text('Most Recent'),
              ),
              const PopupMenuItem<String>(
                value: 'Alphabetical',
                child: Text('Alphabetical'),
              ),
              const PopupMenuItem<String>(
                value: 'Date',
                child: Text('Date'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Welcome Header and Search Bar
            _buildHeaderAndSearch(context),
            const SizedBox(height: 24),

            // Section 2: Displaying Memorials based on the view toggle.
            if (isGridView)
              _buildGridView(context)
            else
              _buildListView(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToCreateMemorial,
        label: Text('Create a Memorial', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  // A helper method to build the header and search bar.
  Widget _buildHeaderAndSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, [User Name]', // Placeholder for the user's name.
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            'This is your sacred space. A place to keep the memory of your loved ones alive.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          // A beautiful search bar.
          TextField(
            decoration: InputDecoration(
              hintText: 'Search your memories...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onChanged: (value) {
              // Action for search functionality.
            },
          ),
        ],
      ),
    );
  }

  // A helper method to build the grid view of memorials.
  Widget _buildGridView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GridView.builder(
        shrinkWrap: true, // Prevents an error with nested scroll views.
        physics: const NeverScrollableScrollPhysics(), // Disables nested scrolling.
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400.0,
          mainAxisSpacing: 24.0,
          crossAxisSpacing: 24.0,
          childAspectRatio: 0.8,
        ),
        itemCount: myMemorials.length,
        itemBuilder: (context, index) {
          final memorial = myMemorials[index];
          return _MemorialCard(
            name: memorial['name']!,
            dates: memorial['dates']!,
            tribute: memorial['tribute']!,
            imageUrl: memorial['image']!,
          );
        },
      ),
    );
  }

  // A helper method to build the list view of memorials.
  Widget _buildListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: myMemorials.length,
        itemBuilder: (context, index) {
          final memorial = myMemorials[index];
          return _MemorialListTile(
            name: memorial['name']!,
            dates: memorial['dates']!,
            tribute: memorial['tribute']!,
            imageUrl: memorial['image']!,
          );
        },
      ),
    );
  }
}

// A reusable card widget for the grid view.
class _MemorialCard extends StatelessWidget {
  final String name;
  final String dates;
  final String tribute;
  final String imageUrl;

  const _MemorialCard({
    required this.name,
    required this.dates,
    required this.tribute,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Navigate to the detail screen on tap.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemorialDetailScreen(
                name: name,
                dates: dates,
                tribute: tribute,
                imageUrl: imageUrl,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, size: 80),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dates,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: const Color(0xFF7D684D)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    tribute,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// A reusable tile widget for the list view.
class _MemorialListTile extends StatelessWidget {
  final String name;
  final String dates;
  final String tribute;
  final String imageUrl;

  const _MemorialListTile({
    required this.name,
    required this.dates,
    required this.tribute,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: () {
          // Navigate to the detail screen on tap.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemorialDetailScreen(
                name: name,
                dates: dates,
                tribute: tribute,
                imageUrl: imageUrl,
              ),
            ),
          );
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[200],
                  child: const Icon(Icons.person, size: 40),
                ),
          ),
        ),
        title: Text(name, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dates, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(tribute, style: Theme.of(context).textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
