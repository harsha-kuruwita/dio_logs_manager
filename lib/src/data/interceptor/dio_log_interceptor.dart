import 'package:dio/dio.dart';
import 'package:dio_logs_manager/src/data/models/err_options.dart';
import 'package:dio_logs_manager/src/data/models/req_options.dart';
import 'package:dio_logs_manager/src/data/models/res_options.dart';

import '../logs_pool.dart';

class DioLogInterceptor implements Interceptor {
  late LogPoolManager logManage;
  DioLogInterceptor({
    maxLogCount = 50,
  }) {
    logManage = LogPoolManager.getInstance()!..maxCount = maxLogCount;
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    var errOptions = ErrOptions();
    errOptions.id = err.requestOptions.hashCode;
    errOptions.errorMsg = err.toString();
    //onResponse(err.response);
    logManage.onError(errOptions);
    if (err.response != null) saveResponse(err.response!);
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var reqOpt = ReqOptions();
    reqOpt.id = options.hashCode;
    reqOpt.url = options.uri.toString();
    reqOpt.method = options.method;
    reqOpt.contentType = options.contentType.toString();
    reqOpt.requestTime = DateTime.now();
    reqOpt.params = options.queryParameters;
    reqOpt.data = options.data;
    reqOpt.headers = options.headers;
    logManage.onRequest(reqOpt);
    return handler.next(options);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    saveResponse(response);
    return handler.next(response);
  }

  void saveResponse(Response response) {
    var resOpt = ResOptions();
    resOpt.id = response.requestOptions.hashCode;
    resOpt.responseTime = DateTime.now();
    resOpt.statusCode = response.statusCode ?? 0;
    resOpt.data = response.data;
    resOpt.headers = response.headers.map;
    logManage.onResponse(resOpt);
  }
}
