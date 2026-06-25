part of '../../flutter_artist_core.dart';

///
/// SUCCESS DATA:
/// ```json
/// {
///    "email": "tom@example.com",
///    "userName": "tom"
/// }
/// ```
/// ERROR CASE 1:
/// ```json
/// {
///    "timestamp": "2025-01-26T05:34:11.649+00:00",
///    "status": 500,
///    "error": "Internal Server Error",
///    "path": "/rest/appUserInfoPage"
// }
/// ```
/// ERROR CASE 2:
/// ```json
/// {
///   "status" : "INTERNAL_SERVER_ERROR",
///   "errorMessage" : "Some Message",
///   "errorDetails" : [ "Cause 1", "Cause 2" ]
/// }
/// ```
///
/// An enterprise-grade transactional wrapper encapsulating remote network responses,
/// operational metadata descriptors, and standardized structural error boundaries.
class ApiResult<D> {
  /// The strongly-typed concrete data payload components.
  final D? data;

  /// The raw HTTP status code received from the remote gateway layer.
  final int? statusCode;

  /// The descriptive status or verification text dispatched by the backend.
  final String? statusMessage;

  /// The flattened error data payload context if the network invocation failed.
  final ApiError? error;

  /// Creates a successful [ApiResult] transaction lifecycle sequence context.
  ApiResult.success({this.data, this.statusCode, this.statusMessage})
    : assert(
        statusCode == null ||
            statusCode == 304 ||
            (statusCode >= 200 && statusCode < 300),
      ),
      error = null;

  /// Creates a faulty [ApiResult] runtime payload contextual exception instance.
  ApiResult.error({
    this.statusCode,
    this.statusMessage,
    ApiErrorType? errorType,
    required String errorMessage,
    List<String>? errorDetails,
    String? originErrorText,
  }) : error = ApiError(
         statusCode: statusCode,
         statusMessage: statusMessage,
         errorType: errorType,
         errorMessage: errorMessage,
         errorDetails: errorDetails,
         originErrorText: originErrorText,
       ),
       data = null;

  /// Directly replicates a pre-existing structural [ApiError] matrix mapping.
  ApiResult.fromError(ApiError this.error)
    : statusCode = error.statusCode,
      statusMessage = error.statusMessage,
      data = null;

  /// Returns `true` if the current network transaction encountered a failure constraint.
  bool isError() {
    return error != null;
  }

  /// Immediately terminates execution and re-throws the underlying [ApiError]
  /// context if this instance represents a faulty response lifecycle state.
  void throwIfError() {
    if (isError()) {
      throw error!;
    }
  }

  /// Terminates execution if this instance contains an error condition,
  /// or forcefully throws a customized [ApiError] if the successful [data] payload is null.
  ///
  /// Parameters:
  /// * [nullDataMessage] The precise validation message text bound to the empty payload error layout.
  void throwIfErrorOrDataNull({required String nullDataMessage}) {
    if (isError()) {
      throw error!;
    } else if (data == null) {
      throw ApiError(
        statusCode: statusCode,
        statusMessage: statusMessage,
        errorMessage: nullDataMessage,
        errorDetails: null,
      );
    }
  }

  /// Transforms a single entity response envelope into a structured pagination [PageData] results wrapper.
  ///
  /// If the current data layer is null, it gracefully defaults to an empty pagination scheme.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<EmployeeInfo> singleResult = ApiResult.success(data: employee);
  /// ApiResult<PageData<EmployeeInfo>> pageResult = singleResult.toPageDataResult();
  /// ```
  ApiResult<PageData<D>> toPageDataResult() {
    PageData<D> pageData =
        data == null ? PageData.empty() : PageData.ofItem(data as D);
    return error == null
        ? ApiResult<PageData<D>>.success(
          data: pageData,
          statusCode: statusCode,
          statusMessage: statusMessage,
        )
        : ApiResult<PageData<D>>.fromError(error!);
  }

  /// Transforms a single entity response envelope into a flat list [ListData] container results wrapper.
  ///
  /// If the current data layer is null, it gracefully defaults to an empty array scheme.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<AlbumInfo> singleResult = ApiResult.success(data: album);
  /// ApiResult<ListData<AlbumInfo>> listResult = singleResult.toListDataResult();
  /// ```
  ApiResult<ListData<D>> toListDataResult() {
    ListData<D> listData =
        data == null ? ListData.empty() : ListData.ofItem(data as D);
    return error == null
        ? ApiResult<ListData<D>>.success(
          data: listData,
          statusCode: statusCode,
          statusMessage: statusMessage,
        )
        : ApiResult<ListData<D>>.fromError(error!);
  }

