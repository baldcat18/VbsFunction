using namespace Microsoft.VisualBasic

function Asc {
	<#
	.SYNOPSIS
	Returns the ANSI character code corresponding to the first letter in a string.
	.DESCRIPTION
	Returns the ANSI character code corresponding to the first letter in a string.
	.PARAMETER String
	The first character of the string is used for input.
	.OUTPUTS
	System.Int32
		This can be 0 through 255 for single-byte character set (SBCS) values and -32768 through 32767 for double-byte character set (DBCS) values.
	.EXAMPLE
	PS >Asc "Hello"

	72
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[string]$String
	)

	return [Strings]::Asc($String)
}

function AscB {
	<#
	.SYNOPSIS
	Returns the first byte data of a string.
	.DESCRIPTION
	Returns the first byte data of a string.
	.PARAMETER String
	The first character of the string is used for input.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >AscB "Hello"

	72
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[string]$String
	)

	return [System.Text.Encoding]::Unicode.GetBytes((Left $String 1))[0]
}

function AscW {
	<#
	.SYNOPSIS
	Returns the Unicode code point corresponding to the first letter in a string.
	.DESCRIPTION
	Returns the Unicode code point corresponding to the first letter in a string.
	.PARAMETER String
	The first character of the string is used for input.
	.OUTPUTS
	System.Int32
		This can be 0 through 65535.
		The returned value is independent of the culture and code page settings for the current thread.
	.EXAMPLE
	PS >AscW "Hello"

	72
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[string]$String
	)

	return [int]([char[]]$String)[0]
}

