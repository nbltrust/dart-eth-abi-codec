library eth_abi_codec_test.encode_tests;

import 'package:test/test.dart';
import 'package:convert/convert.dart';
import 'package:eth_abi_codec/eth_abi_codec.dart';

import 'dart:typed_data';

String runEncode(String type, dynamic input) {
  var l = encodeType(type, input);
  return hex.encode(l);
}

void main() {
  test('uint256 test', () {
    var r1 = runEncode('uint256', 1);
    expect(r1, '0000000000000000000000000000000000000000000000000000000000000001');

    var r2 = runEncode('uint256', 5);
    expect(r2, '0000000000000000000000000000000000000000000000000000000000000005');
  
    var r3 = runEncode('uint256', '5');
    expect(r3, '0000000000000000000000000000000000000000000000000000000000000005');
  });

  test('int256 test', () {
    var r1 = runEncode('int256', 1);
    expect(r1, '0000000000000000000000000000000000000000000000000000000000000001');

    var r2 = runEncode('int256', 5);
    expect(r2, '0000000000000000000000000000000000000000000000000000000000000005');

    var r3 = runEncode('int256', '5');
    expect(r3, '0000000000000000000000000000000000000000000000000000000000000005');
  });

  test('bool test', () {
    var r1 = runEncode('bool', true);
    expect(r1, '0000000000000000000000000000000000000000000000000000000000000001');

    var r2 = runEncode('bool', false);
    expect(r2, '0000000000000000000000000000000000000000000000000000000000000000');
  });

  test('string test', () {
    var r1 = runEncode('string', 'one');
    expect(r1, 
      '0000000000000000000000000000000000000000000000000000000000000003' + 
      '6f6e650000000000000000000000000000000000000000000000000000000000'
    );

    var r2 = runEncode('string', 'three');
    expect(r2,
      '0000000000000000000000000000000000000000000000000000000000000005' +
      '7468726565000000000000000000000000000000000000000000000000000000');
  });

  test('address test', () {
    var r1 = runEncode('address', 'd0a1e359811322d97991e03f863a0c30c2cf029c');
    expect(r1,
      '000000000000000000000000d0a1e359811322d97991e03f863a0c30c2cf029c');
  });
  
  test('fixed length bytes test', () {
    var r1 = runEncode('bytes32', new Uint8List.fromList([0xc8,0x48,0x5c,0xc9,0xd9,0xd6,0xe0,0x82,0xfb,0xf9,0x5e,0xed,0xb5,0x4a,0x33,0x81,0x98,0xce,0x7d,0xbb,0xd2,0x47,0x95,0xad,0x2d,0x85,0x48,0xb2,0x7d,0x07,0xb3,0x42]));
    expect(r1,
      'c8485cc9d9d6e082fbf95eedb54a338198ce7dbbd24795ad2d8548b27d07b342');
      
    var r2 = runEncode('bytes24', new Uint8List.fromList([0xc8,0x48,0x5c,0xc9,0xd9,0xd6,0xe0,0x82,0xfb,0xf9,0x5e,0xed,0xb5,0x4a,0x33,0x81,0x98,0xce,0x7d,0xbb,0xd2,0x47,0x95,0xad]));
    expect(r2,
      'c8485cc9d9d6e082fbf95eedb54a338198ce7dbbd24795ad0000000000000000');
  });

  

  test('static list test', () {
    var r1 = runEncode('(uint256[4],uint256)', [[1,2,3,4], 5]);
    expect(r1, 
      '0000000000000000000000000000000000000000000000000000000000000001' +
      '0000000000000000000000000000000000000000000000000000000000000002' +
      '0000000000000000000000000000000000000000000000000000000000000003' +
      '0000000000000000000000000000000000000000000000000000000000000004' +
      '0000000000000000000000000000000000000000000000000000000000000005');
  });

  test('test mixin of dynamic and static headers', () {
    var r1 = runEncode('(string[],uint128[6],address[],uint256[2])', [
      ["one", "two", "three"],
      [1,2,3,4,5,6],
      [],
      [7,8]
    ]);
    expect(r1,
      '0000000000000000000000000000000000000000000000000000000000000140'+ 
      '0000000000000000000000000000000000000000000000000000000000000001'+ 
      '0000000000000000000000000000000000000000000000000000000000000002'+
      '0000000000000000000000000000000000000000000000000000000000000003'+
      '0000000000000000000000000000000000000000000000000000000000000004'+
      '0000000000000000000000000000000000000000000000000000000000000005'+
      '0000000000000000000000000000000000000000000000000000000000000006'+
      '0000000000000000000000000000000000000000000000000000000000000280'+
      '0000000000000000000000000000000000000000000000000000000000000007'+
      '0000000000000000000000000000000000000000000000000000000000000008'+
      '0000000000000000000000000000000000000000000000000000000000000003'+
      '0000000000000000000000000000000000000000000000000000000000000060'+
      '00000000000000000000000000000000000000000000000000000000000000a0'+
      '00000000000000000000000000000000000000000000000000000000000000e0'+
      '0000000000000000000000000000000000000000000000000000000000000003'+
      '6f6e650000000000000000000000000000000000000000000000000000000000'+
      '0000000000000000000000000000000000000000000000000000000000000003'+
      '74776f0000000000000000000000000000000000000000000000000000000000'+
      '0000000000000000000000000000000000000000000000000000000000000005'+
      '7468726565000000000000000000000000000000000000000000000000000000'+
      '0000000000000000000000000000000000000000000000000000000000000000');
  });

  test('list test', () {
    var r1 = runEncode('address[]', ['d0a1e359811322d97991e03f863a0c30c2cf029c', 'aaf64bfcc32d0f15873a02163e7e500671a4ffcd']);
    expect(r1,
      '0000000000000000000000000000000000000000000000000000000000000002' +
      '000000000000000000000000d0a1e359811322d97991e03f863a0c30c2cf029c' +
      '000000000000000000000000aaf64bfcc32d0f15873a02163e7e500671a4ffcd');
    
    var r2 = runEncode('address[]', []);
    expect(r2,
      '0000000000000000000000000000000000000000000000000000000000000000');

    var r3 = runEncode('uint256[]', [1,2,3]);
    expect(r3,
      '0000000000000000000000000000000000000000000000000000000000000003' +
      '0000000000000000000000000000000000000000000000000000000000000001' +
      '0000000000000000000000000000000000000000000000000000000000000002' +
      '0000000000000000000000000000000000000000000000000000000000000003');

    var r4 = runEncode('address[2]', ['d0a1e359811322d97991e03f863a0c30c2cf029c', 'aaf64bfcc32d0f15873a02163e7e500671a4ffcd']);
    expect(r4,
      '000000000000000000000000d0a1e359811322d97991e03f863a0c30c2cf029c' +
      '000000000000000000000000aaf64bfcc32d0f15873a02163e7e500671a4ffcd');
  });

  test('relocate test', () {
    var r1 = runEncode('(uint[][],string[])', [[[1,2], [3]], ['one', 'two', 'three']]);
    expect(r1,
      '0000000000000000000000000000000000000000000000000000000000000040' +
      '0000000000000000000000000000000000000000000000000000000000000140' +
      '0000000000000000000000000000000000000000000000000000000000000002' +
      '0000000000000000000000000000000000000000000000000000000000000040' +
      '00000000000000000000000000000000000000000000000000000000000000a0' +
      '0000000000000000000000000000000000000000000000000000000000000002' +
      '0000000000000000000000000000000000000000000000000000000000000001' +
      '0000000000000000000000000000000000000000000000000000000000000002' +
      '0000000000000000000000000000000000000000000000000000000000000001' +
      '0000000000000000000000000000000000000000000000000000000000000003' +
      '0000000000000000000000000000000000000000000000000000000000000003' +
      '0000000000000000000000000000000000000000000000000000000000000060' +
      '00000000000000000000000000000000000000000000000000000000000000a0' +
      '00000000000000000000000000000000000000000000000000000000000000e0' +
      '0000000000000000000000000000000000000000000000000000000000000003' +
      '6f6e650000000000000000000000000000000000000000000000000000000000' +
      '0000000000000000000000000000000000000000000000000000000000000003' +
      '74776f0000000000000000000000000000000000000000000000000000000000' +
      '0000000000000000000000000000000000000000000000000000000000000005' +
      '7468726565000000000000000000000000000000000000000000000000000000');
  });
}