  /// Purges successful payloads and forces a safe null data casting
  /// alignment while securely transmitting background [error] metrics.
  ApiResult<R> toNullDataResult<R>() {
    return error == null
        ? ApiResult<R>.success(
          statusCode: statusCode,
          statusMessage: statusMessage,
          data: null,
        )
        : ApiResult<R>.fromError(error!);
  }

  /// Transforms any typed data state into a clean functional [ApiResult<void>] format layout.
  ApiResult<void> toVoidResult() {
    return error == null
        ? ApiResult<void>.success(
          statusCode: statusCode,
          statusMessage: statusMessage,
          data: null,
        )
        : ApiResult<void>.fromError(error!);
  }

  /// Map-transforms the underlying data model layout via a structural [converter] functional pass.
  ///
  /// Automatically short-circuits and preserves existing error boundaries.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<UserRawDto> rawResult = fetchRawUser();
  /// ApiResult<UserDomainModel> domainResult = rawResult.convert(
  ///   converter: (dto) => UserDomainModel.fromDto(dto),
  /// );
  /// ```
  ApiResult<F> convert<F>({required F Function(D data) converter}) {
    F? fData = data == null ? null : converter(data as D);
    return error == null
        ? ApiResult<F>.success(
          statusCode: statusCode,
          statusMessage: statusMessage,
          data: fData,
        )
        : ApiResult<F>.fromError(error!);
  }

  /// Adapts flat un-paginated list containers wrapped inside an [ApiResult]
  /// into a structured paginated [PageData] specification interface.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<ListData<SystemLogInfo>> listResult = fetchLogs();
  /// ApiResult<PageData<SystemLogInfo>> pageResult =
  ///     ApiResult.createPageDataResultFromListDataResult(listResult);
  /// ```
  static ApiResult<PageData<ITEM>> createPageDataResultFromListDataResult<ITEM>(
    ApiResult<ListData<ITEM>> listResult,
  ) {
    if (listResult.error != null) {
      return ApiResult<PageData<ITEM>>.fromError(listResult.error!);
    }
    return ApiResult<PageData<ITEM>>.success(
      statusCode: listResult.statusCode,
      statusMessage: listResult.statusMessage,
      data: listResult.data?.toPageData(),
    );
  }

  /// Adapts structural paginated data wrappers into a clean un-paginated [ListData] collection layout.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<PageData<CurrencyInfo>> pageResult = searchCurrencies();
  /// ApiResult<ListData<CurrencyInfo>> listResult =
  ///     ApiResult.createListDataResultFromPageDataResult(pageResult);
  /// ```
  static ApiResult<ListData<ITEM>> createListDataResultFromPageDataResult<ITEM>(
    ApiResult<PageData<ITEM>> pageResult,
  ) {
    if (pageResult.error != null) {
      return ApiResult<ListData<ITEM>>.fromError(pageResult.error!);
    }
    return ApiResult<ListData<ITEM>>.success(
      statusCode: pageResult.statusCode,
      statusMessage: pageResult.statusMessage,
      data: pageResult.data?.toListData(),
    );
  }

  /// Extracts a successful [ApiResult<ListData<ITEM>>] collection, filters its internal
  /// dataset elements using a customized predictive [test] callback, and yields a new
  /// structural [ApiResult<ListData<ITEM>>] wrapper tracking the matches.
  ///
  /// Operational network error matrices and gateway failure status codes are automatically
  /// short-circuited and propagated down the execution stream pipeline.
  ///
  /// ### Example (Inside a localized search or subset computation block):
  /// ```dart
  /// ApiResult<ListData<ProductInfo>> backendResult = await fetchAllProducts();
  ///
  /// // Filters out out-of-stock items dynamically before passing to the UI layer
  /// ApiResult<ListData<ProductInfo>> availableProductsResult =
  ///     ApiResult.createFilteredListDataResult<ProductInfo>(
  ///       backendResult,
  ///       (product) => product.stockCount > 0,
  ///     );
  /// ```
  static ApiResult<ListData<ITEM>> createFilteredListDataResult<ITEM>(
    ApiResult<ListData<ITEM>> listResult,
    bool Function(ITEM item) test,
  ) {
    if (listResult.error != null) {
      return ApiResult<ListData<ITEM>>.fromError(listResult.error!);
    }

    final ListData<ITEM>? currentData = listResult.data;
    final ListData<ITEM> filteredData =
        currentData == null ? ListData<ITEM>.empty() : currentData.where(test);

    return ApiResult<ListData<ITEM>>.success(
      statusCode: listResult.statusCode,
      statusMessage: listResult.statusMessage,
      data: filteredData,
    );
  }

