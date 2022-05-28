# EncodeMessage

A fun exercise at encoding and decoding strings with [PowerShell classes](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_classes).

## `Encode` Class

### Constructors

| Command | Description |
| ----------- | ---- |
| `[Encode](string)` | Initializes a new instance of the `Encode` class encoding the _string_ with the default `EncodingComplexity` value. |
| `[Encode](string, 4)` &nbsp; &nbsp; &nbsp; &nbsp; | Initializes a new instance of the `Encode` class encoding the _string_ with a `EncodingComplexity` value of 4. |

### Properties

| Name | Description |
| ---- | ---- |
| `EncodingComplexity` | The value of this property is multiplied by the `Length` of the _input string_ to generate a new encoded message. __Default value 3__. |
| `EncodedMessage` | This property holds the value of the encoded message. |
| `Map` | The `int` array needed to decoded the message. |

## `Decode` Class

### Methods

| Command | Description |
| ---- | ---- |
| `DecodeMessage(Encode)` | Takes an object of the class `Encode` as argument to decode the message. |
| `DecodeMessage(string, int[])` | Takes an _encoded string_ and the Map a assumes default Encoding Complexity to decode the message. |
| `DecodeMessage(string, int[], int)` &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | Takes an _encoded string_, the Map and the Encoding Complexity to decode the message. |

## Usage

### Encoding a message with default Encoding Complexity

```powershell
PS /> $message = 'hello world 123!'
PS /> $enc = [Encode] $message
PS /> $enc

EncodingComplexity EncodedMessage                                   Map
------------------ --------------                                   ---
                 3 IW}o: Fh&eoWPsobO|ur3GFK!kllNh+dHfS1hI821 lDhXwm {44, 9, 27, 42…}
```

### Encoding a message with custom Encoding Complexity

```
PS /> $enc = [Encode]::new('hello world 123!', 4)
PS /> $enc

EncodingComplexity EncodedMessage                                                   Map
------------------ --------------                                                   ---
                 4 U8dj^^2x{-_3dr0aVyC!aP?DHl}lKGBY2tdmt6P1o%/h27oe.Th l 8ZZ39mwb|3 {50, 47, 25, 52…}
```

### Decoding a message using a `Encode` object

```
PS /> $enc = [Encode]::new('hello world 123!', 4)
PS /> [Decode]::DecodeMessage($enc)

hello world 123!
```

### Decoding a message with a Map

```powershell
PS /> $enc = [Encode] 'hello world 123!'
PS /> [Decode]::DecodeMessage($enc.EncodedMessage, $enc.Map)

'hello world 123!'
````

### Decoding a message with a Map and custom Encoding Complexity

```powershell
PS /> $message = 'hello world 123!'
PS /> $enc = [Encode]::new($message, 5)
PS /> [Decode]::DecodeMessage($enc.EncodedMessage, $enc.Map, $enc.EncodingComplexity)

'hello world 123!'
```
