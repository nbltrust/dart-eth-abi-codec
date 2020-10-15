library eth_abi_codec.abi;

import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:pointycastle/digests/sha3.dart';

class ContractInput {
  final String name;
  final String type;
  ContractInput.fromJson(Map<String, dynamic> json)
    : name = json['name'], type = json['type'];
}

class ContractOutput {
  final String name;
  final String type;
  ContractOutput.fromJson(Map<String, dynamic> json)
    : name = json['name'], type = json['type'];
}

class ContractABIEntry {
  final String name;
  final String type;
  final String stateMutability;
  final bool constant;
  final bool payable;
  final List<ContractOutput> outputs;
  final List<ContractInput> inputs;

  String get paramDescription {
    var params = inputs.map((i) => i.type).join(',');
    return '(${params})';
  }

  String get methodId {
    var s = '${name}${paramDescription}'.codeUnits;
    return hex.encode(
      SHA3Digest(256, true).process(Uint8List.fromList(s)).sublist(0, 4));
  }

  ContractABIEntry.fromJson(Map<String, dynamic> json):
    name = json['name'],
    type = json['type'],
    stateMutability = json['statueMutability'],
    constant = json['constant'],
    payable = json['payable'],
    inputs = List<ContractInput>.from(json['inputs'].map((i) => ContractInput.fromJson(i))),
    outputs = List<ContractOutput>.from(json['outputs'].map((i) => ContractOutput.fromJson(i)));
}

class ContractABI {
  final List<ContractABIEntry> abis;
  Map<String, ContractABIEntry> methodIdMap = new Map(); // maps from method id to method entry

  ContractABI.fromJson(List<dynamic> json):
    abis = List<ContractABIEntry>
      .from(
        json
        .where((i) => i['type'] == 'function') // only processes function abi, ignores events and constructor
        .map((i) => ContractABIEntry.fromJson(i))
      )
    {
      abis.forEach((element) {
        methodIdMap[element.methodId] = element;
      });
    }

  ContractABIEntry getABIEntryByMethodId(String methodId) {
    return methodIdMap[methodId];
  }
}