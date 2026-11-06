import 'dart:ui';

/// A formation preset. Positions are fractions of the pitch from the user's
/// own goal: x across (0 = left touchline), y up the pitch (0 = own goal line).
class FormationModel {
  const FormationModel({required this.name, required this.positions});

  final String name;
  final List<Offset> positions;

  int get playerCount => positions.length;

  static const List<FormationModel> fiveASide = [
    FormationModel(
      name: '1-2-1',
      positions: [
        Offset(0.5, 0.06),
        Offset(0.5, 0.3),
        Offset(0.2, 0.5),
        Offset(0.8, 0.5),
        Offset(0.5, 0.76),
      ],
    ),
    FormationModel(
      name: '2-2',
      positions: [
        Offset(0.5, 0.06),
        Offset(0.28, 0.32),
        Offset(0.72, 0.32),
        Offset(0.28, 0.7),
        Offset(0.72, 0.7),
      ],
    ),
  ];

  static const List<FormationModel> sevenASide = [
    FormationModel(
      name: '2-3-1',
      positions: [
        Offset(0.5, 0.06),
        Offset(0.3, 0.26),
        Offset(0.7, 0.26),
        Offset(0.18, 0.52),
        Offset(0.5, 0.5),
        Offset(0.82, 0.52),
        Offset(0.5, 0.8),
      ],
    ),
    FormationModel(
      name: '3-2-1',
      positions: [
        Offset(0.5, 0.06),
        Offset(0.2, 0.27),
        Offset(0.5, 0.25),
        Offset(0.8, 0.27),
        Offset(0.32, 0.54),
        Offset(0.68, 0.54),
        Offset(0.5, 0.8),
      ],
    ),
  ];

  static const List<FormationModel> elevenASide = [
    FormationModel(
      name: '4-3-3',
      positions: [
        Offset(0.5, 0.05),
        Offset(0.12, 0.25),
        Offset(0.37, 0.22),
        Offset(0.63, 0.22),
        Offset(0.88, 0.25),
        Offset(0.25, 0.48),
        Offset(0.5, 0.45),
        Offset(0.75, 0.48),
        Offset(0.18, 0.76),
        Offset(0.5, 0.8),
        Offset(0.82, 0.76),
      ],
    ),
    FormationModel(
      name: '4-2-3-1',
      positions: [
        Offset(0.5, 0.05),
        Offset(0.12, 0.24),
        Offset(0.37, 0.21),
        Offset(0.63, 0.21),
        Offset(0.88, 0.24),
        Offset(0.35, 0.4),
        Offset(0.65, 0.4),
        Offset(0.18, 0.6),
        Offset(0.5, 0.58),
        Offset(0.82, 0.6),
        Offset(0.5, 0.82),
      ],
    ),
  ];

  static List<FormationModel> forSize(int playersPerSide) =>
      switch (playersPerSide) {
        5 => fiveASide,
        7 => sevenASide,
        _ => elevenASide,
      };
}
