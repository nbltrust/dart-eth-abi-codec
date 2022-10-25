library eth_abi_codec_test.result_decode_test;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:test/test.dart';
import 'package:eth_abi_codec/eth_abi_codec.dart';

void main() {
  var abi_file = File('./test_abi/ERC20.json');
  
  var abi = ContractABI.fromJson(
              jsonDecode(abi_file.readAsStringSync()));
  
  test('ERC20 decode name result', () {
    var data = hex.decode('0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000a5465746865722055534400000000000000000000000000000000000000000000');
    var res = abi.decomposeResult('name', Uint8List.fromList(data));
    expect(res?[''], 'Tether USD');
  });
}