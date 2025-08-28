// File: lib/screens/home_screen.dart
// This file handles the app's layout, including the MemorialFeed and a responsive
// hero section that adapts to screen size.

import 'package:flutter/material.dart';
import 'package:solace/screens/memorial_detail_screen.dart';
import 'package:solace/screens/create_memorial_screen.dart'; // Import the new screen

// The home screen of our application.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Helper function to handle navigation to the Create Memorial screen
    void navigateToCreateMemorial() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateMemorialScreen(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solace'),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () {
              // Action for a dedicated search screen.
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFFC9AD8A)),
            onPressed: () {
              // Action for a notifications screen.
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () {
              // Action for a user profile or account screen.
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToCreateMemorial,
        label: Text('Create a Memorial', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check if the screen is wide enough for a two-column layout.
          if (constraints.maxWidth > 800) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // A static left-hand side panel for a wider screen.
                SizedBox(
                  width: 300,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "A place to remember.",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Honor and remember your loved ones by creating a beautiful digital memorial. Share stories, photos, and connect with a community that cares.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          // New "My Memorials" section
                          const MyMemorialsCard(),
                          const SizedBox(height: 24),
                          // A button to create a memorial
                          ElevatedButton(
                            onPressed: navigateToCreateMemorial, // Use the new function
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            ),
                            child: const Text('Create a Memorial'),
                          ),
                          const SizedBox(height: 16),
                          // New Quick Links section
                          const QuickLinksSection(),
                        ],
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: MemorialFeed(),
                ),
              ],
            );
          } else {
            // A single-column layout for a smaller screen.
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // A beautiful hero section for a smaller screen.
                  HeroHeader(onTapCreate: navigateToCreateMemorial), // Pass the function to HeroHeader
                  // New "My Memorials" section for smaller screens
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: MyMemorialsCard(),
                  ),
                  // New "Quick Links" section for smaller screens
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: QuickLinksSection(),
                  ),
                  // Section for recent memories or tributes
                  _buildSection(
                    context,
                    title: 'Recent Memories',
                    content: const RecentMemoriesSection(),
                  ),
                  // A button to join the community
                  _buildSection(
                    context,
                    title: 'Join Our Community',
                    content: const CommunitySection(),
                  ),
                  const MemorialFeed(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Helper method to build a section with a title and content.
  Widget _buildSection(BuildContext context, {required String title, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }
}

// A more intuitive and beautiful hero section for a single-column layout.
class HeroHeader extends StatelessWidget {
  final VoidCallback onTapCreate; // Add a callback for the create button

  const HeroHeader({super.key, required this.onTapCreate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "A space for remembrance.",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Honor the life and legacy of your loved ones. Create a beautiful digital memorial to share stories, photos, and messages of compassion.",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onTapCreate, // Use the callback here
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: const Text('Create'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Link to 'Find a Memorial' screen
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(color: Theme.of(context).colorScheme.primary),
                    ),
                    child: const Text('Find'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// New widget to show the user's memorial count.
class MyMemorialsCard extends StatelessWidget {
  const MyMemorialsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // A placeholder for the number of memorials.
    const int memorialCount = 3;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.favorite,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Use min size to prevent overflow
              children: [
                // Tooltip is added to show the full title on hover/long-press.
                Tooltip(
                  message: 'My Memories',
                  child: Text(
                    'My Memories',
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis, // Ensures the title truncates if it doesn't fit
                  ),
                ),
                const SizedBox(height: 4),
                // Replaced the longer sentence with a more captivating phrase.
                Text(
                  'My Sacred Space',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.secondary),
            onPressed: () {
              // Action to navigate to a "My Memorials" list screen.
            },
          ),
        ],
      ),
    );
  }
}

// New widget for quick navigation links.
class QuickLinksSection extends StatelessWidget {
  const QuickLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Links",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          icon: const Icon(Icons.group, color: Color(0xFFC9AD8A)),
          label: const Text('Find a Community'),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            alignment: Alignment.centerLeft,
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.settings, color: Color(0xFFC9AD8A)),
          label: const Text('Settings'),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            alignment: Alignment.centerLeft,
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.help_outline, color: Color(0xFFC9AD8A)),
          label: const Text('Help & Support'),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            alignment: Alignment.centerLeft,
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}


// A reusable widget to display a single memorial. It is now part of this file.
class MemorialCard extends StatelessWidget {
  final String name;
  final String dates;
  final String tribute;
  final String imageUrl;

