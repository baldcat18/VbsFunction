function GetLocale {
	<#
	.SYNOPSIS
	Returns the current locale ID value.
	.DESCRIPTION
	Returns the current locale ID value.
	A locale contains a variety of per-user settings related to language, country/region, and cultural conventions.
	Keyboard layout, character ordering, and date, time, number, and currency formats are determined by this locale.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >GetLocale
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param()

	return (Get-WinSystemLocale).LCID
}

function ScriptEngine {
	<#
	.SYNOPSIS
	Returns a string representing the scripting language in use.
	.DESCRIPTION
	Returns a string representing the scripting language in use.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >ScriptEngine
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param ()

	return 'PowerShell'
}

function ScriptEngineBuildVersion {
	<#
	.SYNOPSIS
	Returns the build version number of the scripting engine in use.
	.DESCRIPTION
	Returns the build version number of the scripting engine in use.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >ScriptEngineBuildVersion
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param ()

	# PowerShell CoreだとPSVersionはSemanticVersion型なので
	# Versionに変換してからビルド番号を取得している
	return ([Version]$PSVersionTable['PSVersion']).Build
}

function ScriptEngineMajorVersion {
	<#
	.SYNOPSIS
	Returns the major version number of the scripting engine in use.
	.DESCRIPTION
	Returns the major version number of the scripting engine in use.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >ScriptEngineMajorVersion
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param ()

	return $PSVersionTable['PSVersion'].Major
}

function ScriptEngineMinorVersion {
	<#
	.SYNOPSIS
	Returns the minor version number of the scripting engine in use.
	.DESCRIPTION
	Returns the minor version number of the scripting engine in use.
	.OUTPUTS
	System.Int32
	.EXAMPLE
	PS >ScriptEngineMinorVersion
	#>

	[CmdletBinding()]
	[OutputType([int])]
	param ()

	# PowerShell CoreだとPSVersionはSemanticVersion型なので
	# Versionに変換してからビルド番号を取得している
	return $PSVersionTable['PSVersion'].Minor
}
