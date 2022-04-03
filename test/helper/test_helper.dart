import 'package:balance_history/data/services/api/api_service.dart';
import 'package:balance_history/domain/repositories/history_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  HistoryRepository,
  ApiService,
])
void main() {}
