using namespace Microsoft.VisualBasic

function DateAdd {
	<#
	.SYNOPSIS
	Returns a value containing the date and time plus the specified time interval.
	.DESCRIPTION
	Returns a value containing the date and time plus the specified time interval.
	.PARAMETER Interval
	A value that represents the time interval to add.
	.PARAMETER Number
	A floating-point expression representing the time interval to add.
	This can be positive (to get date/time values ​​in the future) or negative (to get date/time values ​​in the past).
	.PARAMETER Date
	An expression representing the datetime to add the time interval to.
	.OUTPUTS
	System.DateTime
	.EXAMPLE
	PS >DateAdd Day 29 "01/31/2000 1:23:45"
	.EXAMPLE
	PS >DateAdd Minute -10 "01/31/2000 1:23:45"
	#>

	[CmdletBinding()]
	[OutputType([datetime])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[ValidateSet('Year', 'Quarter', 'Month', 'DayOfYear', 'Day', 'WeekOfYear', 'Weekday', 'Hour', 'Minute', 'Second')]
		[string]$Interval,
		[Parameter(Mandatory, Position = 1)]
		[double]$Number,
		[Parameter(Mandatory, Position = 2)]
		[datetime]$Date
	)

	try {
		return [DateAndTime]::DateAdd([DateInterval]$Interval, $Number, $Date)
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function DateDiff {
	<#
	.SYNOPSIS
	Returns the time interval between two given dates.
	.DESCRIPTION
	Returns the time interval between two given dates.
	For example, you can find the number of days between two dates, or the number of weeks between now and the end of the year.
	Returns a negative number if the Date1 argument is later than the Date2 argument.
	.PARAMETER Interval
	A value that represents the time interval unit for calculating the interval between the $Date1 and $Date2 arguments.
	.PARAMETER Date1
	The first date/time value to use in calculations.
	.PARAMETER Date2
	The second date/time value to use in calculations.
	.PARAMETER FirstDayOfWeek
	Specifies a value that represents the first day of the week.
	If omitted, Sunday is specified.
	.PARAMETER FirstWeekOfYear
	Specifies a value that represents the first week of the year.
	If omitted, the week containing January 1 is designated as week 1.
	.OUTPUTS
	System.Int64
	.EXAMPLE
	PS >DateDiff Year 12/31/2000 01/01/2001

	1
	.EXAMPLE
	PS >DateDiff Day 6/21/2020 5/31/2020

	-21
	#>

	[CmdletBinding()]
	[OutputType([long])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[ValidateSet('Year', 'Quarter', 'Month', 'DayOfYear', 'Day', 'WeekOfYear', 'Weekday', 'Hour', 'Minute', 'Second')]
		[string]$Interval,
		[Parameter(Mandatory, Position = 1)]
		[datetime]$Date1,
		[Parameter(Mandatory, Position = 2)]
		[datetime]$Date2,
		[Parameter(Position = 3)]
		[ValidateSet('System', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')]
		[string]$FirstDayOfWeek = 'Sunday',
		[Parameter(Position = 4)]
		[ValidateSet('System', 'Jan1', 'FirstFourDays', 'FirstFullWeek')]
		[string]$FirstWeekOfYear = 'Jan1'
	)

	try {
		return [DateAndTime]::DateDiff(
			[DateInterval]$Interval, $Date1, $Date2,
			[FirstDayOfWeek]$FirstDayOfWeek, [FirstWeekOfYear]$FirstWeekOfYear
		)
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function DatePart {
	<#
	.SYNOPSIS
	Returns part of the specified date.
	.DESCRIPTION
	Returns part of the specified date.
	You can evaluate the date and get the specific time interval part.
	For example, you can calculate the day of the week, the current time, and so on.
	.PARAMETER Interval
	A string expression that represents the units for the time interval.
	.PARAMETER Date
	Specifies the date to evaluate.
	.PARAMETER FirstDayOfWeek
	Specifies a value that represents the first day of the week.
	If omitted, Sunday is specified.
	.PARAMETER FirstWeekOfYear
	Specifies a value that represents the first week of the year.
	If omitted, the week containing January 1 is designated as week 1.
	.OUTPUTS
	System.Int64
	.EXAMPLE
	PS >$now = Get-Date
	PS >DatePart Quarter $now
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[ValidateSet('Year', 'Quarter', 'Month', 'DayOfYear', 'Day', 'WeekOfYear', 'Weekday', 'Hour', 'Minute', 'Second')]
		[string]$Interval,
		[Parameter(Mandatory, Position = 1)]
		[datetime]$Date,
		[Parameter(Position = 2)]
		[ValidateSet('System', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')]
		[string]$FirstDayOfWeek = 'Sunday',
		[Parameter(Position = 3)]
		[ValidateSet('System', 'Jan1', 'FirstFourDays', 'FirstFullWeek')]
		[string]$FirstWeekOfYear = 'Jan1'
	)

	try {
		return [DateAndTime]::DatePart(
			[DateInterval]$Interval, $Date,
			[FirstDayOfWeek]$FirstDayOfWeek, [FirstWeekOfYear]$FirstWeekOfYear
		)
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function DateSerial {
	<#
	.SYNOPSIS
	Returns a value corresponding to the year, month, and day specified in the arguments.
	.DESCRIPTION
	Returns a value corresponding to the year, month, and day specified in the arguments.
	.PARAMETER Year
	A number from 100 through 9999 representing the year.
	If you specify a number is  0 through 99, it will be interpreted as being between 1930 and 2029.
	To specify a number outside that range for the year argument, specify a full four-digit number (for example, 1800).
	.PARAMETER Month
	A number from 1 through 12 representing the month.
	If you specify an out-of-range value, the Month value is offset by 1 and then added to January of the year being calculated.
	.PARAMETER Day
	A number from 1 through 31 representing the day.
	If the specified values ​​are not in the correct range, the specified values ​​are added according to the arguments.
	For example, specifying 35 will be treated as extra days in the specified month and the following month, depending on the specified year and month.
	.OUTPUTS
	System.DateTime
	.EXAMPLE
	PS >DateSerial 2012 3 4
	.EXAMPLE
	PS >DateSerial 23 -4 56
	#>

	[CmdletBinding()]
	[OutputType([datetime])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[int]$Year,
		[Parameter(Mandatory, Position = 1)]
		[int]$Month,
		[Parameter(Mandatory, Position = 2)]
		[int]$Day
	)

	try {
		return [DateAndTime]::DateSerial($Year, $Month, $Day)
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function DateValue {
	<#
	.SYNOPSIS
	Returns a Date value containing the date information represented as a string.
	.DESCRIPTION
	Returns a Date value containing the date information represented as a string.
	If the Date argument contains a time value, this function does not include that time in the return value.
	However, an error occurs if the Date argument specifies an invalid time (for example, "89:98").
	If the Date argument specifies an abbreviated year, this function uses the current year from the system date.
	.PARAMETER Data
	String expression representing a date/time value from 00:00:00 on January 1 of the year 1 through 23:59:59 on December 31, 9999.
	.OUTPUTS
	System.DateTime
	.EXAMPLE
	PS >DateValue "September 11, 1963"
	#>

	[CmdletBinding()]
	[OutputType([datetime])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[string]$Data
	)

	try {
		return (CDate $Data -ErrorAction Stop).Date
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function Day {
	<#
	.SYNOPSIS
	Returns an integer in the range 1 to 31 representing the day of the month.
	.DESCRIPTION
	Returns an integer in the range 1 to 31 representing the day of the month.
	.PARAMETER Date
	A value that represents a date.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Day 12/25/2023

	25
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[datetime]$Date
	)

	return $Date.Day
}

function Hour {
	<#
	.SYNOPSIS
	Returns an integer in the range 0-23 representing the hour of the day.
	.DESCRIPTION
	Returns an integer in the range 0-23 representing the hour of the day.
	.PARAMETER Date
	A value that represents a date.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Hour 11:22:33

	11
	.EXAMPLE
	PS >Hour '11:22:33 PM'

	23
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[datetime]$Date
	)

	return $Date.Hour
}

function Minute {
	<#
	.SYNOPSIS
	Returns an integer in the range 0-59 representing the minute of the hour.
	.DESCRIPTION
	Returns an integer in the range 0-59 representing the minute of the hour.
	.PARAMETER Date
	A value that represents a date.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Minute 11:22:33

	22
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[datetime]$Date
	)

	return $Date.Minute
}

function Month {
	<#
	.SYNOPSIS
	Returns an integer in the range 1-12 representing the month of the year.
	.DESCRIPTION
	Returns an integer in the range 1-12 representing the month of the year.
	.PARAMETER Date
	A value that represents a date.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Month 1/2/2003

	1
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[datetime]$Date
	)

	return $Date.Month
}

function MonthName {
	<#
	.SYNOPSIS
	Returns a string representing the specified month.
	.DESCRIPTION
	Returns a string representing the specified month.
	.PARAMETER Month
	A number indicating the month.
	For example, January is 1 and February is 2.
	.PARAMETER Abbreviate
	Specifies whether to abbreviate month names.
	If omitted, the default of False is used and month name is not truncated.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >MonthName 10

	October
	.EXAMPLE
	PS >MonthName 10 -Abbreviate

	Oct
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[ValidateRange(1, 12)]
		[int]$Month,
		[switch]$Abbreviate
	)

	$date = [datetime]::new(2000, $Month, 1)
	$format = if ($Abbreviate) { 'MMM' } else { 'MMMM' }

	return $date.ToString($format)
}

function Second {
	<#
	.SYNOPSIS
	Returns an integer between 0 and 59 representing the second of the hour.
	.DESCRIPTION
	Returns an integer between 0 and 59 representing the second of the hour.
	.PARAMETER Date
	A value that represents a date.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Second 11:22:33

	33
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[datetime]$Date
	)

	return $Date.Second
}

function Timer {
	<#
	.SYNOPSIS
	Returns the number of seconds that have passed since midnight.
	.DESCRIPTION
	Returns the number of seconds that have passed since midnight.
	.OUTPUTS
	System.Double
	.EXAMPLE
	PS >Timer
	#>

	[CmdletBinding()]
	[OutputType([double])]
	param ()

	return (Get-Date).TimeOfDay.TotalSeconds
}

function TimeSerial {
	<#
	.SYNOPSIS
	Returns a time value corresponding to the hour, minute, and second specified in the arguments.
	.DESCRIPTION
	Returns a time value corresponding to the hour, minute, and second specified in the arguments.
	.PARAMETER Hour
	A number representing the hour between 0 (12:00 AM) and 23 (11:00 PM).
	However, values ​​outside this range are also accepted.
	.PARAMETER Minute
	A number from 0 to 59.
	When calculated, the value of Minute is added, so specifying a negative value specifies a number of minutes before that hour.
	.PARAMETER Second
	A number from 0 to 59.
	The value of Second is added to the calculated minute, so a negative value specifies the number of seconds before that minute.
	.OUTPUTS
	System.DateTime
	.EXAMPLE
	PS >TimeSerial 1 23 45
	.EXAMPLE
	PS >TimeSerial 1 -23 45
	#>

	[CmdletBinding()]
	[OutputType([datetime])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[int]$Hour,
		[Parameter(Mandatory, Position = 1)]
		[int]$Minute,
		[Parameter(Mandatory, Position = 2)]
		[int]$Second
	)

	try {
		return [DateAndTime]::TimeSerial($Hour, $Minute, $Second)
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function TimeValue {
	<#
	.SYNOPSIS
	Returns a Date value containing the time information represented as a string.
	.DESCRIPTION
	Returns a Date value containing the time information represented as a string.
	If the argument contains date information, it will not be included in the returned value.
	However, if it contains invalid date information, such as "January 32nd", you will get an InvalidCastException error.
	.PARAMETER Time
	String expression representing a date/time value from 00:00:00 on January 1 of the year 1 through 23:59:59 on December 31, 9999.
	You can specify the time in either 12-hour or 24-hour format. For example, "2:24PM" and "14:24" are both valid arguments.
	.OUTPUTS
	System.DateTime
	.EXAMPLE
	PS >TimeValue "12:34:56"
	#>

	[CmdletBinding()]
	[OutputType([datetime])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[string]$Time
	)

	try {
		return [DateAndTime]::TimeValue($Time)
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

function Weekday {
	<#
	.SYNOPSIS
	Returns a value between 1 (Sunday) and 7 (Saturday) representing the day of the week.
	.DESCRIPTION
	Returns a value between 1 (Sunday) and 7 (Saturday) representing the day of the week.
	.PARAMETER Date
	The date for which you want to find the day of the week.
	.PARAMETER FirstDayOfWeek
	A constant representing the first day of the week.
	If you omit this value, Sunday is used.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Weekday "1/23/2045"

	2
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[datetime]$Date,
		[Parameter(Position = 1)]
		[ValidateSet('System', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')]
		[string]$FirstDayOfWeek = 'Sunday'
	)

	return [DateAndTime]::Weekday($Date, [FirstDayOfWeek]$FirstDayOfWeek)
}

function WeekdayName {
	<#
	.SYNOPSIS
	Returns a string representing the specified day of the week.
	.DESCRIPTION
	Returns a string representing the specified day of the week.
	.PARAMETER Weekday
	A number from 1 to 7 specifying the day of the week.
	1 represents the first day of the week and 7 represents the last day of the week.
	The first and last day of the week is determined by setting the FirstDayOfWeekValue argument.
	.PARAMETER FirstDayOfWeek
	A constant representing the first day of the week.
	If you omit this value, Sunday is used.
	.PARAMETER Abbreviate
	Specifies whether to abbreviate weekday names.
	If omitted, day names are not  abbreviated.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >WeekdayName 6

	Friday
	.EXAMPLE
	PS >WeekdayName 6 -Abbreviate

	Fri
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[ValidateRange(1, 7)]
		[int]$Weekday,
		[Parameter(Position = 1)]
		[ValidateSet('System', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')]
		[string]$FirstDayOfWeek = 'Sunday',
		[switch]$Abbreviate
	)

	return [DateAndTime]::WeekdayName($Weekday, [bool]$Abbreviate, [FirstDayOfWeek]$FirstDayOfWeek)
}

function Year {
	<#
	.SYNOPSIS
	Returns an integer representing the year.
	.DESCRIPTION
	Returns an integer representing the year.
	.PARAMETER Date
	A value that represents a date.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >Year 1/2/2003

	2003
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param (
		[Parameter(Mandatory, Position = 0)]
		[datetime]$Date
	)

	return $Date.Year
}

New-Alias Now Get-Date
