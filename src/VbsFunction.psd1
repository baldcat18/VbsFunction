﻿@{
	ModuleVersion = '1.0.0'
	GUID = '090d8783-09e0-4f9b-89c8-8885c3bdf10a'
	Author = 'BaldCat'
	Copyright = '(c) 2022 BaldCat. All rights reserved.'
	Description = 'This module emulates functions in VBScript.'
	PowerShellVersion = '5.1'
	CompatiblePSEditions = @('Core', 'Desktop')
	NestedModules = @(
		'Common.psm1'
		'Conversion.psm1'
		'Date.psm1'
		'Interaction.psm1'
		'Math.psm1'
		'Object.psm1'
		'String.psm1'
		'System.psm1'
	)
	FunctionsToExport = @(
		# Conversion
		'CBool'
		'CByte'
		'CDate'
		'CDbl'
		'CInt'
		'CLng'
		'CSng'
		'CStr'
		'Hex'
		'Oct'
		# Date
		'DateAdd'
		'DateDiff'
		'DatePart'
		'DateSerial'
		'DateValue'
		'Day'
		'Hour'
		'Minute'
		'Month'
		'MonthName'
		'Second'
		'Timer'
		'TimeSerial'
		'TimeValue'
		'Weekday'
		'WeekdayName'
		'Year'
		# Interaction
		'InputBox'
		'MsgBox'
		# Math
		'Abs'
		'Atn'
		'Cos'
		'Exp'
		'Fix'
		'Int'
		'Log'
		'Randomize'
		'Rnd'
		'Round'
		'Sgn'
		'Sin'
		'Sqr'
		'Tan'
		# Object
		'Array'
		'CreateObject'
		'GetObject'
		'GetRef'
		'IsArray'
		'IsDate'
		'IsNull'
		'IsNumeric'
		'IsObject'
		'LBound'
		'RGB'
		'TypeName'
		'UBound'
		'VarType'
		# String
		'Asc'
		'AscB'
		'AscW'
		'Chr'
		'ChrW'
		'VbFilter'
		'FormatCurrency'
		'FormatDateTime'
		'FormatNumber'
		'FormatPercent'
		'InStr'
		'InStrRev'
		'Join'
		'LCase'
		'Left'
		'Len'
		'LTrim'
		'Mid'
		'Replace'
		'Right'
		'RTrim'
		'Trim'
		'Space'
		'Split'
		'StrComp'
		'String'
		'StrReverse'
		'UCase'
		# System
		'GetLocale'
		'ScriptEngine'
		'ScriptEngineBuildVersion'
		'ScriptEngineMajorVersion'
		'ScriptEngineMinorVersion'
	)
	AliasesToExport = @(
		# Date
		'Now'
		# Interaction
		'Eval'
	)
	PrivateData = @{
		PSData = @{
			Tags = @('VBScript', 'Windows')
		}
	}
}