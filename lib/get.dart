import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Map<String, dynamic>>> fetchTodos() async {
  final response = await Supabase.instance.client
      .from('todos')
      .select()
      .execute();
  if (response.error != null) {
    print('Error al obtener tareas: ${response.error!.message}');
    return [];
  }
  return List<Map<String, dynamic>>.from(response.data);
}