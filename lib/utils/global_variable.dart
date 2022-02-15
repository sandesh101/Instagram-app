import 'package:flutter/material.dart';
import 'package:instagram_app/screens/add_post_screen.dart';
import 'package:instagram_app/screens/feed_screen.dart';
import 'package:instagram_app/screens/search_screen.dart';

const webScreen = 600;

const homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPost(),
  Text('Nofi'),
  Text('Profile'),
];
