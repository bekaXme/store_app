import 'package:store_app/core/result/result.dart';
import 'package:store_app/core/services/client.dart';
import 'package:store_app/data/models/payment/payment_model.dart';

class PaymentRepository {
  final ApiClient _client;

  PaymentRepository({required ApiClient client}) : _client = client;

  Future<Result<List<CardModel>>> getCards() async {
    final result = await _client.get<List<dynamic>>('/cards/list');
    return result.fold(
      onError: (e) {
        print('API Error in getCards: $e');
        return Result.error(e);
      },
      onSuccess: (data) {
        try {
          print('Raw JSON in getCards: $data');
          final cards = data.map((e) => CardModel.fromJson(e as Map<String, dynamic>)).toList();
          print('Parsed Cards: $cards');
          return Result.success(cards);
        } catch (e, stackTrace) {
          print('Parsing Error in getCards: $e\n$stackTrace');
          return Result.error(Exception('Failed to parse cards: $e'));
        }
      },
    );
  }

  Future<Result<CardModel>> postCard(CardModel card) async {
    final result = await _client.post<Map<String, dynamic>>(
      '/cards/create',
      data: card.toJson(),
    );
    return result.fold(
      onError: (e) {
        print('API Error in postCard: $e');
        return Result.error(e);
      },
      onSuccess: (data) {
        try {
          print('Raw JSON in postCard: $data');
          final card = CardModel.fromJson(data);
          print('Parsed Card: $card');
          return Result.success(card);
        } catch (e, stackTrace) {
          print('Parsing Error in postCard: $e\n$stackTrace');
          return Result.error(Exception('Failed to parse cards: $e'));
        }
      },
    );
  }

  Future<Result<void>> deleteCard(int id) async {
    final result = await _client.delete<void>('/cards/delete/$id');
    return result.fold(
      onError: (e) {
        print('API Error in deleteCard: $e');
        return Result.error(e);
      },
      onSuccess: (_) {
        print('deleteCard success');
        return Result.success(null);
      },
    );
  }
}