  const MemorialCard({
    super.key,
    required this.name,
    required this.dates,
    required this.tribute,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, // Ensures the image has rounded corners.
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
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  dates,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: const Color(0xFF7D684D)),
                ),
                const SizedBox(height: 12),
                Text(
                  tribute,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the new MemorialDetailScreen.
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
                  child: const Text('View Memorial'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// A simulated feed of memorials. In a real app, this would be populated
// with data fetched from Firebase Firestore.
class MemorialFeed extends StatelessWidget {
  const MemorialFeed({super.key});

  // Sample data to populate the feed.
  static const List<Map<String, String>> sampleMemorials = [
    {
      'name': 'Isabella Rodriguez',
      'dates': '1945 - 2023',
      'image': 'https://placehold.co/600x400/AD9492/FFF?text=Isabella',
      'tribute':
          'A beacon of light and kindness who touched every life she encountered. Her memory is a reminder to all of us to lead with compassion and an open heart. She will be dearly missed but never forgotten.',
    },
    {
      'name': 'Samuel Green',
      'dates': '1970 - 2024',
      'image': 'https://placehold.co/600x400/90A4AE/FFF?text=Samuel',
      'tribute':
          'An incredible artist and a loving father. His art lives on, a testament to his vibrant spirit and passion for life. He saw beauty in everything and everyone.',
    },
    {
      'name': 'Evelyn Carter',
      'dates': '1930 - 2022',
      'image': 'https://placehold.co/600x400/A0AE90/FFF?text=Evelyn',
      'tribute':
          'A devoted teacher who inspired generations with her wisdom. Her classroom was a place of warmth, curiosity, and boundless encouragement. She shaped countless futures.',
    },
    {
      'name': 'Daniel Lee',
      'dates': '1985 - 2024',
      'image': 'https://placehold.co/600x400/607D8B/FFF?text=Daniel',
      'tribute':
          'A cherished friend and adventurer. His spirit remains with us, in every mountain climbed and every trail explored. His laughter was contagious and his heart was pure.',
    },
    {
      'name': 'Jane Doe',
      'dates': '1965 - 2020',
      'image': 'https://placehold.co/600x400/A52A2A/FFF?text=Jane',
      'tribute': 'A loving mother and a pillar of her community. She was known for her generosity and her beautiful garden.',
    },
    {
      'name': 'Michael Smith',
      'dates': '1958 - 2021',
      'image': 'https://placehold.co/600x400/808000/FFF?text=Michael',
      'tribute': 'A devoted husband and a talented musician. His melodies brought joy to all who heard them.',
    },
    {
      'name': 'Sophia Chen',
      'dates': '1992 - 2023',
      'image': 'https://placehold.co/600x400/663399/FFF?text=Sophia',
      'tribute': 'An inspiring scientist whose work changed the world. Her curiosity and drive were infectious.',
    },
    {
      'name': 'Robert Johnson',
      'dates': '1940 - 2019',
      'image': 'https://placehold.co/600x400/4682B4/FFF?text=Robert',
      'tribute': 'A veteran and a storyteller. His tales of adventure and life lessons will be treasured forever.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(24.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400.0,
        mainAxisSpacing: 24.0,
        crossAxisSpacing: 24.0,
        childAspectRatio: 0.8,
      ),
      itemCount: sampleMemorials.length,
      itemBuilder: (context, index) {
        final memorial = sampleMemorials[index];
        return MemorialCard(
          name: memorial['name']!,
          dates: memorial['dates']!,
          tribute: memorial['tribute']!,
          imageUrl: memorial['image']!,
        );
      },
    );
  }
}

// Section to display recent memories or tributes
class RecentMemoriesSection extends StatelessWidget {
  const RecentMemoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for recent memories
    const List<Map<String, String>> recentMemories = [
      {
        'tribute': 'A wonderful person who will be missed by many.',
        'author': 'Maria L.',
      },
      {
        'tribute': 'Thinking of you always.',
        'author': 'Alex G.',
      },
      {
        'tribute': 'Forever in our hearts. Thank you for all the happy memories.',
        'author': 'David P.',
      },
    ];

    return Column(
      children: [
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recentMemories.length,
            itemBuilder: (context, index) {
              final memory = recentMemories[index];
              return Card(
                margin: const EdgeInsets.only(right: 16.0),
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '“${memory['tribute']}”',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '- ${memory['author']}',
                        style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Link to a 'View all Tributes' screen.
          },
          child: const Text('View All Tributes'),
        ),
      ],
    );
  }
}

// Section for community engagement.
class CommunitySection extends StatelessWidget {
  const CommunitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Text(
            'Connect with Others',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Share and find support from a community that understands.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Action to navigate to a community screen.
            },
            child: const Text('Join the Community'),
          ),
        ],
      ),
    );
  }
}
