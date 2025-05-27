import 'package:flutter/material.dart';
import 'package:mobdev/fav_manager.dart';
import 'package:mobdev/nav.dart';
import 'package:mobdev/agent.dart';

class AgentDetailsPage extends StatefulWidget {
  final Agent agent;
  const AgentDetailsPage({required this.agent, super.key});
  @override
  State<AgentDetailsPage> createState() => _AgentDetailsPageState();
}

// class AgentCard extends StatelessWidget {
//   final Agent agent;
//   final Function? onFavoriteToggle;

//   const AgentCard({
//     key? key,
//     required this.agent,
//     this.onFavoriteToggle,
//   }) : super(key: key);
// }

class _AgentDetailsPageState extends State<AgentDetailsPage> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFav = await FavoritesManager.isFavorite(widget.agent.id);
    setState(() {
      _isFavorite = isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 1,
      title: '',
      actions: [
        IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () async {
              final isFav =
                  await FavoritesManager.toggleFavorite(widget.agent.id);
              setState(() {
                _isFavorite = isFav;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isFavorite
                      ? '${widget.agent.name} added to favorites'
                      : '${widget.agent.name} removed from favorites'),
                  duration: Duration(seconds: 1),
                ),
              );
              if (!isFav) {
                Navigator.of(context).pushReplacementNamed('/favorites');
              }
            })
      ],
      child: Container(
        color: const Color.fromARGB(255, 27, 26, 26),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                color: const Color.fromARGB(255, 33, 33, 33),
                child: Image.asset(
                  widget.agent.fullImage ?? widget.agent.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                        color: const Color.fromARGB(255, 82, 94, 94),
                        child: Center(
                            child: Icon(
                          Icons.error,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          size: 50,
                        )));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  color: const Color.fromARGB(255, 27, 26, 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.agent.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      // Display agent ID if needed
                      // Text(
                      //   'Agent ID: ${widget.agent.id}',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: const Color.fromARGB(255, 255, 255, 255),
                      //   ),
                      // ),
                      SizedBox(height: 20),
                      // Rarity and Attribute
                      // Row(
                      //   children: [
                      //     _buildAttributeChip('Rarity', widget.agent.rarity),
                      //     SizedBox(width: 10),
                      //     _buildAttributeChip(
                      //         'Attribute', widget.agent.attribute)
                      //   ],
                      // ),
                      // SizedBox(height: 5),
                      // Row(
                      //   children: [
                      //     _buildAttributeChip(
                      //         'Specialty', widget.agent.specialty),
                      //   ],
                      // ),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildAttributeChip('Rarity', widget.agent.rarity),
                          _buildAttributeChip(
                              'Attribute', widget.agent.attribute),
                          _buildAttributeChip(
                              'Specialty', widget.agent.specialty),
                        ],
                      ),
                      //description
                      SizedBox(height: 30),
                      if (widget.agent.details != null) ...[
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.agent.details!.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 30),
                        // Abilities
                        Text(
                          'abilities',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 15),
                        ...widget.agent.details!.abilities.map((ability) {
                          return _buildAbilityCard(ability);
                        }).toList(),
                        SizedBox(height: 30),
                        // Stats
                        Text(
                          'Stats',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 15),
                        _buildStatsTable(widget.agent.details!.stats),
                        SizedBox(height: 30),
                        // Backstory
                        Text(
                          'Backstory',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.agent.details!.backstory,
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ] else ...[
                        // display if no details available
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 100, 123, 123),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'Additional details for ${widget.agent.name} are not available.',
                              style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildAttributeChip(String label, String value) {
  Color chipColor = _getAttributeColor(value);
  String attributeIconPath = _getattributeIconPath(value);

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: chipColor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: chipColor.withOpacity(0.5), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          value == 'S' || value == 'A' ? '' : value,
          style: TextStyle(
            fontSize: 14,
            color: chipColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 18,
          height: 18,
          child: Image.asset(
            attributeIconPath,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: 16, color: chipColor);
            },
          ),
        )
      ],
    ),
  );
}

