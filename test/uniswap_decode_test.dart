library eth_abi_codec_test.uniswap_decode_tests;

import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:test/test.dart';
import 'package:eth_abi_codec/eth_abi_codec.dart';

void main() {
  var abi_file = File('./test_abi/UNISWAP.json');
  
  var abi = ContractABI.fromJson(
              jsonDecode(abi_file.readAsStringSync()));
  
  test('UNISWAP decode swapExactETHForTokens', () {
    var data = hex.decode('7ff36ab5000000000000000000000000000000000000000000000000006560c393c8e7e10000000000000000000000000000000000000000000000000000000000000080000000000000000000000000a964e7475f81733e800744b93950c0c1c9923902000000000000000000000000000000000000000000000000000000005f818e4c0000000000000000000000000000000000000000000000000000000000000002000000000000000000000000d0a1e359811322d97991e03f863a0c30c2cf029c000000000000000000000000aaf64bfcc32d0f15873a02163e7e500671a4ffcd');
    var call = ContractCall.fromBinary(data, abi);
    expect(call.functionName, 'swapExactETHForTokens');
    expect(call.callParams.length, 4);
    expect(call.callParams[0].paramName, 'amountOutMin');
    expect(call.callParams[1].paramName, 'path');
    expect(call.callParams[2].paramName, 'to');
    expect(call.callParams[3].paramName, 'deadline');
    expect(call.callParams[0].paramValue.toInt(), 28535365762082785);
    expect(call.callParams[1].paramValue[1], 'aaf64bfcc32d0f15873a02163e7e500671a4ffcd');
    expect(call.callParams[2].paramValue, 'a964e7475f81733e800744b93950c0c1c9923902');
    expect(call.callParams[3].paramValue.toInt(), 1602326092);
  });

  test('UNISWAP decode swapExactTokensForETH', () {
    var data = hex.decode('18cbafe5000000000000000000000000000000000000000000000000002386f26fc10000000000000000000000000000000000000000000000000000000c40ee5fe649fb00000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000a964e7475f81733e800744b93950c0c1c9923902000000000000000000000000000000000000000000000000000000005f8193b00000000000000000000000000000000000000000000000000000000000000002000000000000000000000000aaf64bfcc32d0f15873a02163e7e500671a4ffcd000000000000000000000000d0a1e359811322d97991e03f863a0c30c2cf029c');
    var call = ContractCall.fromBinary(data, abi);
    expect(call.functionName, 'swapExactTokensForETH');
    expect(call.callParams.length, 5);
    expect(call.callParams[0].paramName, 'amountIn');
    expect(call.callParams[1].paramName, 'amountOutMin');
    expect(call.callParams[2].paramName, 'path');
    expect(call.callParams[3].paramName, 'to');
    expect(call.callParams[4].paramName, 'deadline');
    expect(call.callParams[0].paramValue.toInt(), 10000000000000000);
    expect(call.callParams[1].paramValue.toInt(), 3449092275849723);
    expect(call.callParams[2].paramValue[0], 'aaf64bfcc32d0f15873a02163e7e500671a4ffcd');
    expect(call.callParams[3].paramValue, 'a964e7475f81733e800744b93950c0c1c9923902');
    expect(call.callParams[4].paramValue.toInt(), 1602327472);
  });

}