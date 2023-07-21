import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'playlist_details.dart';
import 'playlists.dart';

// From https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw
const flutterDevAccountId = 'UCwXdFgeE9KYzlDdR7TG9cMw';

const youTubeApiKey = 'AIzaSyAKqlo6PKu6ljzt2hlVUc8fpZ99NQh2c8Y';

final _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const Playlists();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'playlist/:id',
          builder: (context, state) {
            final title = state.queryParameters['title']!;
            final id = state.pathParameters['id']!;
            return PlaylistDetails(
              playlistId: id,
              playlistName: title,
            );
          },
        ),
      ],
    ),
  ],
);

void main() {
  if (youTubeApiKey == 'AIzaNotAnApiKey') {
    // ignore: avoid_print
    print('youTubeApiKey has not been configured.');
    exit(1);
  }

  runApp(ChangeNotifierProvider<FlutterDevPlaylists>(
    create: (context) => FlutterDevPlaylists(
      flutterDevAccountId: flutterDevAccountId,
      youTubeApiKey: youTubeApiKey,
    ),
    child: const PlaylistsApp(),
  ));
}

class PlaylistsApp extends StatelessWidget {
  const PlaylistsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FlutterDev Playlists',
      theme: FlexColorScheme.light(
        scheme: FlexScheme.red,
        useMaterial3: true,
      ).toTheme,
      darkTheme: FlexColorScheme.dark(
        scheme: FlexScheme.red,
        useMaterial3: true,
      ).toTheme,
      themeMode: ThemeMode.dark, // Or ThemeMode.System if you'd prefer
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}