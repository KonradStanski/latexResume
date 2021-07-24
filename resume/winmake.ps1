# set filename
$outname = "EditThisInWinmake"

# find the path to the desktop folder:
Set-Location ./src
$src = Get-Location

# specify the path to the folder you want to monitor:
$Path = $src

# specify which files you want to monitor
$FileFilter = '*'  

# specify whether you want to monitor subfolders as well:
$IncludeSubfolders = $false

# specify the file or folder properties you want to monitor:
$AttributeFilter = [IO.NotifyFilters]::FileName, [IO.NotifyFilters]::LastWrite 

# specify the type of changes you want to monitor:
$ChangeTypes = [System.IO.WatcherChangeTypes]::Changed

# specify the maximum time (in milliseconds) you want to wait for changes:
$Timeout = 1000

# define a function that gets called for every change:
function Compile-Pdf {
    param
    (
        [Parameter(Mandatory)]
        [System.IO.WaitForChangedResult]
        $ChangeInformation
    )
  
    Write-Warning 'Change detected:'
    $ChangeInformation | Out-String | Write-Host -ForegroundColor DarkYellow
    pdflatex -jobname=($outname) -halt-on-error resume.tex
    Remove-Item -Path ./* -include *.aux, *.bcf, *.log, *.out, *.xml


}

# use a try...finally construct to release the
# filesystemwatcher once the loop is aborted
# by pressing CTRL+C

try {
    Write-Warning "FileSystemWatcher is monitoring $Path"
  
    # create a filesystemwatcher object
    $watcher = New-Object -TypeName IO.FileSystemWatcher -ArgumentList $Path, $FileFilter -Property @{
        IncludeSubdirectories = $IncludeSubfolders
        NotifyFilter          = $AttributeFilter
    }

    # start monitoring manually in a loop:
    do {
        # wait for changes for the specified timeout
        # IMPORTANT: while the watcher is active, PowerShell cannot be stopped
        # so it is recommended to use a timeout of 1000ms and repeat the
        # monitoring in a loop. This way, you have the chance to abort the
        # script every second.
        $result = $watcher.WaitForChanged($ChangeTypes, $Timeout)
        # if there was a timeout, continue monitoring:
        if ($result.TimedOut) { continue }
    
        Compile-Pdf -Change $result
        # the loop runs forever until you hit CTRL+C    
    } while ($true)
}
finally {
    # release the watcher and free its memory:
    $watcher.Dispose()
    Write-Warning 'FileSystemWatcher removed.'
    Set-Location ..
}