  /// Transmutes a paginated [ApiResult<PageData<ITEM>>] dataset into a flat, un-paginated
  /// [ApiResult<ListData<ITEM>>] container while concurrently applying a predictive [test] filter.
  ///
  /// Operational network error boundaries and gateway failure responses are immediately
  /// short-circuited and propagated down the stream lifecycle execution pass.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<PageData<ProductInfo>> paginatedResult = await searchProducts(page: 1);
  ///
  /// // Transmutes the current page products into a flat ListData while filtering active items only
  /// ApiResult<ListData<ProductInfo>> filteredFlatResult =
  ///     ApiResult.createFilteredListDataResultFromPageDataResult<ProductInfo>(
  ///       paginatedResult,
  ///       (product) => product.isActive == true,
  ///     );
  /// ```
  static ApiResult<ListData<ITEM>>
  createFilteredListDataResultFromPageDataResult<ITEM>(
    ApiResult<PageData<ITEM>> pageResult,
    bool Function(ITEM item) test,
  ) {
    // 1. Short-circuit and propagate errors immediately if the network invocation failed
    if (pageResult.error != null) {
      return ApiResult<ListData<ITEM>>.fromError(pageResult.error!);
    }

    // 2. Safely extract items from the underlying paginated dataset structure
    final PageData<ITEM>? currentPageData = pageResult.data;
    final List<ITEM> currentItems = currentPageData?.items ?? const [];

    // 3. Apply the custom conditional logic filtering directly onto the extracted array
    final List<ITEM> filteredItems = currentItems.where(test).toList();
    final ListData<ITEM> compiledListData = ListData<ITEM>(
      items: filteredItems,
    );

    // 4. Yield a clean consolidated ListData response envelope tracking original metadata
    return ApiResult<ListData<ITEM>>.success(
      statusCode: pageResult.statusCode,
      statusMessage: pageResult.statusMessage,
      data: compiledListData,
    );
  }

  /// Synthesizes and translates a standard [ApiResult<void>] operational lifecycle pass
  /// into a highly optimized, flat [ListData] array tailored for bulk mutation workflows.
  ///
  /// Passing a sequence via [items] populates the effective identifier tracking matrix on success.
  ///
  /// ### Example (Inside a destructive or bulk creation [BlockBackendAction]):
  /// ```dart
  /// @override
  /// Future<ApiResult<ListData<int>?>> performBackendOperation({...}) async {
  ///   ApiResult<void> deleteResult = await _restProvider.delete(contributor.id);
  ///
  ///   return ApiResult.createListDataResultFromVoidResult<int>(
  ///     deleteResult,
  ///     items: [contributor.id], // Passes the deleted ID as an effective sync target
  ///   );
  /// }
  /// ```
  static ApiResult<ListData<ITEM>?> createListDataResultFromVoidResult<ITEM>(
    ApiResult<void> voidResult, {
    List<ITEM>? items,
  }) {
    if (voidResult.isError()) {
      return ApiResult<ListData<ITEM>?>.fromError(voidResult.error!);
    }
    return ApiResult<ListData<ITEM>?>.success(
      statusCode: voidResult.statusCode,
      statusMessage: voidResult.statusMessage,
      data: items == null ? null : ListData<ITEM>(items: items),
    );
  }

  /// Transmutes a structural empty [ApiResult<void>] lifecycle completion boundary
  /// into a customized concrete target data type [R] using a dynamic functional supplier.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<void> executionResult = clearCacheAction();
  /// ApiResult<String> stringResult = ApiResult.createFromVoidResult<String>(
  ///   executionResult,
  ///   onSuccessData: () => "Cache Cleared Successfully!",
  /// );
  /// ```
  static ApiResult<R> createFromVoidResult<R>(
    ApiResult<void> voidResult, {
    required R? Function() onSuccessData,
  }) {
    if (voidResult.isError()) {
      return ApiResult<R>.fromError(voidResult.error!);
    }
    return ApiResult<R>.success(
      statusCode: voidResult.statusCode,
      statusMessage: voidResult.statusMessage,
      data: onSuccessData(),
    );
  }

