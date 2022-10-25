library eth_abi_codec_test.uniswap_decode_tests;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:test/test.dart';
import 'package:eth_abi_codec/eth_abi_codec.dart';

void main() {
  var abi_file = File('./test_abi/UNISWAP.json');
  
  var abi = ContractABI.fromJson(
              jsonDecode(abi_file.readAsStringSync()));
  
  test('UNISWAP decode swapExactETHForTokens', () {
    var data = hex.decode('7ff36ab5000000000000000000000000000000000000000000000000006560c393c8e7e10000000000000000000000000000000000000000000000000000000000000080000000000000000000000000a964e7475f81733e800744b93950c0c1c9923902000000000000000000000000000000000000000000000000000000005f818e4c0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000d0a1e359811322d97991e03f863a0c30c2cf029c000000000000000000000000aaf64bfcc32d0f15873a02163e7e500671a4ffcd');
    var call = ContractCall.fromBinary(Uint8List.fromList(data), abi);
    expect(call.functionName, 'swapExactETHForTokens');
    expect(call.callParams.length, 4);
    expect(call.callParams['amountOutMin'], BigInt.from(28535365762082785));
    expect(call.callParams['path'][1], 'aaf64bfcc32d0f15873a02163e7e500671a4ffcd');
    expect(call.callParams['to'], 'a964e7475f81733e800744b93950c0c1c9923902');
    expect(call.callParams['deadline'], BigInt.from(1602326092));
  });

  test('UNISWAP decode swapExactTokensForETH', () {
    var data = hex.decode('18cbafe5000000000000000000000000000000000000000000000000002386f26fc10000000000000000000000000000000000000000000000000000000c40ee5fe649fb00000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000a964e7475f81733e800744b93950c0c1c9923902000000000000000000000000000000000000000000000000000000005f8193b00000000000000000000000000000000000000000000000000000000000000002000000000000000000000000aaf64bfcc32d0f15873a02163e7e500671a4ffcd000000000000000000000000d0a1e359811322d97991e03f863a0c30c2cf029c');
    var call = ContractCall.fromBinary(Uint8List.fromList(data), abi);
    expect(call.functionName, 'swapExactTokensForETH');
    expect(call.callParams.length, 5);
    expect(call.callParams['amountIn'], BigInt.from(10000000000000000));
    expect(call.callParams['amountOutMin'], BigInt.from(3449092275849723));
    expect(call.callParams['path'][0], 'aaf64bfcc32d0f15873a02163e7e500671a4ffcd');
    expect(call.callParams['to'], 'a964e7475f81733e800744b93950c0c1c9923902');
    expect(call.callParams['deadline'], BigInt.from(1602327472));
  });

}