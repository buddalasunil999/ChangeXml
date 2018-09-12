Param
(
    [Parameter(Mandatory=$true)]
    [string]$SourcePath,
    [Parameter(Mandatory=$true)]
    [string]$XPath,
    [Parameter(Mandatory=$true)]
    [string]$Value
)

function Write-Log([string] $message)
{
    Write-Verbose "$message" -Verbose
}

function Change-Config($path, $xpath, $value)
{    
	[xml]$xml = Get-Content $path
	$nodes = $xml.SelectNodes($xpath)
	
	foreach ($node in $nodes) {
            if ($node -ne $null) {
                if ($node.NodeType -eq "Element") {
                    $node.InnerXml = $value
                }
                else {
                    $node.Value = $value
                }
            }
        }
	
	$xml.save($path)
}

Write-Log "SourcePath: $SourcePath"
Write-Log "XPath: $XPath"
Write-Log "Value: $Value"
Write-Log "Changing File"
Change-Config $SourcePath $XPath $Value