  /// Transmutes the underlying collection items of an [ApiResult<ListData<X>>] into a new
  /// structural [ApiResult<ListData<Y>>] layout using an element-by-element mapping pass.
  ///
  /// Automatically short-circuits and propagates existing operational error matrices.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<ListData<UserDto>> dtoResult = fetchUsers();
  ///
  /// ApiResult<ListData<UserModel>> modelResult = ApiResult.createMappedListDataResult<UserDto, UserModel>(
  ///   dtoResult,
  ///   itemConverter: (dto) => UserModel.fromDto(dto),
  /// );
  /// ```
  static ApiResult<ListData<Y>> createMappedListDataResult<X, Y>(
    ApiResult<ListData<X>> sourceResult, {
    required Y Function(X item) itemConverter,
  }) {
    if (sourceResult.isError()) {
      return ApiResult<ListData<Y>>.fromError(sourceResult.error!);
    }

    final List<X> sourceItems = sourceResult.data?.items ?? [];
    final List<Y> mappedItems = sourceItems.map(itemConverter).toList();

    return ApiResult<ListData<Y>>.success(
      statusCode: sourceResult.statusCode,
      statusMessage: sourceResult.statusMessage,
      data: ListData<Y>(items: mappedItems),
    );
  }

  /// Transmutes the underlying paginated dataset items of an [ApiResult<PageData<X>>] into a new
  /// structural [ApiResult<PageData<Y>>] layout while strictly preserving ambient pagination metrics.
  ///
  /// Automatically short-circuits and propagates existing operational error matrices.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<PageData<ProductDto>> dtoPageResult = searchProducts();
  ///
  /// ApiResult<PageData<ProductViewModel>> viewPageResult = ApiResult.createMappedPageDataResult<ProductDto, ProductViewModel>(
  ///   dtoPageResult,
  ///   itemConverter: (dto) => ProductViewModel.fromDto(dto),
  /// );
  /// ```
  static ApiResult<PageData<Y>> createMappedPageDataResult<X, Y>(
    ApiResult<PageData<X>> sourceResult, {
    required Y Function(X item) itemConverter,
  }) {
    if (sourceResult.isError()) {
      return ApiResult<PageData<Y>>.fromError(sourceResult.error!);
    }

    final PageData<X>? sourcePageData = sourceResult.data;
    if (sourcePageData == null) {
      return ApiResult<PageData<Y>>.success(
        statusCode: sourceResult.statusCode,
        statusMessage: sourceResult.statusMessage,
        data: PageData<Y>.empty(),
      );
    }

    final List<X> sourceItems = sourcePageData.items;
    final List<Y> mappedItems = sourceItems.map(itemConverter).toList();

    return ApiResult<PageData<Y>>.success(
      statusCode: sourceResult.statusCode,
      statusMessage: sourceResult.statusMessage,
      data: PageData<Y>(
        items: mappedItems,
        paginationInfo: sourcePageData.paginationInfo,
      ),
    );
  }

  /// Transmutes any generic [ApiResult<X>] entity envelope into a flat collection
  /// [ApiResult<ListData<Y>>] layout using an element-by-element mapping filter.
  ///
  /// This method adapts raw single dynamic payloads, composite objects, or custom DTOs
  /// directly into enterprise-grade collection layers while strictly short-circuiting
  /// and propagating network error matrices down the pipeline stream.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<UserClusterDto> rawResult = fetchClusterData();
  ///
  /// ApiResult<ListData<UserModel>> listResult =
  ///     ApiResult.createMappedListDataResultFromGenericResult<UserClusterDto, UserModel>(
  ///       rawResult,
  ///       itemConverter: (cluster) => UserModel.fromCluster(cluster),
  ///     );
  /// ```
  static ApiResult<ListData<Y>> createMappedListDataResultFromGenericResult<
    X,
    Y
  >(ApiResult<X> sourceResult, {required Y Function(X item) itemConverter}) {
    // 1. Short-circuit and propagate underlying remote network exceptions immediately
    if (sourceResult.isError()) {
      return ApiResult<ListData<Y>>.fromError(sourceResult.error!);
    }

    // 2. Extract the concrete domain payload components safely
    final X? sourceData = sourceResult.data;

    // 3. Fallback gracefully onto an empty schema structure if the source payload is missing
    if (sourceData == null) {
      return ApiResult<ListData<Y>>.success(
        statusCode: sourceResult.statusCode,
        statusMessage: sourceResult.statusMessage,
        data: ListData<Y>.empty(),
      );
    }

    // 4. Transform the single generic target into a structured collection boundary layout
    final Y mappedItem = itemConverter(sourceData);
    final ListData<Y> compiledListData = ListData<Y>.ofItem(mappedItem);

    // 5. Yield a consolidated ListData envelope tracking original HTTP transactional metadata
    return ApiResult<ListData<Y>>.success(
      statusCode: sourceResult.statusCode,
      statusMessage: sourceResult.statusMessage,
      data: compiledListData,
    );
  }

