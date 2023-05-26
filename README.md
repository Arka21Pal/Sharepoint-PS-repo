# Sharepoint-PS-repo
Contains scripts for Microsoft Sharepoint, Traversing regular NTFS and Networked (Samba) filesystems and supporting code/documentation

## Basic help

Powershell works with objects, a substantial difference from POSIX Shell. POSIX Shell treats everything like a file.

Coming from scripting in Shell to Powershell in a Windows environment, it is a bit strange to get familiarised with using objects and their properties, which might be considered akin to other programming languages like Python/C. Having used Powershell, I'm starting to feel that Powershell has hit a bit of a happy medium between the "everything is a file" mentality employed by POSIX shell versus programming languages like Python. Definitely, using objects opens up something similar to new dimensions of scripting, which will form the base of my attempts to learn Powershell.

But, for that, we would need to know just what objects properties and methods are available from a command in Powershell. Microsoft happens to have this wonderful page on exactly this: [Get-Member](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member).

The way to use that would be: `<some command> | Get-Member`. To read the complete description available (and to avoid the behaviour of Powershell to redact strings which do not fit the dimensions of your screen), use `<some command> | Get-Member | Format-List` (helpful: [Format-List](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/format-list))

To find a specific pattern of string (à la `grep`), use [Select-String](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-string).

Once you know the objects, properties and methods afforded by a particular command, you can use [Select-Object](https://learn.microsoft.com/en-gb/powershell/module/microsoft.powershell.utility/select-object) to use said objects, properties and methods. The website has great examples, but a simple method to use this `cmdlet` would be: `<some command> | Select-Object -Property <property1>, <property2>`