function Chr {
	<#
	.SYNOPSIS
	Returns the character corresponding to the specified ANSI character code.
	.DESCRIPTION
	Returns the character corresponding to the specified ANSI character code.
	.PARAMETER CodePoint
	An Integer expression representing the ANSI character code.
	.OUTPUTS
	System.Char
	.EXAMPLE
	PS >Chr 97

	a
	#>

	[CmdletBinding()]
	[OutputType([char])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[int]$CodePoint
	)

	try {
		return [Strings]::Chr($CodePoint)
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function ChrW {
	<#
	.SYNOPSIS
	Returns the character corresponding to the specified Unicode character code.
	.DESCRIPTION
	Returns the character corresponding to the specified Unicode character code.
	.PARAMETER CodePoint
	An Integer expression representing the Unicode character code.
	.OUTPUTS
	System.Char
	.EXAMPLE
	PS >Chr 97

	a
	#>

	[CmdletBinding()]
	[OutputType([char])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[int]$CodePoint
	)


	try {
		return [char]$CodePoint
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function VbFilter {
	<#
	.SYNOPSIS
	Returns an array containing a subset of the string array based on the specified filter criteria.
	.DESCRIPTION
	Returns an array containing a subset of the string array based on the specified filter criteria.
	.PARAMETER InputString
	An array to search for.
	.PARAMETER Value
	The string to search for.
	.PARAMETER NotMatch
	Finds text that does not match the specified pattern.
	.PARAMETER CaseSensitive
	Case sensitive when looking for a match. By default, case is ignored.
	.OUTPUTS
	System.String[]
	.EXAMPLE
	PS >VbFilter Foo, foo, Bar Foo

	Foo
	foo
	.EXAMPLE
	PS >VbFilter Foo, foo, Bar Foo -CaseSensitive

	Foo
	.EXAMPLE
	PS >VbFilter Foo, foo, Bar Foo -NotMatch

	Bar
	#>

	[CmdletBinding()]
	[OutputType([string[]])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyCollection()][AllowEmptyString()]
		[string[]]$InputString,
		[Parameter(Mandatory, Position = 1)]
		[string]$Value,
		[switch]$NotMatch,
		[switch]$CaseSensitive
	)

	if ($NotMatch) {
		if ($CaseSensitive) { return $InputString -cne $Value }
		else { return $InputString -ine $Value }
	} else {
		if ($CaseSensitive) { return $InputString -ceq $Value }
		else { return $InputString -ieq $Value }
	}
}

function FormatCurrency {
	<#
	.SYNOPSIS
	Format and return a string in currency format using the currency symbol defined in the system Control Panel.
	.DESCRIPTION
	Format and return a string in currency format using the currency symbol defined in the system Control Panel.
	.PARAMETER Expression
	Expression to convert format.
	.PARAMETER NumDigitsAfterDecimal
	A number representing the number of digits to display after the decimal point.
	The default is -1, which uses the value in Region Properties.
	.PARAMETER IncludeLeadingDigit
	A number representing whether to display zeros to the left of the decimal point.
	By default, it uses your computer's regional settings.
	.PARAMETER UseParensForNegativeNumbers
	A value that indicates whether to enclose negative values ​​in parentheses.
	By default, it uses your computer's regional settings.
	.PARAMETER GroupDigits
	A value that represents whether numbers should be separated using the group delimiter specified in the regional properties.
	By default, it uses your computer's regional settings.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >FormatCurrency -12345.6789
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][ValidateNotNull()]
		[object]$Expression,
		[Parameter(Position = 1)]
		[int]$NumDigitsAfterDecimal = -1,
		[Parameter(Position = 2)]
		[ValidateSet('False', 'True', 'UseDefault')]
		[string]$IncludeLeadingDigit = 'UseDefault',
		[Parameter(Position = 3)]
		[ValidateSet('False', 'True', 'UseDefault')]
		[string]$UseParensForNegativeNumbers = 'UseDefault',
		[Parameter(Position = 4)]
		[ValidateSet('False', 'True', 'UseDefault')]
		[string]$GroupDigits = 'UseDefault'
	)

	try {
		try {
			return [Strings]::FormatCurrency(
				$Expression,
				$NumDigitsAfterDecimal,
				[TriState]$IncludeLeadingDigit,
				[TriState]$UseParensForNegativeNumbers,
				[TriState]$GroupDigits
			)
		} catch [InvalidCastException] {
			throw [InvalidCastException]::new($_.ToString(), $_.Exception)
		}
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function FormatDateTime {
	<#
	.SYNOPSIS
	Format and return a string in date or time format.
	.DESCRIPTION
	Format and return a string in date or time format.
	.PARAMETER Date
	A date expression to convert format.
	.PARAMETER NamedFormat
	A value representing the date/time format to use.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >FormatDateTime '12/3/2025 1:23:45 PM'
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[datetime]$Date,
		[Parameter(Position = 1)]
		[ValidateSet('GeneralDate', 'LongDate', 'LongTime', 'ShortDate', 'ShortTime')]
		[string]$NamedFormat = 'GeneralDate'
	)

	return [Strings]::FormatDateTime($Date, [DateFormat]$NamedFormat)
}

function FormatNumber {
	<#
	.SYNOPSIS
	Format and return a string in numeric format.
	.DESCRIPTION
	Format and return a string in numeric format.
	.PARAMETER Expression
	Expression to convert format.
	.PARAMETER NumDigitsAfterDecimal
	A number representing the number of digits to display after the decimal point.
	The default is -1, which uses the value in Region Properties.
	.PARAMETER IncludeLeadingDigit
	A number representing whether to display zeros to the left of the decimal point.
	By default, it uses your computer's regional settings.
	.PARAMETER UseParensForNegativeNumbers
	A value that indicates whether to enclose negative values ​​in parentheses.
	By default, it uses your computer's regional settings.
	.PARAMETER GroupDigits
	A value that represents whether numbers should be separated using the group delimiter specified in the regional properties.
	By default, it uses your computer's regional settings.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >FormatNumber -12345.6789
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[object]$Expression,
		[Parameter(Position = 1)]
		[int]$NumDigitsAfterDecimal = -1,
		[ValidateSet('False', 'True', 'UseDefault')]
		[Parameter(Position = 2)]
		[string]$IncludeLeadingDigit = 'UseDefault',
		[ValidateSet('False', 'True', 'UseDefault')]
		[Parameter(Position = 3)]
		[string]$UseParensForNegativeNumbers = 'UseDefault',
		[ValidateSet('False', 'True', 'UseDefault')]
		[Parameter(Position = 4)]
		[string]$GroupDigits = 'UseDefault'
	)

	try {
		try {
			return [Strings]::FormatNumber(
				$Expression,
				$NumDigitsAfterDecimal,
				[TriState]$IncludeLeadingDigit,
				[TriState]$UseParensForNegativeNumbers,
				[TriState]$GroupDigits
			)
		} catch [InvalidCastException] {
			throw [InvalidCastException]::new($_.ToString(), $_.Exception)
		}

	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function FormatPercent {
	<#
	.SYNOPSIS
	Format and return a string in percent format (multiplied by 100) with a percent sign (%) appended.
	.DESCRIPTION
	Format and return a string in percent format (multiplied by 100) with a percent sign (%) appended.
	.PARAMETER Expression
	Expression to convert format.
	.PARAMETER NumDigitsAfterDecimal
	A number representing the number of digits to display after the decimal point.
	The default is -1, which uses the value in Region Properties.
	.PARAMETER IncludeLeadingDigit
	A number representing whether to display zeros to the left of the decimal point.
	By default, it uses your computer's regional settings.
	.PARAMETER UseParensForNegativeNumbers
	A value that indicates whether to enclose negative values ​​in parentheses.
	By default, it uses your computer's regional settings.
	.PARAMETER GroupDigits
	A value that represents whether numbers should be separated using the group delimiter specified in the regional properties.
	By default, it uses your computer's regional settings.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >FormatPercent -0.567
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[object]$Expression,
		[Parameter(Position = 1)]
		[int]$NumDigitsAfterDecimal = -1,
		[ValidateSet('False', 'True', 'UseDefault')]
		[Parameter(Position = 2)]
		[string]$IncludeLeadingDigit = 'UseDefault',
		[ValidateSet('False', 'True', 'UseDefault')]
		[Parameter(Position = 3)]
		[string]$UseParensForNegativeNumbers = 'UseDefault',
		[ValidateSet('False', 'True', 'UseDefault')]
		[Parameter(Position = 4)]
		[string]$GroupDigits = 'UseDefault'
	)

	try {
		try {
			return [Strings]::FormatPercent(
				$Expression,
				$NumDigitsAfterDecimal,
				[TriState]$IncludeLeadingDigit,
				[TriState]$UseParensForNegativeNumbers,
				[TriState]$GroupDigits
			)
		} catch [InvalidCastException] {
			throw [InvalidCastException]::new($_.ToString(), $_.Exception)
		}

	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function InStr {
	<#
	.SYNOPSIS
	Searches for a specified string (String2) within a string (String1) and returns the character position of the first occurrence.
	.DESCRIPTION
	Searches for a specified string (String2) within a string (String1) and returns the character position of the first occurrence.
	The integer is the 1-based index if a match is found. If no match is found, the function returns 0.
	.PARAMETER String1
	A string to search for.
	.PARAMETER String2
	The string to search for in the argument String1.
	.PARAMETER Start
	An expression that sets the starting position for each search.
	If you omit the argument Start, it searches from the first character.
	.PARAMETER Compare
	A value that represents the mode of string comparison to use when evaluating string expressions.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >InStr AbcABCabc abc 3

	7
	.EXAMPLE
	PS >InStr AbcABCabc abc 3 Text

	4
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String1,
		[Parameter(Mandatory, Position = 1)][AllowEmptyString()]
		[string]$String2,
		[Parameter(Position = 2)]
		[ValidateRange(1, [int]::MaxValue)]
		[int]$Start = 1,
		[Parameter(Position = 3)]
		[ValidateSet('Binary', 'Text')]
		[string]$Compare = 'Binary'
	)

	return [Strings]::InStr($Start, $String1, $String2, [CompareMethod]$Compare)
}

function InStrRev {
	<#
	.SYNOPSIS
	Returns the first character position found in a string (String1) starting from the last character position for the specified string (String2).
	.DESCRIPTION
	Returns the first character position found in a string (String1) starting from the last character position for the specified string (String2).
	.PARAMETER String1
	A string to search for.
	.PARAMETER String2
	The string to search for in the argument String1.
	.PARAMETER Start
	An expression that sets the starting position for each search.
	If you omit the argument Start, -1 is used, starting the search from the last character position.
	.PARAMETER Compare
	A value that represents the mode of string comparison to use when evaluating string expressions.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >InStrRev AbcABCabc abc 3

	7
	.EXAMPLE
	PS >InStrRev AbcABCabc abc 3 Text

	1
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String1,
		[Parameter(Mandatory, Position = 1)][AllowEmptyString()]
		[string]$String2,
		[Parameter(Position = 2)]
		[ValidateScript(
			{
				if ($_ -eq -1 -or $_ -ge 1) { return $true }
				throw 'Enter a number -1 or greater than or equal to 1 .'
			}
		)]
		[int]$Start = -1,
		[Parameter(Position = 3)]
		[ValidateSet('Binary', 'Text')]
		[string]$Compare = 'Binary'
	)

	return [Strings]::InStrRev($String1, $String2, $Start, [CompareMethod]$Compare)
}

function Join {
	<#
	.SYNOPSIS
	Returns a string created by concatenating the internal strings of each element in the array.
	.DESCRIPTION
	Returns a string created by concatenating the internal strings of each element in the array.
	A zero-length string ("") or null concatenates all items in the list with no delimiter.
	.PARAMETER Array
	A one-dimensional array containing the substrings to concatenate.
	.PARAMETER Delimiter
	The string used to delimit the returned string.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >Join Foo, Bar, Baz

	Foo Bar Baz
	.EXAMPLE
	PS >Join Foo, Bar, Baz ', '

	Foo, Bar, Baz
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string[]]$Array,
		[Parameter(Position = 1)]
		[string]$Delimiter = ' '

	)

	return $Array -join $Delimiter
}

