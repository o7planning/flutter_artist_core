part of '../../flutter_artist_core.dart';

enum ResponseDataMode {
  ///
  /// The expected data is wrapped inside.
  ///
  /// JSON Example 1:
  /// ```json
  ///  {
  ///     "result": "success",
  ///     "status": 200,
  ///     "errorMessage": null,
  ///     "errorDetails": null,
  ///     "data": {
  ///         "employeeId": 123,
  ///         "employeeName": "Tom"
  ///     }
  ///  }
  /// ```
  /// JSON Example 2:
  /// ```json
  ///  {
  ///     "result": "fail",
  ///     "status": 500,
  ///     "errorMessage": "Validation Error",
  ///     "errorDetails": ["EmployeeId required!", "Employee Name required!"],
  ///     "data": null
  ///  }
  ///  ```
  ///
  @Deprecated("No longer used")
  wrappedData,

  ///
  /// JSON Example 1:
  /// ```json
  ///  {
  //      "employeeId": 123,
  //      "employeeName": "Tom"
  //  }
  /// ```
  realData,
}
