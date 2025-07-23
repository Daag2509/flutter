import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> addTodo(String task) async {
  final response = await Supabase.instance.client
      .from('todos')
      .insert({'task': task, 'completed': false})
      .execute();
  if (response.error != null) {
    print('Error al agregar tarea: ${response.error!.message}');
  }
}