function LCase {
	<#
	.SYNOPSIS
	Convert uppercase letters to lowercase letters.
	.DESCRIPTION
	Convert uppercase letters to lowercase letters.
	Non-uppercase alphabetic characters are unaffected.
	.PARAMETER String
	Any string you want to convert uppercase to lowercase.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >LCase Foo

	foo
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String
	)

	return $String.ToLower()
}

function Left {
	<#
	.SYNOPSIS
	Returns a string with the specified number of characters from the left end of the string.
	.DESCRIPTION
	Returns a string with the specified number of characters from the left end of the string.
	If the Length argument is greater than or equal to the number of characters in the String argument, the entire string is returned.
	.PARAMETER String
	The original string expression from which the string is extracted.
	.PARAMETER Length
	The number of characters in the substring.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >Left FooBar 3

	Foo
	.EXAMPLE
	PS >Left FooBar 9

	FooBar
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String,
		[Parameter(Mandatory, Position = 1)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$Length
	)

	if ($Length -gt $String.Length) { return $String }
	return $String.Substring(0, $Length)
}

function Len {
	<#
	.SYNOPSIS
	Returns the number of characters in the specified string.
	.DESCRIPTION
	Returns the number of characters in the specified string.
	.PARAMETER String
	Any string for which you want to find the number of characters.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Len FooBar

	6
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String
	)

	return $String.Length
}

