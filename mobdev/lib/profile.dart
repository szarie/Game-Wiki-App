import 'package:flutter/material.dart';
import 'package:mobdev/nav.dart';
import 'package:mobdev/agent.dart';
import 'package:mobdev/fav_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class UserProfile {
  String name;
  String email;
  String bio;
  String avatarUrl;

  UserProfile({
    required this.name,
    required this.email,
    this.bio = '',
    this.avatarUrl = '',
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? 'New User',
      email: json['email'] ?? 'user@example.com',
      bio: json['bio'] ?? 'No bio yet.',
      avatarUrl: json['avatarUrl'] ?? 'assets/icons/default_avatar.png',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'bio': bio,
      'avatarUrl': avatarUrl,
    };
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile _userProfile = UserProfile(
    name: 'New User',
    email: 'user@example.com',
    bio: 'No bio yet.',
  );
  List<Agent> _favoriteAgents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileAndFavorites();
  }

  Future<void> _loadProfileAndFavorites() async {
    setState(() {
      _isLoading = true;
    });

    // Load user profile
    await _loadUserProfile();

    // Load favorite agents
    final favoriteIds = await FavoritesManager.getFavoriteIds();
    if (favoriteIds.isNotEmpty) {
      await _loadFavoriteAgents(favoriteIds);
    } else {
      setState(() {
        _favoriteAgents = [];
        _isLoading = false;
      });
    }
  }

  Future<void> _loadUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileJson = prefs.getString('user_profile');

      if (profileJson != null) {
        final profileMap = json.decode(profileJson);
        setState(() {
          _userProfile = UserProfile.fromJson(profileMap);
        });
      }
    } catch (e) {
      //print('Error loading profile: $e');
    }
  }

  Future<void> _saveUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileJson = json.encode(_userProfile.toJson());
      await prefs.setString('user_profile', profileJson);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Profile saved!'), duration: Duration(seconds: 2)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to save profile'),
            duration: Duration(seconds: 2)),
      );
    }
  }

  Future<void> _loadFavoriteAgents(List<String> favoriteIds) async {
    try {
      // Load the JSON file from the assets
      final String jsonData =
          await rootBundle.loadString('assets/json/agents.json');
      final Map<String, dynamic> data = jsonDecode(jsonData);

      // Get all agents
      final allAgents = List<Agent>.from(
          data['agents'].map((agent) => Agent.fromJson(agent)));

      // Filter only favorites
      setState(() {
        _favoriteAgents =
            allAgents.where((agent) => favoriteIds.contains(agent.id)).toList();
        _isLoading = false;
      });
    } catch (e) {
      //print('Error loading favorite agents: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        String name = _userProfile.name;
        String email = _userProfile.email;
        String bio = _userProfile.bio;
        String avatarUrl = _userProfile.avatarUrl;

        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar
                GestureDetector(
                  onTap: () async {
                    // Show avatar selection options
                    final selectedAvatar = await showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Select Avatar'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  for (int i = 1; i <= 6; i++)
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context,
                                          'assets/icons/avatar_$i.png'),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            'assets/icons/avatar_$i.png'),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    );

                    if (selectedAvatar != null) {
                      avatarUrl = selectedAvatar;
                    }
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(avatarUrl),
                        backgroundColor: Colors.grey[800],
                        child: avatarUrl == 'assets/icons/default_avatar.png'
                            ? Icon(Icons.person,
                                size: 40, color: Colors.white70)
                            : null,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: TextEditingController(text: name),
                  onChanged: (value) => name = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                  controller: TextEditingController(text: email),
                  onChanged: (value) => email = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: 'Bio'),
                  controller: TextEditingController(text: bio),
                  maxLines: 3,
                  onChanged: (value) => bio = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _userProfile.name = name;
                  _userProfile.email = email;
                  _userProfile.bio = bio;
                  _userProfile.avatarUrl = avatarUrl;
                });
                _saveUserProfile();
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 3,
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: const Color.fromARGB(255, 27, 26, 26),
              child: ListView(
                children: [
                  // Profile Header
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Avatar
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: AssetImage(_userProfile.avatarUrl),
                          onBackgroundImageError: (_, __) {},
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 15),

                        // User Name
                        Text(
                          _userProfile.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        // Email
                        Text(
                          _userProfile.email,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                          ),
                        ),
                        SizedBox(height: 10),

                        // Bio
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(75, 96, 96, 96),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _userProfile.bio,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

                        // Edit Profile Button
                        ElevatedButton.icon(
                          onPressed: _editProfile,
                          icon: Icon(Icons.edit),
                          label: Text('Edit Profile'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 100, 161, 64),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(color: Colors.grey[800]),

                  // Favorite Agents Section
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Favorite Agents',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Favorite Agents List
                  _favoriteAgents.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'No favorite agents yet',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          height: 160,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _favoriteAgents.length,
                            itemBuilder: (context, index) {
                              final agent = _favoriteAgents[index];
                              return _buildFavoriteAgentCard(agent);
                            },
                          ),
                        ),

                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _buildFavoriteAgentCard(Agent agent) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/agent_details', arguments: agent);
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 33, 33, 33),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Agent Image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(
                  agent.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF2A2A2A),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Agent Name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                agent.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
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
