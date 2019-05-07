$PesterTestResultsFile = ".\TestsResults.xml"
$Pester = Invoke-Pester -OutputFormat NUnitXml -OutputFile $PesterTestResultsFile -PassThru
$WebClient = New-Object "System.Net.WebClient"
$PesterTestResultsFilePath = Resolve-Path -Path $PesterTestResultsFile
$WebClient.UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", $PesterTestResultsFilePath)

If ($Pester.FailedCount -Gt 0) {
    Throw "$(${Pester}.FailedCount) tests failed."
}
