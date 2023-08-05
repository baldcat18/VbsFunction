using namespace Microsoft.VisualBasic

Add-Type -AssemblyName Microsoft.VisualBasic

[Flags()]
enum MsgBoxStyle {
	OkOnly = 0
	OkCancel = 1
	AbortRetryIgnore = 2
	YesNoCancel = 3
	YesNo = 4
	RetryCancel = 5
	Critical = 16
	Question = 32
	Exclamation = 48
	Information = 64
	DefaultButton1 = 0
	DefaultButton2 = 256
	DefaultButton3 = 512
	ApplicationModal = 0
	SystemModal = 4096
}

function InputBox {
	<#
	.SYNOPSIS
	Display a message and a text box in a dialog box.
	Returns the contents of a text box when text is entered or a button is clicked.
	.DESCRIPTION
	Display a message and a text box in a dialog box.
	Returns the contents of a text box when text is entered or a button is clicked.
	If the user clicks Cancel, a 0-length string is returned.
	.PARAMETER Prompt
	A string expression that specifies the string to display as a message in the dialog box.
	The maximum number of characters that can be specified for the argument prompt is approximately 1,024 single-byte characters.
	However, it depends on the character width of the characters used.
	.PARAMETER Title
	A string to display in the title bar of the dialog box.
	.PARAMETER Default
	A string to display as the default value in the text box if the user does not enter anything.
	If you omit the default argument, the text box will display nothing.
	.PARAMETER XPos
	A number that indicates the horizontal distance, in twips, from the left edge of the screen to the left edge of the dialog box.
	If you omit the xpos argument, the dialog box is horizontally centered on the screen.
	.PARAMETER YPos
	A number that indicates the vertical distance, in twips, from the top edge of the screen to the top edge of the dialog box.
	If you omit the ypos argument, the dialog box is vertically positioned approximately 1/3 from the top of the screen.
	.OUTPUTS
	System.String
	.EXAMPLE
	PS >InputBox "Please enter your name."
	#>

	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$Prompt,
		[Parameter(Position = 1)]
		[string]$Title = '',
		[Parameter(Position = 2)]
		[string]$Default = '',
		[Parameter(Position = 3)]
		[int]$XPos = -1,
		[Parameter(Position = 4)]
		[int]$YPos = -1
	)


	return [Interaction]::InputBox($Prompt, $Title, $Default, $XPos, $YPos)
}

function MsgBox {
	<#
	.SYNOPSIS
	Displays a message in a dialog box, waits for the user to click a button, and then returns a value indicating which button the user clicked.
	.DESCRIPTION
	Displays a message in a dialog box, waits for the user to click a button, and then returns a value indicating which button the user clicked.
	.PARAMETER Prompt
	A string expression that specifies the string to display as a message in the dialog box.
	The maximum number of characters that can be specified for the argument prompt is approximately 1,024 single-byte characters.
	However, it depends on the character width of the characters used.
	To specify multiple lines, place a carriage return (Chr(13)), line feed (Chr(10)), or a combination of carriage return and line feed (Chr(13) & Chr(10)) where you want a line break.
	.PARAMETER Buttons
	An expression that represents the sum of values ​​representing the type and number of buttons to be displayed, the style of icon to use, standard buttons, whether the message box is modal, and so on.
	.PARAMETER Title
	A string to display in the title bar of the dialog box.
	If you omit the Title argument, the title bar displays the application name.
	.OUTPUTS
	Microsoft.VisualBasic.MsgBoxResult
		A value that represents the button selected by the user.
	.EXAMPLE
	PS >MsgBox "Choose any one button." "YesNoCancel, Question, DefaultButton3, SystemModal" "Sample"
	#>

	[CmdletBinding()]
	[OutputType([Microsoft.VisualBasic.MsgBoxResult])]
	param (
		[Parameter(Mandatory, Position = 0)][AllowEmptyString()]
		[string]$Prompt,
		[Parameter(Position = 1)]
		[MsgBoxStyle]$Buttons = 0,
		[Parameter(Position = 2)]
		[string]$Title
	)

	try {
		if ($null -eq $Title) { return [Interaction]::MsgBox($Prompt, $Buttons) }
		return [Interaction]::MsgBox($Prompt, $Buttons, $Title)
	} catch {
		$PSCmdlet.WriteError($PSItem)
	}
}

New-Alias Eval Invoke-Expression