function LTrim {
	<#
	.SYNOPSIS
	Returns a string with leading whitespace characters removed from the specified string.
	.DESCRIPTION
	Returns a string with leading whitespace characters removed from the specified string.
	.PARAMETER String
	Any string from which you want to remove whitespace characters.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >LTrim "   FooBar"

	FooBar
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String
	)

	return $String.TrimStart()
}

function Mid {
	<#
	.SYNOPSIS
	Returns a string with the specified number of characters from a string.
	.DESCRIPTION
	Returns a string with the specified number of characters from a string.
	Returns an empty string of length 0 if the Start argument exceeds the number of characters in the String argument.
	If you omit the Length argument, or if there are fewer characters in the string than the Length argument, returns all characters after the Start argument.
	.PARAMETER String
	The original string expression from which the string is extracted.
	.PARAMETER Start
	The number of characters from the beginning of the argument String that specifies the position from which to extract the string, with 1 being the first position.
	.PARAMETER Length
	The number of characters to retrieve.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >Mid FooBar 2 3

	ooB
	.EXAMPLE
	PS >Mid FooBar 4

	Bar
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String,
		[Parameter(Mandatory, Position = 1)]
		[ValidateRange(1, [int]::MaxValue)]
		[int]$Start,
		[Parameter(Position = 2)]
		[ValidateRange(-1, [int]::MaxValue)]
		[int]$Length = -1
	)

	$startIndex = $Start - 1
	$resultLength = if ($Length -eq -1) { $String.Length - $startIndex } else { $Length }

	if ($startIndex -gt $String.Length) { return [string]::Empty }
	if (($startIndex + $resultLength) -gt $String.Length) { return $String.Substring($startIndex) }
	return $String.Substring($startIndex, $resultLength)
}


