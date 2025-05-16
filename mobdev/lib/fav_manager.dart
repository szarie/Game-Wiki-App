import 'package:flutter/material.dart';
import 'package:mobdev/nav.dart';
import 'package:mobdev/agent.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager {
  static const String _favoritesKey = 'favorite_agents';

  //Get the list of favorite agent ID
  static Future<List<String>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final favorite = prefs.getStringList(_favoritesKey) ?? [];
    return favorite;
  }

  //check if agent is a favorite
  static Future<bool> isFavorite(String agentId) async {
    final favoriteIds = await getFavoriteIds();
    return favoriteIds.contains(agentId);
  }

  // favorite status
  static Future<bool> toggleFavorite(String agentId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorite = prefs.getStringList(_favoritesKey) ?? [];

    if (favorite.contains(agentId)) {
      favorite.remove(agentId);
      await prefs.setStringList(_favoritesKey, favorite);
      return false; // Removed from favorites
    } else {
      favorite.add(agentId);
      await prefs.setStringList(_favoritesKey, favorite);
      return true; // Added to favorites
    }
  }
}
