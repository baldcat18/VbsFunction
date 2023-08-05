function CBool {
	<#
	.SYNOPSIS
	Converts an object to a boolean value.
	.DESCRIPTION
	Converts an object to a boolean value.
	.PARAMETER Object
	Value to be converted to boolean type.
	.OUTPUTS
	System.Boolean
	.EXAMPLE
	PS >CBool 0

	False
	#>

	[CmdletBinding()]
	[OutputType([bool])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowNull()]
		$Object
	)

	try {
		return [bool]$Object
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function CByte {
	<#
	.SYNOPSIS
	Converts an object to a byte value.
	.DESCRIPTION
	Converts an object to a byte value.
	An error occurs if the specified argument is outside the allowable range of byte types.
	.PARAMETER Object
	Value to be converted to byte type.
	.OUTPUTS
	System.Byte
	.EXAMPLE
	PS >CByte 125.5678

	126
	#>

	[CmdletBinding()]
	[OutputType([byte])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowNull()]
		$Object
	)

	try {
		return [byte]$Object
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function CDate {
	<#
	.SYNOPSIS
	Converts an object to a datetime value.
	.DESCRIPTION
	Converts an object to a datetime value.
	.PARAMETER Object
	Value to be converted to datetime type.
	.OUTPUTS
	System.DateTime
	.EXAMPLE
	PS >CDate "1/23/2011"
	.EXAMPLE
	PS >CDate "1:23:45 PM"
	.EXAMPLE
	PS >CDate "1/23/2011 1:23:45 PM"
	#>

	[CmdletBinding()]
	[OutputType([datetime])]
	param (
		[Parameter(Mandatory, Position = 0)]
		$Object
	)

	try {
		return [datetime]$Object
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function CDbl {
	<#
	.SYNOPSIS
	Converts the given value to a double precision floating point number.
	.DESCRIPTION
	Converts the given value to a double precision floating point number.
	.PARAMETER Object
	Value to be converted to double precision floating point number
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >CDbl "1234.5678"

	1234.5678
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowNull()]
		$Object
	)

	try {
		return [double]$Object
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function CInt {
	<#
	.SYNOPSIS
	Converts an object to a 16-bit integer value.
	.DESCRIPTION
	Converts an object to a 16-bit integer value.
	The CInt function rounds to the nearest even number when the fractional part of the value is exactly 0.5.
	For example, 0.5 rounds to 0, 1.5 rounds to 2, 3.5 rounds to 4.
	.PARAMETER Object
	Value to be converted to 16-bit integer type.
	.OUTPUTS
	System.Int16
	.EXAMPLE
	PS >CInt "12.5"

	12
	.EXAMPLE
	PS >CInt -127.5

	-128
	#>

	[CmdletBinding()]
	[OutputType([int16])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowNull()]
		$Object
	)

	try {
		return [int16]$Object
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function CLng {
	<#
	.SYNOPSIS
	Converts an object to a 32-bit integer value.
	.DESCRIPTION
	Converts an object to a 32-bit integer value.
	The CInt function rounds to the nearest even number when the fractional part of the value is exactly 0.5.
	For example, 0.5 rounds to 0, 1.5 rounds to 2, 3.5 rounds to 4.
	.PARAMETER Object
	Value to be converted to 32-bit integer type.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >CLng "12.5"

	12
	.EXAMPLE
	PS >CLng -127.5

	-128
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowNull()]
		$Object
	)

	try {
		return [int]$Object
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function CSng {
	<#
	.SYNOPSIS
	Converts the given value to a single precision floating point number.
	.DESCRIPTION
	Converts the given value to a single precision floating point number.
	.PARAMETER Object
	Value to be converted to single precision floating point number
	.OUTPUTS
	System.Single
	.EXAMPLE
	PS >CSng "1234.5678"

	1234.568
	#>

	[CmdletBinding()]
	[OutputType([float])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowNull()]
		$Object
	)

	try {
		return [float]$Object
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function CStr {
	<#
	.SYNOPSIS
	Converts the given value to a string.
	.DESCRIPTION
	Converts the given value to a string.
	.PARAMETER Object
	Value to be converted to string.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >CStr 13
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowNull()]
		$Object
	)

	try {
		return [string]$Object
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function Hex {
	<#
	.SYNOPSIS
	Returns a string representing the hexadecimal value of a specified value.
	.DESCRIPTION
	Returns a string representing the hexadecimal value of a specified value.
	If the number argument is not an integer, it is rounded to the nearest integer before conversion.
	.PARAMETER Number
	Any valid numeric expression or expression of type String.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >Hex 6

	6
	.EXAMPLE
	PS >Hex 30

	1E
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][ValidateNotNull()]
		[object]$Number
	)

	try {
		return $Number.ToString('X')
	} catch {
		try {
			return ([long]$Number).ToString('X')
		} catch {
			$PSCmdlet.WriteError($PSItem)
		}
	}
}

function Oct {
	<#
	.SYNOPSIS
	Returns the specified value in octal.
	.DESCRIPTION
	Returns the specified value in octal.
	If the number argument is not an integer, it is rounded to the nearest integer before conversion.
	.PARAMETER Number
	Any valid numeric expression or expression of type String.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >Oct 6

	6
	.EXAMPLE
	PS >Oct 30

	36
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[object]$Number
	)

	try {
		return [Convert]::ToString($Number, 8)
	} catch {
		try {
			return [Convert]::ToString([long]$Number, 8)
		} catch {
			$PSCmdlet.WriteError($PSItem)
		}
	}
}
