import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> updateTodoCompletion(int id, bool completed) async {
  await Supabase.instance.client
      .from('todos')
      .update({'completed': completed})
      .eq('id', id)
      .execute();
}