# Sharepoint-PS-repo
Contains scripts for Microsoft Sharepoint, Traversing regular NTFS and Networked (Samba) filesystems and supporting code/documentation

## Basic help

PowerShell works with objects, a substantial difference from POSIX Shell. POSIX Shell treats everything like a file.

Coming from scripting in Shell to PowerShell in a Windows environment, it takes a bit to get familiarised with using objects and their properties, which might be considered akin to other programming languages like Python/C. Having used it for a few hours, however, I'm starting to feel that PowerShell has hit a bit of a happy medium between the "everything is a file" mentality employed by POSIX shell versus OOPs concepts in languages like Python. Definitely, using objects opens up something similar to new dimensions of scripting, which will form the base of my attempts to learn PowerShell.

But, for that, we would need to know just what objects properties and methods are available from a command in Powershell. Microsoft happens to have this wonderful page on exactly this: [Get-Member](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member).

The way to use that would be: `<some command> | Get-Member`. To read the complete description available (and to avoid the behaviour of PowerShell where it redacts strings which do not fit the dimensions of your screen), use `<some command> | Get-Member | Format-List` (helpful: [Format-List](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/format-list))

To find a specific pattern of string (à la `grep`), use [Select-String](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-string).

Once you know the objects, properties and methods afforded by a particular command, you can use [Select-Object](https://learn.microsoft.com/en-gb/powershell/module/microsoft.powershell.utility/select-object) to use said objects, properties and methods. The website has great examples, but a simple method to use this `cmdlet` would be: `<some command> | Select-Object -Property <property1>, <property2>`

## Calculated properties

Made a separate section for these since they will often intermingle with other `cmdlets` to manipulate data/output. Link: [about_Calculated_Properties](https://learn.microsoft.com/en-gb/powershell/module/microsoft.powershell.core/about/about_calculated_properties).

[`@{}` is used to create a hashtable in Powershell](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables) \[related, [about_Arrays: `@()`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays)\].

If one looks at [Hashtable definitions](https://learn.microsoft.com/en-gb/powershell/module/microsoft.powershell.core/about/about_calculated_properties#hashtable-key-definitions), the first two points mention `name` and `expression`.

Here is an example of using calculated properties to manipulate output:
```
Get-ChildItem -Recurse -Attributes !Directory | Select-Object -Property FullName, Name, @{Name='Description'; Expression={''}}, CreationTime, LastWriteTime, @{Name='Owner';Expression={$_.GetAccessControl().Owner}} | Export-CSV <file-name>.csv -NoTypeInformation -NoClobber
```
(this happens to be the same command I used to map files and their details, like the path name, name of file, time of creation, time of last write and owner)

The calculated properties here are `@{Name='Description'; Expression={''}}` and `@{Name='Owner';Expression={$_.GetAccessControl().Owner}}` which would create an empty column called "Description" and another column called "Owner" with the value of the owner (using the `GetAccessControl()` method afforded by `Get-ChildItem`) for each file. Note that these properties use the same `name` and `expression` keys that we mention in the definition of Hashtables a few stanzas above.

Calculated properties allow one to store properties and manipulate them in an easier fashion than what would otherwise be possible. How would you insert a column in-between other columns in an `xlxs`/`csv` file? [Answer](https://stackoverflow.com/a/73948009). Here's the snippet:
```
$csv = Import-Csv -Path "attendees.csv" -Delimiter ';' 
$Properties = [Collections.Generic.List[Object]]$csv[0].psobject.properties.name
$Properties.Insert(1, @{ n='Guid'; e={ New-Guid } }) # insert at column #1
$csv |Select-Object -Property $Properties |Export-Csv new_attendees.csv' -NoTypeInformation
```

Notice how the calculated property is used to insert the column "Guid" right after the first column in the `attendees.csv` file using the `csv` variable.

## PSCustomObject

A very good datastructure to store information in Powershell.

[about_PSCustomObject](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pscustomobject) \
[Everything you wanted to know about PSCustomObject](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-pscustomobject)