Widget _buildAbilityCard(Ability ability) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF2A2A2A),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ability.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (ability.energy > 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Energy: ${ability.energy}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.redAccent,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          ability.description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        if (ability.damage != null) ...[
          SizedBox(height: 6),
          Text(
            'Damage: ${ability.damage}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.orange[300],
            ),
          ),
        ],
        if (ability.effect != null) ...[
          SizedBox(height: 6),
          Text(
            'Effect: ${ability.effect}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.cyan[300],
            ),
          ),
        ],
      ],
    ),
  );
}

Widget _buildStatsTable(Stats stats) {
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Color(0xFF2A2A2A),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        _buildStatRow('HP', stats.hp),
        _buildStatRow('Attack', stats.attack),
        _buildStatRow('Defense', stats.defense),
        _buildStatRow('Speed', stats.speed),
        _buildStatRow('Crit Rate', stats.critRate, suffix: '%'),
        _buildStatRow('Crit Damage', stats.critDamage, suffix: '%'),
      ],
    ),
  );
}

Widget _buildStatRow(String label, int value, {String suffix = ''}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[300],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _normalizeStatValue(label, value),
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(_getStatColor(label)),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '$value$suffix',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

// Helper methods for coloring and normalization

Color _getAttributeColor(String value) {
  switch (value.toLowerCase()) {
    case 'fire':
      return Colors.deepOrange;
    case 'ice':
    case 'frost':
      return Colors.lightBlueAccent;
    case 'electric':
      return const Color.fromARGB(255, 61, 118, 252);
    case 'physical':
      return const Color.fromARGB(255, 232, 205, 41);
    case 'ether':
      return const Color.fromARGB(255, 138, 87, 214);

    case 's':
      return Color.fromARGB(255, 255, 191, 64);
    case 'a':
      return Color.fromARGB(255, 172, 36, 240);
    case 'anomaly':
      return Color.fromARGB(255, 255, 232, 195);
    case 'attack':
      return Color.fromARGB(255, 255, 232, 195);
    case 'defense':
      return Color.fromARGB(255, 255, 232, 195);
    case 'stun':
      return Color.fromARGB(255, 255, 232, 195);
    case 'support':
      return Color.fromARGB(255, 255, 232, 195);
    default:
      return Colors.grey;
  }
}

String _getattributeIconPath(String attribute) {
  switch (attribute.toLowerCase()) {
    case 'fire':
      return 'assets/attribute/fire.png';
    case 'ice':
      return 'assets/attribute/ice.png';
    case 'frost':
      return 'assets/attribute/frost.png';
    case 'electric':
      return 'assets/attribute/electric.png';
    case 'physical':
      return 'assets/attribute/physical.png';
    case 'ether':
      return 'assets/attribute/ether.png';
    case 's':
      return 'assets/icons/S.png';
    case 'a':
      return 'assets/icons/A.png';
    case 'anomaly':
      return 'assets/specialty/anomaly.png';
    case 'attack':
      return 'assets/specialty/attack.png';
    case 'defense':
      return 'assets/specialty/defense.png';
    case 'stun':
      return 'assets/specialty/stun.png';
    case 'support':
      return 'assets/specialty/support.png';
    default:
      return 'assets/attribute/unknown.png';
  }
}

Color _getStatColor(String stat) {
  switch (stat) {
    case 'HP':
      return Colors.greenAccent;
    case 'Attack':
      return Colors.redAccent;
    case 'Defense':
      return Colors.blueAccent;
    case 'Speed':
      return Colors.purpleAccent;
    case 'Crit Rate':
    case 'Crit Damage':
      return Colors.orangeAccent;
    default:
      return Colors.grey;
  }
}

double _normalizeStatValue(String stat, int value) {
  switch (stat) {
    case 'HP':
      return value / 2000; // Assuming max HP is around 2000
    case 'Attack':
      return value / 100; // Assuming max Attack is around 100
    case 'Defense':
      return value / 100; // Assuming max Defense is around 100
    case 'Speed':
      return value / 100; // Assuming max Speed is around 100
    case 'Crit Rate':
      return value / 100; // Crit Rate is already a percentage
    case 'Crit Damage':
      return value / 200; // Assuming max Crit Damage is 200%
    default:
      return value / 100;
  }
}
