library eth_abi_codec_test.erc20_encode_tests;

import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:test/test.dart';
import 'package:eth_abi_codec/eth_abi_codec.dart';

void main() {
  var abi_file = File('./test_abi/ERC20.json');
  
  var abi = ContractABI.fromJson(
              jsonDecode(abi_file.readAsStringSync()));

  test('ERC20 encode transfer', () {
    var call = ContractCall('transfer')
      .setCallParam('_to', 'c9d983203307abccd3e1b303a00ea0a19724fe2c')
      .setCallParam('_value', BigInt.from(13412000000));
    expect(
      hex.encode(call.toBinary(abi)),
      'a9059cbb000000000000000000000000c9d983203307abccd3e1b303a00ea0a19724fe2c000000000000000000000000000000000000000000000000000000031f6ae100');
  });

  test('ERC20 encode approve', () {
    var call = ContractCall('approve')
      .setCallParam('_spender', '7a250d5630b4cf539739df2c5dacb4c659f2488d')
      .setCallParam('_value', BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935'));
    expect(
      hex.encode(call.toBinary(abi)),
      '095ea7b30000000000000000000000007a250d5630b4cf539739df2c5dacb4c659f2488dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
  });
}