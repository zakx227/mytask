import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mytask/riverpod/riverpod_task.dart';

final taskRiverpod = ChangeNotifierProvider((ref) => RiverpodTask());