  /// Transmutes any generic [ApiResult<X>] envelope into an empty flat collection
  /// [ApiResult<ListData<Y>>] layout containing exactly 0 elements.
  ///
  /// This method is highly optimized for operational bypasses, fallback routines,
  /// or silent interceptors where successful validation requires wiping active
  /// grid layouts without propagating error conditions down the pipeline.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<UserClusterDto> rawResult = fetchClusterData();
  ///
  /// // Safely swallows data mapping and defaults to an empty 0-item ListData result wrapper
  /// ApiResult<ListData<UserModel>> emptyResult =
  ///     ApiResult.createEmptyListDataResultFromGenericResult<UserClusterDto, UserModel>(rawResult);
  /// ```
  static ApiResult<ListData<Y>>
  createEmptyListDataResultFromGenericResult<X, Y>(ApiResult<X> sourceResult) {
    // 1. Short-circuit and propagate underlying remote network exceptions immediately
    if (sourceResult.isError()) {
      return ApiResult<ListData<Y>>.fromError(sourceResult.error!);
    }

    // 2. Synthesize a pristine, immutable empty list container with 0 elements
    final ListData<Y> emptyListData = ListData<Y>.empty();

    // 3. Yield a consolidated ListData envelope tracking original HTTP transactional metadata
    return ApiResult<ListData<Y>>.success(
      statusCode: sourceResult.statusCode,
      statusMessage: sourceResult.statusMessage,
      data: emptyListData,
    );
  }

  /// Transmutes a paginated [ApiResult<PageData<X>>] dataset into a flat, un-paginated
  /// [ApiResult<ListData<Y>>] collection wrapper while concurrently applying an
  /// element-by-element mapping transfer pass.
  ///
  /// Operational network error boundaries and gateway failure responses are immediately
  /// short-circuited and propagated down the stream lifecycle execution pass.
  ///
  /// ### Example:
  /// ```dart
  /// ApiResult<PageData<ProductDto>> paginatedDtoResult = await searchProducts(page: 1);
  ///
  /// // Transmutes the current page products into a flat mapped ListData domain model format
  /// ApiResult<ListData<ProductViewModel>> flatViewModelResult =
  ///     ApiResult.createMappedListDataResultFromPageDataResult<ProductDto, ProductViewModel>(
  ///       paginatedDtoResult,
  ///       itemConverter: (dto) => ProductViewModel.fromDto(dto),
  ///     );
  /// ```
  static ApiResult<ListData<Y>>
  createMappedListDataResultFromPageDataResult<X, Y>(
    ApiResult<PageData<X>> pageResult, {
    required Y Function(X item) itemConverter,
  }) {
    // 1. Short-circuit and propagate errors immediately if the network invocation failed
    if (pageResult.isError()) {
      return ApiResult<ListData<Y>>.fromError(pageResult.error!);
    }

    // 2. Safely extract items from the underlying paginated dataset structure
    final PageData<X>? currentPageData = pageResult.data;

    // 3. Fallback gracefully onto an empty schema structure if the source payload is missing
    if (currentPageData == null) {
      return ApiResult<ListData<Y>>.success(
        statusCode: pageResult.statusCode,
        statusMessage: pageResult.statusMessage,
        data: ListData<Y>.empty(),
      );
    }

    // 4. Apply the custom item converter mapping pass directly onto the extracted array
    final List<X> currentItems = currentPageData.items;
    final List<Y> mappedItems = currentItems.map(itemConverter).toList();
    final ListData<Y> compiledListData = ListData<Y>(items: mappedItems);

    // 5. Yield a clean consolidated ListData response envelope tracking original metadata
    return ApiResult<ListData<Y>>.success(
      statusCode: pageResult.statusCode,
      statusMessage: pageResult.statusMessage,
      data: compiledListData,
    );
  }
}
