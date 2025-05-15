import 'package:flutter/material.dart';
import 'package:mobdev/nav.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mobdev/agent.dart';

class AgentListPage extends StatefulWidget {
  const AgentListPage({super.key});
  @override
  State<AgentListPage> createState() => _AgentListPageState();
}

class _AgentListPageState extends State<AgentListPage> {
  List<Agent> agents = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadAgents();
  }

  Future<void> loadAgents() async {
    try {
      // Load the JSON file from the assets
      final String jsonData =
          await rootBundle.loadString('assets/json/agents.json');
      final Map<String, dynamic> data = jsonDecode(jsonData);

      setState(() {
        agents = List<Agent>.from(
            data['agents'].map((agent) => Agent.fromJson(agent)));
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 1,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: const Color.fromARGB(255, 27, 26, 26),
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: agents.length,
                itemBuilder: (context, index) {
                  final agent = agents[index];
                  return AgentCard(agent: agent);
                },
              ),
            ),
    );
  }
}

class AgentCard extends StatelessWidget {
  final Agent agent;

  const AgentCard({Key? key, required this.agent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/agent_details', arguments: agent);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 33, 33, 33),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    child: Image.asset(
                      agent.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback for placeholder images
                        return Container(
                          color: const Color(0xFF2A2A2A),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: RarityIcon(rarity: agent.rarity),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: AttributeIcon(attribute: agent.attribute),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFF252525),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
              child: Text(
                agent.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RarityIcon extends StatelessWidget {
  final String rarity;

  const RarityIcon({Key? key, required this.rarity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;

    switch (rarity) {
      case 'star':
        iconData = Icons.star;
        iconColor = Colors.amber;
        break;
      case 'lightning':
        iconData = Icons.flash_on;
        iconColor = Colors.yellow;
        break;
      case 'gear':
        iconData = Icons.settings;
        iconColor = Colors.white;
        break;
      case 'fire':
        iconData = Icons.local_fire_department;
        iconColor = Colors.orange;
        break;
      case 'spark':
        iconData = Icons.auto_awesome;
        iconColor = Colors.cyanAccent;
        break;
      default:
        iconData = Icons.star_border;
        iconColor = Colors.grey;
    }

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(153, 0, 0, 0),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(3),
      child: Icon(
        iconData,
        color: iconColor,
        size: 16,
      ),
    );
  }
}

class AttributeIcon extends StatelessWidget {
  final String attribute;

  const AttributeIcon({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;

    switch (attribute) {
      case 'fire':
        iconData = Icons.local_fire_department;
        iconColor = Colors.deepOrange;
        break;
      case 'ice':
        iconData = Icons.ac_unit;
        iconColor = Colors.lightBlueAccent;
        break;
      case 'frost':
        iconData = Icons.ac_unit;
        iconColor = Colors.lightBlueAccent;
        break;
      case 'lightning':
        iconData = Icons.flash_on;
        iconColor = Colors.yellowAccent;
        break;
      case 'dark':
        iconData = Icons.nights_stay;
        iconColor = Colors.purpleAccent;
        break;
      case 'neutral':
        iconData = Icons.shield;
        iconColor = Colors.grey;
        break;
      default:
        iconData = Icons.help_outline;
        iconColor = Colors.grey;
    }

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(
            153, 0, 0, 0), // 153 is 60% of 255, equivalent to 0.6 opacity
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(3),
      child: Icon(
        iconData,
        color: iconColor,
        size: 16,
      ),
    );
  }
}
