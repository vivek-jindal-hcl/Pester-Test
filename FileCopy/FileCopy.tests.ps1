# this is a sample pester module for FileCopy.psm1
Describe "Copy-BYFile" {

    # it performs the copy when source file does exist
    Context "When source file exists" {
        $SourceFile = Join-Path -Path $PSScriptRoot -ChildPath "by.txt"
        $DestinationFile = Join-Path -Path $PSScriptRoot -ChildPath "by_copy.txt"

        # create a source test file
        BeforeAll {
            Write-Host "Creating test file..."
            New-Item -Path $SourceFile -ItemType File
        }

        # clean up the test files
        AfterAll {
            Write-Host "Cleaning up test files..."
            Remove-Item -Path $SourceFile -Force
            Remove-Item -Path $DestinationFile -Force
        }

        # run the copy test
        It "Copies the file" {
            Write-Host "Executing Copy-BYFile command using test values..."
            Copy-BYFile -SourcePath $SourceFile -DestinationPath $DestinationFile
            $FileCopiedResult = Test-Path -Path $DestinationFile -PathType Leaf
            $FileCopiedResult | Should -Be $True
        }
    }

    # it thorws an error when file is invalid or doesn't exist
    Context "When source file does not exist" {
        $SourceFile = Join-Path -Path $PSScriptRoot -ChildPath "by.txt"
        $DestinationFile = Join-Path -Path $PSScriptRoot -ChildPath "by_copy.txt"

        It "Throws an error" {
            { Copy-BYFile -SourcePath $SourceFile -DestinationPath $DestinationFile } | Should -Throw
        }
    }

}
