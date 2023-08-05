using namespace Microsoft.VisualBasic

function Abs {
	<#
	.SYNOPSIS
	Returns the absolute value of a number.
	.DESCRIPTION
	Returns the absolute value of a number.
	If the specified argument is Null, Null is returned.
	.PARAMETER Number
	Numeric value for which you want to get the absolute value.
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >Abs 10.25

	10.25
	.EXAMPLE
	PS >Abs -10.25

	10.25
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[double]$Number
	)

	return [Math]::Abs($Number)
}

function Atn {
	<#
	.SYNOPSIS
	Returns the angle whose tangent is the specified number.
	.DESCRIPTION
	The Atn function takes the ratio of two sides of a right triangle (Number) and returns the corresponding angle in radians.
	The ratio is the length of the side opposite the angle divided by the length of the side adjacent to the angle.
	The range of the result is -pi /2 to pi/2 radians.

	To convert degrees to radians, multiply degrees by pi/180.
	To convert radians to degrees, multiply radians by 180/pi.
	.PARAMETER Number
	A number representing a tangent.
	.OUTPUTS
	System.Double
		An angle, θ, measured in radians, such that -pi/2 ≤ θ ≤ pi/2.
		NaN if Number equals NaN, -pi/2 rounded to double precision (-1.5707963267949) if Number equals NegativeInfinity, or pi/2 rounded to double precision (1.5707963267949) if Number equals PositiveInfinity.

	.EXAMPLE
	PS >(Atn 1) * 4 -eq [Math]::PI

	True
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[double]$Number
	)

	return [Math]::Atan($Number)
}

function Cos {
	<#
	.SYNOPSIS
	Returns the cosine of an angle.
	.DESCRIPTION
	Returns the cosine of an angle.
	.PARAMETER Number
	Any numeric expression (in radians).
	To convert the angle to radians, multiply by [Math]::PI/180.
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >Cos (60 * [Math]::PI / 180)

	0.5
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[double]$Number
	)

	return [Math]::Cos($Number)
}

function Exp {
	<#
	.SYNOPSIS
	A math function that computes the exponential function in base e.
	.DESCRIPTION
	A math function that computes the exponential function in base e.
	.PARAMETER Number
	A number that specifies a power.
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >Exp 1

	2.71828182845905
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[double]$Number
	)

	return [Math]::Exp($Number)
}

function Fix {
	<#
	.SYNOPSIS
	Returns an integer value with the fractional part of a number removed.
	.DESCRIPTION
	Returns an integer value with the fractional part of a number removed.
	If the argument Number is negative, it returns the smallest negative integer greater than or equal to the argument Number.
	.PARAMETER Number
	A number or any valid numeric expression.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Fix 9.5

	9
	.EXAMPLE
	PS >Fix -9.5

	-9
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[ValidateScript(
			{
				[double]$_ > $null
				return $true
			}
		)]
		$Number
	)

	try {
		return [Conversion]::Fix($Number)
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function Int {
	<#
	.SYNOPSIS
	Returns an integer value with the fractional part of a number removed.
	.DESCRIPTION
	Returns an integer value with the fractional part of a number removed.
	If the argument Number is negative, returns the largest negative integer less than or equal to the argument Number.
	.PARAMETER Number
	A number or any valid numeric expression.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Int 9.5

	9
	.EXAMPLE
	PS >Int -9.5

	-10
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[ValidateScript(
			{
				[double]$_ > $null
				return $true
			}
		)]
		$Number
	)

	try {
		return [Conversion]::Int($Number)
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function Log {
	<#
	.SYNOPSIS
	Returns the natural logarithm of a number.
	.DESCRIPTION
	Returns the natural logarithm of a number.
	The base n logarithm of any number x is obtained by dividing the natural logarithm of x by the natural logarithm of n as follows:

	Log n(x) = Log(x) / Log(n)
	.PARAMETER Number
	Any valid numeric expression greater than 0.
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >Log 1

	0
	.EXAMPLE
	PS >Log ([Math]::E)

	1
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[ValidateScript(
			{
				if ($_ -gt 0) { return $true }
				throw 'Enter a value greater than 0.'
			}
		)]
		[double]$Number
	)

	return [Math]::Log($Number)
}

$script:random = [Random]::new(0)
$script:prevRamdomNumber = $script:random.NextDouble()

function Randomize {
	<#
	.SYNOPSIS
	Initialize the random number generator.
	.DESCRIPTION
	Initialize the random number generator.
	If you do not use the Randomize function, calling the Rnd function with no arguments uses the same seed value as the first call to the Rnd function.
	From then on, the most recently generated number is used as the seed value.
	.PARAMETER Number
	A new seed value to pass to the Rnd function's random number generator.
	If Number is omitted, the value obtained from the system timer is used as the new seed value.
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >Randomize
	PS >Rnd
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Position = 0)]
		[double]$Number = [double]::NaN
	)

	if ([double]::IsNaN($Number)) {
		$now = Get-Date
		$timer = [float]((60 * $now.Hour + $now.Minute) * 60 + $now.Second + ($now.Millisecond / 1000))
		$value = [BitConverter]::ToInt32([BitConverter]::GetBytes($timer), 0)
		$value = (($value -band 0xFFFF) -bor ($value -shr 16)) -shl 8
		$rnd = [BitConverter]::ToInt32([BitConverter]::GetBytes($script:prevRamdomNumber), 4)
		$seed = ($rnd -band 0xFF0000FF) -bor $value
	} else {
		$value = [BitConverter]::ToInt32([BitConverter]::GetBytes($Number), 4)
		$seed = (($value -band 0xFFFF) -bor ($value -shr 16)) -shl 8
	}

	$script:random = [Random]::new($seed)
	$script:prevRamdomNumber = $script:random.NextDouble()
}

