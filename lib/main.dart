import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miniprojet/screens/auth/signin_screen.dart';
import 'package:miniprojet/screens/edit_note_screen.dart';
import 'package:provider/provider.dart';
import 'providers/note_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_note_screen.dart';
import 'screens/note_detail_screen.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp.router(
        title: 'Notes App',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 48, 56, 46),
          hintColor: Color.fromARGB(255, 231, 218, 218),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 165, 123, 120),
            titleTextStyle: TextStyle(color: Colors.white),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color.fromARGB(255, 48, 56, 46),
            foregroundColor: Color.fromARGB(255, 247, 243, 243),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Color.fromARGB(255, 6, 9, 3)),
            bodyMedium: TextStyle(color: Color.fromARGB(255, 20, 22, 18)),
            displayLarge: TextStyle(color: Color.fromARGB(255, 31, 34, 28)),
          ),
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 48, 56, 46),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/add-note',
        builder: (context, state) => AddNoteScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/view-note/:noteId',
        builder: (context, state) {
          final noteId = state.pathParameters['noteId']!;
          return NoteDetailScreen(noteId: noteId);
        },
      ),
      GoRoute(
        path: '/edit-note/:noteId',
        builder: (context, state) {
          final noteId = state.pathParameters['noteId']!;
          final note = context.read<NoteProvider>().getNoteById(noteId);
          if (note == null) {
            return const Scaffold(
              body: Center(child: Text('Note not found')),
            );
          }
          return EditNoteScreen(note: note);
        },
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
    ],
  );
}
