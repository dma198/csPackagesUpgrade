#
# Script search all *.csproj and update packages references to the latest versions taken from NuGet sources
#
get-childitem "." -recurse | where {$_.extension -eq ".csproj"} | % {
     $prj = $_.FullName
     $pkgs = Get-Content $prj | Select-String  -pattern "(<PackageReference Include\="")([A-Z,a-z,0-9,_,.]*)"			
     ForEach ($line in $($pkgs -split "`r`n"))
     {
       $res = $line -match '"[A-Z,a-z,0-9,_,.]+"'
       If($res)
       {	
          &dotnet add $prj package $matches[0]
       }
     }
}

