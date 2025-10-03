import 'package:flutter/material.dart';
import 'package:live_score/main.dart';
import 'package:live_score/models/match_model.dart';
import 'package:live_score/widgets/glassmorphic_container.dart';

class MatchCard extends StatelessWidget {
  final Match match;
  const MatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    // Perubahan: Menggunakan GlassmorphicContainer
    return GlassmorphicContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                match.league,
                style: TextStyle(color: AppColors.textGrey, fontSize: 12),
              ),
              Icon(Icons.star_border, color: AppColors.textGrey, size: 20),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TeamDisplay(name: match.team1Name, logo: match.team1Logo),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        match.isLive
                            ? '${match.team1Score} - ${match.team2Score}'
                            : 'vs',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (match.isLive)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              match.matchTime,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      else
                        Text(
                          match.matchTime,
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              TeamDisplay(name: match.team2Name, logo: match.team2Logo),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Divider(color: Colors.white12, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OddsDisplay(label: '1', value: match.odds1),
              OddsDisplay(label: 'X', value: match.oddsX),
              OddsDisplay(label: '2', value: match.odds2),
            ],
          ),
        ],
      ),
    );
  }
}

class TeamDisplay extends StatelessWidget {
  final String name;
  final String logo;
  const TeamDisplay({super.key, required this.name, required this.logo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70, // Beri lebar tetap agar rapi
      child: Column(
        children: [
          Image.asset(logo, width: 45, height: 45),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class OddsDisplay extends StatelessWidget {
  final String label;
  final String value;
  const OddsDisplay({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label ',
          style: TextStyle(color: AppColors.textGrey, fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}