function Replace {
	<#
	.SYNOPSIS
	Returns a string in which part of a given string is replaced with another string a specified number of times.
	.DESCRIPTION
	Returns a string in which part of a given string is replaced with another string a specified number of times.
	.PARAMETER Expression
	A string expression containing the string to replace.
	.PARAMETER Find
	String to search for.
	.PARAMETER Replacement
	String to replace.
	.PARAMETER Start
	The position at which to start searching for the internal string in the argument Expression.
	.PARAMETER Count
	The number of strings to replace.
	If you omit this argument, it defaults to -1, which replaces all candidates.
	.PARAMETER Compare
	A value that represents the mode of string comparison to use when evaluating string expressions.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >Replace FooBar Bar Baz

	FooBaz
	.EXAMPLE
	PS >Replace FooBar o u 1 1

	FuoBar
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$Expression,
		[Parameter(Mandatory, Position = 1)][AllowEmptyString()]
		[string]$Find,
		[Parameter(Mandatory, Position = 2)][AllowEmptyString()]
		[string]$Replacement,
		[Parameter(Position = 3)]
		[ValidateRange(1, [int]::MaxValue)]
		[int]$Start = 1,
		[Parameter(Position = 4)]
		[ValidateRange(-1, [int]::MaxValue)]
		[int]$Count = -1,
		[Parameter(Position = 5)]
		[ValidateSet('Binary', 'Text')]
		[string]$Compare = 'Binary'
	)

	return [Strings]::Replace($Expression, $Find, $Replacement, $Start, $Count, $Compare)
}

function Right {
	<#
	.SYNOPSIS
	Returns a string with the specified number of characters from the right end of the string.
	.DESCRIPTION
	Returns a string with the specified number of characters from the rght end of the string.
	If the Length argument is greater than or equal to the number of characters in the String argument, the entire string is returned.
	.PARAMETER String
	The original string expression from which the string is extracted.
	.PARAMETER Length
	The number of characters in the substring.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >Right FooBar 3

	Bar
	.EXAMPLE
	PS >Right FooBar 9

	FooBar
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String,
		[Parameter(Mandatory, Position = 1)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$Length
	)

	if ($Length -gt $String.Length) { return $String }
	return $String.Substring($String.Length - $Length, $Length)
}

function RTrim {
	<#
	.SYNOPSIS
	Returns a string with trailing whitespace characters removed from the specified string.
	.DESCRIPTION
	Returns a string with trailing whitespace characters removed from the specified string.
	.PARAMETER String
	Any string from which you want to remove whitespace characters.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >RTrim "FooBar   "

	FooBar
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String
	)

	return $String.TrimEnd()
}

function Trim {
	<#
	.SYNOPSIS
	Returns a string with both leading and trailing whitespace characters removed from the specified string.
	.DESCRIPTION
	Returns a string with both leading and trailing whitespace characters removed from the specified string.
	.PARAMETER String
	Any string from which you want to remove whitespace characters.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >Trim "   FooBar   "

	FooBar
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String
	)

	return $String.Trim()
}

function Space {
	<#
	.SYNOPSIS
	Returns a string consisting of the specified number of spaces.
	.DESCRIPTION
	Returns a string consisting of the specified number of spaces.
	.PARAMETER Number
	Number of spaces.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >Space 5
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$Number
	)

	return ' ' * $Number
}

