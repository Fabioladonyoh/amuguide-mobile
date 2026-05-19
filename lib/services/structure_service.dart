import '../core/constants/app_config.dart';
import '../models/structure_sante.dart';
import 'api_service.dart';

class StructureService {

  final ApiService _apiService =
      ApiService();

  Future<List<StructureSante>>
      getStructures() async {

    final data = await _apiService.get(
      AppConfig.structures,
    );

    return (data as List)
        .map(
          (item) =>
              StructureSante.fromJson(item),
        )
        .toList();
  }
}