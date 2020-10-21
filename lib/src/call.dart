library eth_abi_codec.call;

import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:typed_data/typed_buffers.dart';

import 'abi.dart';
import 'codec.dart';

class CallParam {
  String paramName;
  dynamic paramValue;
  CallParam(this.paramName, this.paramValue);
  CallParam.fromJson(Map<String, dynamic> json):
    paramName = json['name'],
    paramValue = json['value'];

  Map<String, dynamic> toJson() => {
    'name': paramName,
    'value': paramValue is BigInt ? paramValue.toString() : paramValue
  };
}

class ContractCall {
  String functionName;
  List<CallParam> callParams;

  dynamic getCallParam(String paramName) =>
    callParams.firstWhere((p) => p.paramName == paramName, orElse: () => null)?.paramValue;

  /// fromJson takes a Map<String, dynamic> as input
  ///
  ///```json
  ///{
  /// "address": "contract address",
  /// "function": "function name",
  /// "params": [
  ///   {
  ///     "name": "param name",
  ///     "value": "param value"
  ///   }
  /// ]
  ///}
  ///```
  ContractCall.fromJson(Map<String, dynamic> json):
    functionName = json['function'],
    callParams = List<CallParam>.from(json['params'].map((i) => CallParam.fromJson(i)));

  Map<String, dynamic> toJson() =>
    {
      'function': functionName,
      'params': callParams
    };

  /// fromBinary takes "input data" field of ethereum contract call as input
  ContractCall.fromBinary(Uint8List data, ContractABI abi) {
    var buffer = new Uint8Buffer();
    buffer.addAll(data);

    var methodId = hex.encode(buffer.take(4).toList());
    var abiEntry = abi.getABIEntryByMethodId(methodId);
    if(abiEntry == null) {
      throw "Method id ${methodId} not found in abi, check whether input and abi matches";
    }
    functionName = abiEntry.name;

    var paramBuffer = buffer.skip(4);
    callParams = new List();
    var decoded = decodeType(abiEntry.paramDescription, paramBuffer);
    if((decoded as List).length != abiEntry.inputs.length) {
      throw "Decoded param count does not match function input count";
    }
    for(var i = 0; i < abiEntry.inputs.length; i++) {
      callParams.add(CallParam(abiEntry.inputs[i].name, decoded[i]));
    }
  }

  Uint8List toBinary(ContractABI abi) {
    var abiEntry = abi.getABIEntryByMethodName(functionName);
    var methodId = abiEntry.methodId;

    var encodec = encodeType(abiEntry.paramDescription, callParams);
  }
}