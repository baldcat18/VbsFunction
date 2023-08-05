using namespace Microsoft.VisualBasic
using namespace System.Runtime.InteropServices

function Array {
	<#
	.SYNOPSIS
	Create an array.
	.DESCRIPTION
	Create an array.
	If no arguments are specified, an array of zero length is created.
	.PARAMETER ArgList
	Assigned to the elements of an array.
	.OUTPUTS
	System.Object[]
	.EXAMPLE
	PS >Array 10 20 30
	#>

	[CmdletBinding()]
	[OutputType([object[]])]
	param (
		[parameter(ValueFromRemainingArguments)]
		[object[]]$ArgList
	)

	return $ArgList
}

function CreateObject {
	<#
	.SYNOPSIS
	Creates and returns a reference to a COM object.
	.DESCRIPTION
	Creates and returns a reference to a COM object.
	.PARAMETER ProgId
	The program ID of the object to create.
	.PARAMETER ServerName
	The name of the server where the object is created.
	If this is an empty string, the local computer will be used.
	.OUTPUTS
	System.__ComObject
	.EXAMPLE
	PS >CreateObject WScript.Shell
	#>

	[CmdletBinding()]
	[OutputType([__ComObject])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[string]$ProgId,
		[Parameter(Position = 1)]
		[string]$ServerName
	)

	try {
		try {
			$type = if ($ServerName) {
				[Type]::GetTypeFromProgID($ProgId, $ServerName, $true)
			} else {
				[Type]::GetTypeFromProgID($ProgId, $true)
			}
			return [Activator]::CreateInstance($type)
		} catch [COMException] {
			throw [COMException]::new($_.ToString(), $_.Exception)
		}
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function GetObject {
	<#
	.SYNOPSIS
	Returns a reference to an automation object obtained from a file.
	.DESCRIPTION
	Returns a reference to an automation object obtained from a file.
	If you omit the PathName argument, GetObject returns the currently active object of the class type specified by the Class argument.
	.PARAMETER PathName
	Full path and name of the file containing the object to retrieve.
	.PARAMETER Class
	A string representing the class of the object.
	.OUTPUTS
	System.__ComObject
	.EXAMPLE
	PS >GetObject "C:\foo.html"
	#>

	[CmdletBinding(DefaultParameterSetName = 'PathName')]
	[OutputType([__ComObject])]
	param (
		[Parameter(ParameterSetName = 'PathName', Mandatory, Position = 0)][ValidateNotNull()]
		[string]$PathName,
		[Parameter(ParameterSetName = 'Class', Mandatory)][ValidateNotNull()]
		[string]$Class
	)

	try {
		try {
			if ($PSCmdlet.ParameterSetName -eq 'PathName') {
				return [Marshal]::BindToMoniker($PathName)
			} else {
				return CreateObject $Class -ErrorAction Stop
			}
		} catch [COMException] {
			throw [COMException]::new($_.ToString(), $_.Exception)
		}
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function GetRef {
	<#
	.SYNOPSIS
	Returns a reference to a function that can be bound with an event.
	.DESCRIPTION
	Returns a reference to a function that can be bound with an event.
	.PARAMETER FunctionName
	A name of the function associated with the event.
	.OUTPUTS
	System.Management.Automation.ScriptBlock
	.EXAMPLE
	PS >Add-Type -AssemblyName System.Windows.Forms
	PS >$button = New-Object System.Windows.Forms.Button
	PS >function hello { [System.Windows.Forms.MessageBox]::Show('hello') }
	PS >$hello = GetRef hello
	PS >$button.add_Click($hello)
	#>

	[CmdletBinding()]
	[OutputType([scriptblock])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[string]$FunctionName
	)

	try {
		return (Get-Item function:$FunctionName -ErrorAction Stop).ScriptBlock
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function IsArray {
	<#
	.SYNOPSIS
	Returns a Boolean value indicating whether the given argument is an array.
	.DESCRIPTION
	Returns a Boolean value indicating whether the given argument is an array.
	.PARAMETER Object
	The value to check if it is an array.
	.OUTPUTS
	System.Boolean
	.EXAMPLE
	PS >IsArray @(1, 2, 3)

	True
	.EXAMPLE
	PS >IsArray foobar

	False
	#>

	[CmdletBinding()]
	[OutputType([bool])]
	param (
		[Parameter(Position = 0)]
		[object]$Object
	)

	return $Object -is [array]
}

function IsDate {
	<#
	.SYNOPSIS
	Returns a Boolean value indicating whether the given argument can be converted to a DateTime type.
	.DESCRIPTION
	Returns a Boolean value indicating whether the given argument can be converted to a DateTime type.
	.PARAMETER Object
	The value to check if it is a DateTime type.
	.OUTPUTS
	System.Boolean
	.EXAMPLE
	PS >IsDate 1/2/2034

	True
	.EXAMPLE
	PS >IsDate foobar

	False
	#>

	[CmdletBinding()]
	[OutputType([bool])]
	param (
		[Parameter(Position = 0)]
		[object]$Object
	)

	return $null -ne ($Object -as [datetime])
}

function IsNull {
	<#
	.SYNOPSIS
	Returns a Boolean value indicating whether the given argument is null.
	.DESCRIPTION
	Returns a Boolean value indicating whether the given argument is null.
	.PARAMETER Object
	The value to check if it is null.
	.OUTPUTS
	System.Boolean
	.EXAMPLE
	PS >IsNull $null

	True
	.EXAMPLE
	PS >IsNull foobar

	False
	#>

	[CmdletBinding()]
	[OutputType([bool])]
	param (
		[Parameter(Position = 0)]
		$Object
	)

	return $null -eq $Object
}

function IsNumeric {
	<#
	.SYNOPSIS
	Returns a Boolean value indicating whether the given argument can be evaluated as a number.
	.DESCRIPTION
	Returns a Boolean value indicating whether the given argument can be evaluated as a number.
	Returns True if the argument is a string containing valid hexadecimal or octal digits.
	Also returns True if the argument is a valid numeric expression that begins with a + or - character or contains thousands separators.
	.PARAMETER Object
	The value to check if it is number.
	.OUTPUTS
	System.Boolean
	.EXAMPLE
	PS >IsNumeric '1,234,567'

	True
	.EXAMPLE
	PS >IsNumeric foobar

	False
	#>

	[CmdletBinding()]
	[OutputType([bool])]
	param (
		[Parameter(Position = 0)]
		[object]$Object
	)

	if ($null -eq $Object) { return $false }
	return $null -ne ($Object -as [double])
}

function IsObject {
	<#
	.SYNOPSIS
	Returns a Boolean value indicating whether the given argument is a reference type.
	.DESCRIPTION
	Returns a Boolean value indicating whether the given argument is a reference type.
	.PARAMETER Expression
	The value to check if it is a reference type.
	.OUTPUTS
	System.Boolean
	.EXAMPLE
	PS >IsObject foobar

	True
	.EXAMPLE
	PS >IsObject 1.25

	False
	#>

	[CmdletBinding()]
	[OutputType([bool])]
	param (
		[Parameter(Position = 0)]
		[object]$Expression
	)

	return $Expression -isnot [ValueType]
}

function LBound {
	<#
	.SYNOPSIS
	Returns the lowest possible index number for the specified dimension of the array.
	.DESCRIPTION
	Returns the lowest possible index number for the specified dimension of the array.
	.PARAMETER Array
	An array of any data type to be examined.
	.PARAMETER Dimension
	The dimension for which you want to find the minimum array index number.
	Specify 1 for the first dimension, 2 for the second dimension, and so on.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >LBound (1, 2, 3)

	0
	.EXAMPLE
	PS >$array = [array]::CreateInstance([int], (2,3), (0,1))
	PS >LBound $array 2

	1
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[array]$Array,
		[Parameter(Position = 1)]
		[ValidateScript(
			{
				if ($_ -ge 1 -and $_ -le $Array.Rank) { return $true }
				throw 'Array does not have that many dimensions.'
			}
		)]
		[int]$Dimension = 1
	)

	return $Array.GetLowerBound($Dimension - 1)
}

function RGB {
	<#
	.SYNOPSIS
	Returns a value representing an RGB color value.
	.DESCRIPTION
	Returns a value representing an RGB color value.
	Methods and properties that take a color specification accept the color as a number representing an RGB color value. RGB color values ​​represent colors by specifying the relative intensities of red, green, and blue.
	The lower byte of the return value of this function contains the red component value, the middle byte contains the green component value, and the upper byte contains the blue component value.
	If the value of each argument is greater than 255, 255 is used.
	.PARAMETER Red
	A number between 0 and 255 representing the red component of the desired color.
	.PARAMETER Green
	A number between 0 and 255 representing the green component of the desired color.
	.PARAMETER Blue
	A number between 0 and 255 representing the blue component of the desired color.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Hex (RGB 0x30 0x60 0x90)

	906030
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$Red,
		[Parameter(Mandatory, Position = 1)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$Green,
		[Parameter(Mandatory, Position = 2)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$Blue
	)

	if ($Red -gt 256) { $Red = 255 }
	if ($Green -gt 256) { $Green = 255 }
	if ($Blue -gt 256) { $Blue = 255 }

	return $Red + $Green * 256 + $Blue * 65536
}

function TypeName {
	<#
	.SYNOPSIS
	Returns a string representing the type of the specified variable.
	.DESCRIPTION
	Returns a string representing the type of the specified variable.
	.PARAMETER VarName
	Any variable.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >TypeName 1

	Integer
	.EXAMPLE
	PS >$wshShell = CreateObject WScript.Shell
	PS >TypeName $wshShell

	IWshShell3
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Position = 0)]
		$VarName
	)

	return [Information]::TypeName($VarName)
}

function UBound {
	<#
	.SYNOPSIS
	Returns the highest possible index number for the specified dimension in the array.
	.DESCRIPTION
	Returns the highest possible index number for the specified dimension in the array.
	.PARAMETER Array
	An array of any data type to be examined.
	.PARAMETER Dimension
	The dimension for which you want to find the minimum array index number.
	Specify 1 for the first dimension, 2 for the second dimension, and so on.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >UBound (1, 2, 3)

	2
	.EXAMPLE
	PS >$array = [array]::CreateInstance([int], (2,3), (0,1))
	PS >UBound $array 2

	3
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[array]$Array,
		[Parameter(Position = 1)]
		[ValidateScript(
			{
				if ($_ -ge 1 -and $_ -le $Array.Rank) { return $true }
				throw 'Array does not have that many dimensions.'
			}
		)]
		[int]$Dimension = 1
	)

	return $Array.GetUpperBound($Dimension - 1)
}

function VarType {
	<#
	.SYNOPSIS
	Returns a value containing the data type classification of the variable.
	.DESCRIPTION
	Returns a value containing the data type classification of the variable.
	.PARAMETER VarName
	Any variable.
	.OUTPUTS
	Microsoft.VisualBasic.VariantType
	.EXAMPLE
	PS >VarType 1

	Integer
	.EXAMPLE
	PS >VarType $PSVersionTable

	Object
	.EXAMPLE
	PS >VarType @()

	8201
	# Array and Object
	#>

	[CmdletBinding()]
	[OutputType([Microsoft.VisualBasic.VariantType])]
	param (
		[Parameter(Position = 0)]
		$VarName
	)

	return [Information]::VarType($VarName)
}
