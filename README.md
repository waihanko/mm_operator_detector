# Myanmar Operator Detector

Detects and identifies Myanmar telecommunications operators.

## Usage


```dart

String result =  MMOperatorDetector.normalizeInput("+95959428000332");
String result =  MMOperatorDetector.normalizeInput("+959428000332");
String result =  MMOperatorDetector.normalizeInput("+9509428000332");
//result = 09428000332

String bool = MMOperatorDetector.isValidMMPhoneNumber("09428000332");
//result = true

TelecomOperator operator =  MMOperatorDetector.getTelecomName("09428000332");
//mpt


NetworkType networkType = MMOperatorDetector.getPhoneNetworkType("09428000332");
//gsm
```

Special Thanks and Credit to: [Myanmar Phone Number](https://github.com/kaungmyatlwin/myanmar-phonenumber)

