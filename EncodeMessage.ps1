class Encode {
    [string] $EncodedMessage
    [int[]]  $Map
    [int]    $EncodingComplexity = 3

    Encode ([string] $Value) {
        $this.Shuffle($Value)
    }

    [void] Shuffle([string] $Value) {
        $set = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_-+=[{]};:<>|./?'
        $ref = [Collections.Generic.HashSet[int]]::new()
        $ran = [random]::new()
        $enc = [char[]]::new($Value.Length * $this.EncodingComplexity)

        for($i = 0;  $i -lt $Value.Length; $i++) {
            do {
                $x = $ran.Next($enc.Length)
            } until($ref.Add($x))
            $enc[$x] = $Value[$i]
        }

        for($i = 0; $i -lt $enc.Length; $i++) {
            if($i -notin $ref) {
                $enc[$i] = $set[$ran.Next($set.Length)]
            }
        }

        $this.EncodedMessage = [string]::new($enc)
        $this.Map = $ref
    }
}

class Decode {
    static [string] DecodeMessage ([Encode] $Object) {
        return [Decode]::DecodeMessage($Object.EncodedMessage, $Object.Map, $Object.EncodingComplexity)
    }

    static [string] DecodeMessage ([string] $EncodedMessage, [int[]] $Map, [int] $Complexity) {
        $decoded = [char[]]::new($EncodedMessage.Length / $Complexity)
        for($i = 0; $i -lt $decoded.Length; $i++) {
            $decoded[$i] = $EncodedMessage[$Map[$i]]
        }
        return [string]::new($decoded)
    }
}

$enc = [Encode] 'hello world 123!'
[Decode]::DecodeMessage($enc)
[Decode]::DecodeMessage($enc.EncodedMessage, $enc.Map, $enc.EncodingComplexity)
