import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> deleteTodo(int id) async {
  await Supabase.instance.client
      .from('todos')
      .delete()
      .eq('id', id)
      .execute();
}

Future<void> deleteCompleted() async {
  await Supabase.instance.client
      .from('todos')
      .delete()
      .eq('completed', true)
      .execute();
}