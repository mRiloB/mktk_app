import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  Future<void> init() async {
    await Supabase.initialize(
      url: 'https://mwttuqkrjvwyloykbomd.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im13dHR1cWtyanZ3eWxveWtib21kIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODk5MTA1MzYsImV4cCI6MjAwNTQ4NjUzNn0.adq7BbBKuFWxEjDavMtYKGR7Y1NuqNGN_qP8JOs9Mjc',
    );
  }
}
