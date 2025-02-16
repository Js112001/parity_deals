import 'package:deals/core/network/base_network.dart';
import 'package:deals/modules/data/models/store_api_response_model.dart';
import 'package:deals/utils/strings.dart';

abstract class DealsServiceProvider {
  Future<StoreApiResponseModel?> getTopDeals({int page = 1});

  Future<StoreApiResponseModel?> getFeaturedDeals({int page = 1});

  Future<StoreApiResponseModel?> getPopularDeals({int page = 1});
}

class DealsServiceProviderImpl extends DealsServiceProvider {
  final BaseNetwork _baseNetwork;

  DealsServiceProviderImpl(this._baseNetwork);

  @override
  Future<StoreApiResponseModel?> getFeaturedDeals({int page = 1}) async {
    return _baseNetwork.get(
      baseUrl: StringConstants.baseUrl,
      endpoint: 'discussed',
      queryParameters: {
        "per_page": 10,
        "page": '$page',
        "fields":
            "id,created_at,created_at_in_millis,image_medium,comments_count,store{name}"
      },
    );
  }

  @override
  Future<StoreApiResponseModel?> getPopularDeals({int page = 1}) async {
    return _baseNetwork.get(
      baseUrl: StringConstants.baseUrl,
      endpoint: 'discussed',
      queryParameters: {
        "per_page": 10,
        "page": '$page',
        "fields":
            "id,created_at,created_at_in_millis,image_medium,comments_count,store{name}"
      },
    );
  }

  @override
  Future<StoreApiResponseModel?> getTopDeals({int page = 1}) async {
    return _baseNetwork.get(
      baseUrl: StringConstants.baseUrl,
      endpoint: 'new',
      queryParameters: {
        "per_page": 10,
        "page": '$page',
        "fields":
            "id,created_at,created_at_in_millis,image_medium,comments_count,store{name}"
      },
    );
  }
}
