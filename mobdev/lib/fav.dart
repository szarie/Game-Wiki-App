import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobdev/agent_list.dart';
import 'package:mobdev/nav.dart';
import 'package:mobdev/agent.dart';
import 'dart:convert';
import 'package:mobdev/fav_manager.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Agent> _favoriteAgents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      isLoading = true;
    });

    //get all fav IDs
    final favoriteids = await FavoritesManager.getFavoriteIds();

    //load all agents
    final String jsonData =
        await rootBundle.loadString('assets/json/agents.json');
    final Map<String, dynamic> data = jsonDecode(jsonData);
    final List<Agent> allAgents =
        List<Agent>.from(data['agents'].map((agent) => Agent.fromJson(agent)));

    // Filter only fav
    final List<Agent> favorites =
        allAgents.where((agent) => favoriteids.contains(agent.id)).toList();

    setState(() {
      _favoriteAgents = favorites;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 2,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadFavorites,
              child: _favoriteAgents.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 80,
                          color: Color.fromARGB(255, 215, 215, 215),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'No favorites yet',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 215, 215, 215),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Add agents to you favorite by clicking the heart icon',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )
                      ],
                    ))
                  : Container(
                      color: const Color.fromARGB(255, 25, 26, 27),
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: _favoriteAgents.length,
                        itemBuilder: (context, index) {
                          final agent = _favoriteAgents[index];
                          return AgentCard(
                              agent: agent,
                              onFavoriteToggle: () {
                                _loadFavorites();
                              });
                        },
                      ),
                    ),
            ),
    );
  }
}
