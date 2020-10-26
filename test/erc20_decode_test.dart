library eth_abi_codec_test.erc20_decode_tests;

import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:test/test.dart';
import 'package:eth_abi_codec/eth_abi_codec.dart';

void main() {
  var abi_file = File('./test_abi/ERC20.json');
  
  var abi = ContractABI.fromJson(
              jsonDecode(abi_file.readAsStringSync()));
  
  test('ERC20 decode transfer', () {
    var data = hex.decode('a9059cbb000000000000000000000000c9d983203307abccd3e1b303a00ea0a19724fe2c000000000000000000000000000000000000000000000000000000031f6ae100');
    var call = abi.decomposeCall(data);
    expect(call.functionName, 'transfer');
    expect(call.callParams.length, 2);
    expect(call.callParams['_to'], 'c9d983203307abccd3e1b303a00ea0a19724fe2c');
    expect(call.callParams['_value'], BigInt.from(13412000000));
    expect(call.getCallParam('_to'), 'c9d983203307abccd3e1b303a00ea0a19724fe2c');
  });

  test('ERC20 decode approve', () {
    var data = hex.decode('095ea7b30000000000000000000000007a250d5630b4cf539739df2c5dacb4c659f2488dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
    var call = ContractCall.fromBinary(data, abi);

    expect(call.functionName, 'approve');
    expect(call.callParams.length, 2);
    expect(call.getCallParam('_to'), null);
  });
}