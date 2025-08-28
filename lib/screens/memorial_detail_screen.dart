// File: lib/screens/memorial_detail_screen.dart
// This file is a comprehensive and UI-rich screen to display details of a memorial,
// including tributes, a photo gallery, service information, and more.

import 'package:flutter/material.dart';

// The main screen widget for displaying a single memorial's details.
class MemorialDetailScreen extends StatelessWidget {
  final String name;
  final String dates;
  final String tribute;
  final String imageUrl;

  const MemorialDetailScreen({
    super.key,
    required this.name,
    required this.dates,
    required this.tribute,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.transparent, // AppBar over the hero image
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Action to share the memorial link
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Menu for more options
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true, // Allows app bar to be transparent over the body
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Hero Header
            _HeaderSection(
              name: name,
              dates: dates,
              tribute: tribute,
              imageUrl: imageUrl,
            ),
            const SizedBox(height: 24),
            // Section 2: Interactive Tributes
            const _TributesSection(),
            const SizedBox(height: 24),
            // Section 3: Photo Gallery
            const _PhotoGallery(),
            const SizedBox(height: 24),
            // Section 4: Light a Candle
            const _LightACandleSection(),
            const SizedBox(height: 24),
            // Section 5: Life Milestones
            const _LifeMilestonesSection(),
            const SizedBox(height: 24),
            // Section 6: Service Information
            const _ServiceInformationSection(),
            const SizedBox(height: 24),
            // Section 7: Donation & Community
            const _DonationSection(),
          ],
        ),
      ),
    );
  }
}

// Widget for the immersive hero header with the person's photo and details.
class _HeaderSection extends StatelessWidget {
  final String name;
  final String dates;
  final String tribute;
  final String imageUrl;

  const _HeaderSection({
    required this.name,
    required this.dates,
    required this.tribute,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // A gradient overlay for better text readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dates,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  tribute,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for the Tributes & Stories section.
class _TributesSection extends StatelessWidget {
  const _TributesSection();

  @override
  Widget build(BuildContext context) {
    // Sample data for tributes
    final List<Map<String, String>> sampleTributes = [
      {'author': 'John Doe', 'text': 'You will be deeply missed. Your kindness knew no bounds.', 'timestamp': '2 hours ago'},
      {'author': 'Jane Smith', 'text': 'Thinking of you and your family. So many cherished memories.', 'timestamp': '1 day ago'},
      {'author': 'Family & Friends', 'text': 'Your laughter was contagious and your spirit was pure.', 'timestamp': '3 days ago'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tributes & Stories',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                onPressed: () {
                  // Navigate to a screen to add a tribute
                },
                child: const Text('Add a Tribute'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // A horizontally scrolling list of tributes
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sampleTributes.length,
              itemBuilder: (context, index) {
                final tribute = sampleTributes[index];
                return Card(
                  margin: const EdgeInsets.only(right: 16),
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tribute['text']!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '- ${tribute['author']}',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontStyle: FontStyle.italic),
                        ),
                        Text(
                          tribute['timestamp']!,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for the Photo Gallery section.
class _PhotoGallery extends StatelessWidget {
  const _PhotoGallery();

  @override
  Widget build(BuildContext context) {
    // Sample photo URLs
    final List<String> photos = [
      'https://placehold.co/600x400/C9AD8A/FFF?text=Photo+1',
      'https://placehold.co/600x400/AD9492/FFF?text=Photo+2',
      'https://placehold.co/600x400/7D684D/FFF?text=Photo+3',
      'https://placehold.co/600x400/90A4AE/FFF?text=Photo+4',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Photo Gallery',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      photos[index],
                      fit: BoxFit.cover,
                      width: 200,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                            width: 200,
                            color: Colors.grey[200],
                            child: const Icon(Icons.broken_image, size: 50),
                          ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for the "Light a Candle" feature.
class _LightACandleSection extends StatelessWidget {
  const _LightACandleSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_objects, size: 40, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Candles Lit', style: Theme.of(context).textTheme.titleLarge),
                  const Text('1,234 candles lit'), // Placeholder count
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Action to light a candle
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Text('Light a Candle'),
          ),
        ],
      ),
    );
  }
}

// Widget to show key life milestones or achievements.
class _LifeMilestonesSection extends StatelessWidget {
  const _LifeMilestonesSection();

  @override
  Widget build(BuildContext context) {
    // Sample data for milestones
    final List<Map<String, String>> milestones = [
      {'year': '1965', 'event': 'Born in New York City.'},
      {'year': '1987', 'event': 'Graduated from Stanford University.'},
      {'year': '1995', 'event': 'Founded "The Kindness Project" charity.'},
      {'year': '2005', 'event': 'Published award-winning novel, "The Golden Thread".'},
      {'year': '2020', 'event': 'Received the Community Service Award.'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Life Milestones', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          ...milestones.map((milestone) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  alignment: Alignment.center,
                  child: Text(
                    milestone['year']!,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    milestone['event']!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

// Widget for service information.
class _ServiceInformationSection extends StatelessWidget {
  const _ServiceInformationSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Service Information', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          _InfoRow(icon: Icons.calendar_today, text: 'Saturday, October 26, 2024'),
          const SizedBox(height: 8),
          _InfoRow(icon: Icons.access_time, text: '11:00 AM - 1:00 PM'),
          const SizedBox(height: 8),
          _InfoRow(icon: Icons.location_on, text: 'St. Paul’s Memorial Hall, 123 Main St.'),
        ],
      ),
    );
  }
}

// Reusable widget for an information row.
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}

// Widget for donation and call-to-action buttons.
class _DonationSection extends StatelessWidget {
  const _DonationSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'In Honor of Their Memory',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Action for a donation link
            },
            icon: const Icon(Icons.favorite, color: Colors.white),
            label: const Text('Donate to The Kindness Project'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
