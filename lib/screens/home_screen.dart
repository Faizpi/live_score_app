import 'package:flutter/material.dart';
import 'package:live_score/main.dart'; 
import 'package:live_score/models/match_model.dart';
import 'package:live_score/screens/match_detail_screen.dart';
import 'package:live_score/widgets/match_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Match> _allMatches = [
    // == Pertandingan Sedang Berlangsung (Live) ==
    Match(
      team1Name: 'BAR', // Barcelona
      team1Logo: 'assets/images/bar.png',
      team2Name: 'PSG', // Paris Saint-Germain
      team2Logo: 'assets/images/psg.png',
      team1Score: 1,
      team2Score: 2,
      matchTime: '72:18', // Live
      league: 'UEFA Champions League - Quarter Final',
      odds1: '2.05',
      oddsX: '3.6',
      odds2: '3.50',
      matchImage: 'assets/images/match1.png',
      isLive: true,
    ),
    Match(
      team1Name: 'MCI', // Manchester City
      team1Logo: 'assets/images/mc.png',
      team2Name: 'ARS', // Arsenal
      team2Logo: 'assets/images/ars.png',
      team1Score: 0,
      team2Score: 0,
      matchTime: '40:11', // Live
      league: 'Premier League',
      odds1: '1.95',
      oddsX: '3.4',
      odds2: '3.80',
      matchImage: 'assets/images/match2.png',
      isLive: true,
    ),

    // == Pertandingan Selesai (Full Time) ==
    Match(
      team1Name: 'RMA', // Real Madrid
      team1Logo: 'assets/images/md.png',
      team2Name: 'MCI', // Manchester City
      team2Logo: 'assets/images/mc.png',
      team1Score: 3,
      team2Score: 2,
      matchTime: 'Full Time', // Selesai
      league: 'UEFA Champions League - Round of 16',
      odds1: '2.40',
      oddsX: '3.2',
      odds2: '2.90',
      matchImage: 'assets/images/barcelona2025.png',
    ),
    Match(
      team1Name: 'BAY', // Bayern Munich
      team1Logo: 'assets/images/mun.png',
      team2Name: 'INT', // Inter Milan
      team2Logo: 'assets/images/mln.png',
      team1Score: 2,
      team2Score: 0,
      matchTime: 'Full Time', // Selesai
      league: 'UEFA Champions League - Quarter Final',
      odds1: '1.90',
      oddsX: '3.5',
      odds2: '3.80',
      matchImage: 'assets/images/barcelona2025.png',
    ),
    Match(
      team1Name: 'LVP', // Liverpool
      team1Logo: 'assets/images/lv.png',
      team2Name: 'NAP', // Napoli
      team2Logo: 'assets/images/npl.png',
      team1Score: 4,
      team2Score: 3,
      matchTime: 'Full Time', // Selesai
      league: 'UEFA Champions League - Round of 16',
      odds1: '2.20',
      oddsX: '3.3',
      odds2: '3.10',
      matchImage: 'assets/images/barcelona2025.png',
    ),
    Match(
      team1Name: 'ESP', // Spain
      team1Logo: 'assets/images/sp.png',
      team2Name: 'POR', // Portugal
      team2Logo: 'assets/images/pr.png',
      team1Score: 2,
      team2Score: 1,
      matchTime: 'Full Time', // Selesai
      league: 'UEFA Nations League 2025',
      odds1: '2.30',
      oddsX: '3.3',
      odds2: '2.90',
      matchImage: 'assets/images/barcelona2025.png',
    ),
    Match(
      team1Name: 'ARG', // Argentina
      team1Logo: 'assets/images/arg.png',
      team2Name: 'BRA', // Brazil
      team2Logo: 'assets/images/br.png',
      team1Score: 3,
      team2Score: 2,
      matchTime: 'Full Time', // Selesai
      league: 'Copa America 2025',
      odds1: '2.40',
      oddsX: '3.1',
      odds2: '2.80',
      matchImage: 'assets/images/barcelona2025.png',
    ),

    // == Pertandingan Akan Datang (Upcoming) ==
    Match(
      team1Name: 'BAR', // Barcelona
      team1Logo: 'assets/images/bar.png',
      team2Name: 'RMA', // Real Madrid
      team2Logo: 'assets/images/md.png',
      team1Score: 0,
      team2Score: 0,
      matchTime: '26 Okt 21:00', // Akan Datang
      league: 'La Liga - El Clásico',
      odds1: '2.20',
      oddsX: '3.5',
      odds2: '2.80',
      matchImage: 'assets/images/barcelona2025.png',
    ),
    Match(
      team1Name: 'DOR', // Borussia Dortmund
      team1Logo: 'assets/images/dortmund.png',
      team2Name: 'JUV', // Juventus
      team2Logo: 'assets/images/jv.png',
      team1Score: 0,
      team2Score: 0,
      matchTime: '02 Nov 02:00', // Akan Datang
      league: 'UEFA Champions League - Quarter Final',
      odds1: '2.60',
      oddsX: '3.1',
      odds2: '2.70',
      matchImage: 'assets/images/barcelona2025.png',
    ),
    Match(
      team1Name: 'MUN', // Manchester United
      team1Logo: 'assets/images/mu.png',
      team2Name: 'CHE', // Chelsea
      team2Logo: 'assets/images/che.png',
      team1Score: 0,
      team2Score: 0,
      matchTime: '05 Nov 22:30', // Akan Datang
      league: 'Premier League',
      odds1: '2.40',
      oddsX: '3.0',
      odds2: '2.90',
      matchImage: 'assets/images/barcelona2025.png',
    ),
  ];

  late List<Match> _filteredMatches;
  final TextEditingController _searchController = TextEditingController();

  // --- STATE BARU UNTUK COLLAPSIBLE SECTION ---
  late Map<String, bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    _filteredMatches = _allMatches;
    _searchController.addListener(_filterMatches);
    // Defaultnya, semua section terbuka
    _isExpanded = {
      'Live Matches': true,
      'Full Time': true,
      'Upcoming Matches': true,
    };
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMatches() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMatches = _allMatches.where((match) {
        final team1NameLower = match.team1Name.toLowerCase();
        final team2NameLower = match.team2Name.toLowerCase();
        return team1NameLower.contains(query) || team2NameLower.contains(query);
      }).toList();
    });
  }

  // --- WIDGET HELPER BARU UNTUK MEMBUAT SECTION ---
  Widget _buildMatchSection(String title, List<Match> matches) {
    if (matches.isEmpty) {
      return const SizedBox.shrink(); // Jangan tampilkan section jika tidak ada pertandingan
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              setState(() {
                _isExpanded[title] = !_isExpanded[title]!;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  _isExpanded[title]!
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
        // Tampilkan daftar pertandingan hanya jika section sedang terbuka (expanded)
        if (_isExpanded[title]!)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MatchDetailScreen(match: match),
                  ),
                ),
                child: MatchCard(match: match),
              );
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- PENGELOMPOKAN DATA BERDASARKAN STATUS ---
    final liveMatches = _filteredMatches.where((m) => m.isLive).toList();
    final fullTimeMatches = _filteredMatches
        .where((m) => m.matchTime.toLowerCase() == 'full time')
        .toList();
    final upcomingMatches = _filteredMatches
        .where((m) => !m.isLive && m.matchTime.toLowerCase() != 'full time')
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/barcelona2025.png'),
          ),
        ),
        title: const Text(
          'Faiz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(height: 10),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search team...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: AppColors.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                SportChip(
                  icon: Icons.sports_soccer,
                  label: 'Football',
                  isSelected: true,
                ),
                SportChip(icon: Icons.sports_basketball, label: 'Basketball'),
                SportChip(icon: Icons.sports_tennis, label: 'Tennis'),
                SportChip(icon: Icons.sports_esports, label: 'eSports'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // --- MENAMPILKAN SETIAP SECTION ---
          _buildMatchSection('Live Matches', liveMatches),
          _buildMatchSection('Upcoming Matches', upcomingMatches),
          _buildMatchSection('Full Time', fullTimeMatches),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.cardBackground.withOpacity(0.8),
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class SportChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  const SportChip({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Chip(
        backgroundColor: isSelected
            ? AppColors.primaryGreen
            : AppColors.cardBackground,
        label: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
