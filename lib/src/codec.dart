library eth_abi_codec.codec;

import 'dart:typed_data';
import 'package:convert/convert.dart';

bool isDynamicType(String typeName) {
  if(typeName == 'bytes' || typeName == 'string') {
    return true;
  }
  if(typeName.endsWith(']')) {
    return true;
  }
  if(typeName.endsWith(')')) {
    return true;
  }
  return false;
}

BigInt decodeUint256(Iterable b) {
  return BigInt.parse(hex.encode(b.take(32).toList()), radix: 16);
}

int decodeInt(Iterable b) {
  return decodeUint256(b).toInt();
}

Uint8List decodeBytes(Iterable b) {
  var length = decodeInt(b);
  return Uint8List.fromList(b.skip(32).take(length));
}

String decodeString(Iterable b) {
  var length = decodeInt(b);
  return String.fromCharCodes(b.skip(32).take(length));
}

String decodeAddress(Iterable b) {
  return hex.encode(b.take(32).skip(12).toList());
}

List<dynamic> decodeList(Iterable b, String type) {
  var length = decodeInt(b);
  return decodeFixedLengthList(b.skip(32), type, length);
}

List<dynamic> decodeFixedLengthList(Iterable b, String type, int length) {
  List<dynamic> result = new List();
  for(var i = 0; i < length; i++) {
    if(isDynamicType(type)) {
      var relocate = decodeInt(b.skip(i * 32));
      result.add(decodeType(type, b.skip(relocate)));
    } else {
      result.add(decodeType(type, b.skip(i * 32)));
    }
  }
  return result;
}

dynamic decodeType(String type, Iterable b) {
  switch (type) {
    case 'string':
      return decodeString(b);
    case 'address':
      return decodeAddress(b);
    default:
      break;
  }

  var reg = RegExp(r"^([a-z\d\[\]]{1,})\[([\d]*)\]$");
  var match = reg.firstMatch(type);
  if(match != null) {
    var baseType = match.group(1);
    var repeatCount = match.group(2);
    if(repeatCount == "") {
      return decodeList(b, baseType);
    } else {
      int repeat = int.parse(repeatCount);
      return decodeFixedLengthList(b, baseType, repeat);
    }
  }

  // support uint8, uint128, uint256 ...
  if(type.startsWith('uint')) {
    return decodeUint256(b);
  }

  if(type.startsWith('bytes')) {
    return decodeBytes(b);
  }

  if(type.startsWith('(') && type.endsWith(')')) {
    var subtypes = type.substring(1, type.length - 1).split(',');
    List<dynamic> result = new List();
    for(var i = 0; i < subtypes.length; i++) {
      if(isDynamicType(subtypes[i])) {
        var relocate = decodeInt(b.skip(i * 32));
        result.add(decodeType(subtypes[i], b.skip(relocate)));
      } else {
        result.add(decodeType(subtypes[i], b.skip(i * 32)));
      }
    }
    return result;
  }
}