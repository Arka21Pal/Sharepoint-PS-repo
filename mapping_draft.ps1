# One-liner to find files, and put attributes into a csv file for access

Get-ChildItem -Recurse -Attributes !Directory | Select-Object -Property FullName, Name, @{Name='Description'; Expression={''}}, CreationTime, LastWriteTime, @{N='Owner';E={$_.GetAccessControl().Owner}} | Export-CSV <path_to_file.csv> -NoTypeInformation -NoClobber
