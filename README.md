# Decode and encode ETH contract call package
This package only deals with contract call encoding/decoding.  

# What this package does NOT do
* fetch contract abi from chain
* fetch any transaction infomation from chain
* check whether input data matches the contract abi
* encoding the whole ETH transaction with RLP format
* digest or sign transaction
* send transaction to chain

# Usage of decoding contract call
* Step1  
Fetch contract abi from either etherscan.io or infura.  
For example, contract abi for USDT-ERC20 can be found on [USDT ERC20 Contract Code Page](https://etherscan.io/address/0xdac17f958d2ee523a2206206994597c13d831ec7#code), the abi is listed at Contract ABI section.

* Step2  
Build an abi object
```dart
import 'package:eth_abi_codec/eth_abi_codec.dart';
var abi = ContractABI.fromJson(jsonDecode(abi_json_str));
```

* Step3  
Decode the binary data in "input" field of an ethereum transaction
```dart
import 'package:eth_abi_codec/eth_abi_codec.dart';
import 'package:convert/convert.dart';
var data = hex.decode('hex string of input field');
var call = ContractCall.fromBinary(data, abi);
```

* Step4  
Fetch infomation from ContractCall object
```dart
//function name
print('function name ${call.functionName}');

//function params
call.callParams.forEach((p) {
    print('param field ${p.paramName}');
    print('param value ${p.paramValue}');
});
```