function Split {
	<#
	.SYNOPSIS
	Creates and returns a one-dimensional array from a string with each element delimited.
	.DESCRIPTION
	Creates and returns a one-dimensional array from a string with each element delimited.
	.PARAMETER Expression
	A string expression containing strings and delimiters.
	.PARAMETER Delimiter
	A character that identifies a string delimiter.
	If you omit the Delimiter argument, a space (" ") is used as the delimiter.
	.PARAMETER Count
	The number of elements in the array to return.
	Specifying -1 for this argument returns an array containing all strings.
	.PARAMETER Compare
	A value that represents the mode of string comparison to use when evaluating string expressions.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Split "foo bar baz"

	foo
	bar
	baz
	#>

	[CmdletBinding()]
	[OutputType([string[]])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$Expression,
		[Parameter(Position = 1)]
		[string]$Delimiter = ' ',
		[Parameter(Position = 2)]
		[ValidateScript(
			{
				if ($_ -eq -1 -or $_ -ge 1) { return $true }
				throw 'Enter a number -1 or greater than or equal to 1 .'
			}
		)]
		[int]$Count = -1,
		[Parameter(Position = 3)]
		[ValidateSet('Binary', 'Text')]
		[string]$Compare = 'Binary'
	)

	return [Strings]::Split($Expression, $Delimiter, $Count, [CompareMethod]$Compare)
}

function StrComp {
	<#
	.SYNOPSIS
	Returns a value representing the result of a string comparison.
	.DESCRIPTION
	Returns a value representing the result of a string comparison.
	Returns -1 if String1 is less than String2.
	Returns 0 if String1 and String2 are equal.
	Returns 1 if String1 is greater than String2.
	.PARAMETER Expression
	A string expression containing strings and delimiters.
	.PARAMETER Delimiter
	A character that identifies a string delimiter.
	If you omit the Delimiter argument, a space (" ") is used as the delimiter.
	.PARAMETER Count
	The number of elements in the array to return.
	Specifying -1 for this argument returns an array containing all strings.
	.PARAMETER Compare
	A value that represents the mode of string comparison to use when evaluating string expressions.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >StrComp ABC abc

	-1
	.EXAMPLE
	PS >StrComp abc ABC

	1
	.EXAMPLE
	PS >StrComp abc ABC Text

	0
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String1,
		[Parameter(Mandatory, Position = 1)][AllowEmptyString()]
		[string]$String2,
		[Parameter(Position = 2)]
		[ValidateSet('Binary', 'Text')]
		[string]$Compare = 'Binary'
	)

	return [Strings]::StrComp($String1, $String2, [CompareMethod]$Compare)
}

function String {
	<#
	.SYNOPSIS
	Returns a string with a specified number of iterations.
	.DESCRIPTION
	Returns a string with a specified number of iterations.
	.PARAMETER Number
	Specifies how many characters are to be arranged.
	.PARAMETER Character
	A character code or string expression for a character.
	Returns the value of the first character of this string repeated number times.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >String 5 A

	AAAAA
	.EXAMPLE
	PS >String 5 65

	AAAAA
	.EXAMPLE
	PS >String 5 ABC

	AAAAA
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[int]$Number,
		[Parameter(Mandatory, Position = 1)][ValidateNotNullOrEmpty()]
		$Character
	)

	if ($Character -is [int]) { $Character = Chr $Character }
	if ($Character -isnot [string]) { $Character = [string]$Character }

	return (Left $Character 1) * $Number
}

function StrReverse {
	<#
	.SYNOPSIS
	Returns a string with the characters in the specified string reversed.
	.DESCRIPTION
	Returns a string with the characters in the specified string reversed.
	.PARAMETER String
	A string whose characters are to be reversed.
	If you specify a 0-length string (""), a 0-length string is returned.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >StrReverse ABCDE

	EDCBA
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Position = 0)]
		[string]$String
	)

	return [Strings]::StrReverse($String)
}

function UCase {
	<#
	.SYNOPSIS
	Convert lowercase letters to uppercase letters.
	.DESCRIPTION
	Convert lowercase letters to uppercase letters.
	Non-lowercase alphabetic characters are unaffected.
	.PARAMETER String
	Any string you want to convert lowercase to uppercase.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >UCase Foo

	FOO
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$String
	)

	return $String.ToUpper()
}