function Rnd {
	<#
	.SYNOPSIS
	Returns a random number in the range greater than or equal to 0 and less than 1.
	.DESCRIPTION
	Returns a random number in the range greater than or equal to 0 and less than 1.
	If the argument Number is negative, it always returns the same number determined by the seed value of the argument.
	If the argument Number is unspecified or positive, returns the next random number from the same random number sequence.
	If the argument is 0, it returns the same number as the previously generated random number.
	.PARAMETER Number
	Any valid numeric expression.
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >Rnd

	0.817325359590969

	PS >Rnd

	0.768022689394663

	PS >Rnd 0

	0.768022689394663
	.EXAMPLE
	PS >Rnd -16

	0.0850482969940865

	PS >Rnd -16

	0.0850482969940865
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Position = 0)]
		[double]$Number = [double]::NaN
	)

	if ($Number -ne 0) {
		$rndObj = if ($Number -lt 0) { [Random]::new($Number) }  else { $script:random }
		$script:prevRamdomNumber = $rndObj.NextDouble()
	}

	return $script:prevRamdomNumber
}

function Round {
	<#
	.SYNOPSIS
	Returns a number rounded to the specified decimal place.
	.DESCRIPTION
	Returns a number rounded to the specified decimal place.
	Midpoint values ​​are rounded to the nearest even value.
	.PARAMETER Value
	Number to round.
	.PARAMETER DecimalPlaces
	A number representing the number of decimal places to round to.
	If omitted, the Round function returns an integer value.
	This argument values ​​range from 0 to 15.
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >Round 255.5

	256
	.EXAMPLE
	PS >Round 256.5

	256
	.EXAMPLE
	PS >Round 3.14159 4

	3.1416
	.EXAMPLE
	PS >Rnd -8.115 2

	-8.12
	.EXAMPLE
	PS >Rnd -8.125 2

	-8.12
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[double]$Value,
		[Parameter(Position = 1)]
		[ValidateRange(0, 15)]
		[int]$DecimalPlaces = 0
	)

	return [Math]::Round($Value, $DecimalPlaces)
}

function Sgn {
	<#
	.SYNOPSIS
	Returns an integer indicating the sign of the number specified in the argument.
	.DESCRIPTION
	Returns an integer indicating the sign of the number specified in the argument.
	.PARAMETER Number
	Any numeric expression.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Sgn 10

	1
	.EXAMPLE
	PS >Sgn -10

	-1
	.EXAMPLE
	PS >Sgn 0

	0
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[double]$Number
	)

	switch ($Number) {
		{ $_ -gt 0 } { return 1 }
		{ $_ -lt 0 } { return -1 }
		Default { return 0 }
	}
}

function Sin {
	<#
	.SYNOPSIS
	Returns the sine of an angle.
	.DESCRIPTION
	Returns the sine of an angle.
	.PARAMETER Number
	Any numeric expression (in radians).
	To convert the angle to radians, multiply by [Math]::PI/180.
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >Sin (30 * [Math]::PI / 180)

	0.5
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[double]$Number
	)

	return [Math]::Sin($Number)
}

function Sqr {
	<#
	.SYNOPSIS
	Returns the square root of an expression.
	.DESCRIPTION
	Returns the square root of an expression.
	.PARAMETER Number
	Any valid numeric expression greater than or equal to 0.
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >Sqr 9

	3
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[ValidateRange(0, [double]::MaxValue)]
		[double]$Number
	)

	return [Math]::Sqrt($Number)
}

function Tan {
	<#
	.SYNOPSIS
	Returns the tangent of an angle.
	.DESCRIPTION
	Returns the tangent of an angle.
	.PARAMETER Number
	Any numeric expression (in radians).
	To convert the angle to radians, multiply by [Math]::PI/180.
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >Tan (45 * [Math]::PI / 180)

	1
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[double]$Number
	)

	return [Math]::Tan($Number)
}
