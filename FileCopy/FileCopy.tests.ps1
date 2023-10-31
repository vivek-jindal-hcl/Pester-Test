# this is a sample pester module for FileCopy.psm1
Describe "Copy-BYFile" {

    # it performs the copy when source file does exist
    Context "When source file exists" {

        # create a source test file
        BeforeAll {
            $SourceFile = Join-Path -Path $PSScriptRoot -ChildPath "by.txt"
            $DestinationFile = Join-Path -Path $PSScriptRoot -ChildPath "by_copy.txt"
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

    # it thorws an error when file is doesn't exist
    Context "When source file does not exist" {

        # run the copy test
        It "Throws an error" {
            $SourceFile = Join-Path -Path $PSScriptRoot -ChildPath "by.txt"
            $DestinationFile = Join-Path -Path $PSScriptRoot -ChildPath "by_copy.txt"
            Write-Host "Executing Copy-BYFile command using test values..."
            { Copy-BYFile -SourcePath $SourceFile -DestinationPath $DestinationFile } | Should -Throw
        }

    }

    # it throws an error when source is not a valid file
    Context "When source is not a valid file" {

        # create a source test file
        BeforeAll {
            $SourceFile = Join-Path -Path $PSScriptRoot -ChildPath "by.txt"
            $DestinationFile = Join-Path -Path $PSScriptRoot -ChildPath "by_copy.txt"
            Write-Host "Creating invalid file..."
            New-Item -Path $SourceFile -ItemType Directory
        }

        # clean up the test files
        AfterAll {
            Write-Host "Cleaning up test files..."
            Remove-Item -Path $SourceFile -Force
            Remove-Item -Path $DestinationFile -Force -ErrorAction SilentlyContinue
        }

        # run the copy test
        It "Throws an error" {
            Write-Host "Executing Copy-BYFile command using test values..."
            { Copy-BYFile -SourcePath $SourceFile -DestinationPath $DestinationFile } | Should -Throw
        }

    }

    # it does not throw an error when destination file already exists
    Context "When destination file already exists" {

        # create source and destination test files
        BeforeAll {
            $SourceFile = Join-Path -Path $PSScriptRoot -ChildPath "by.txt"
            $DestinationFile = Join-Path -Path $PSScriptRoot -ChildPath "by_copy.txt"
            Write-Host "Creating test files..."
            New-Item -Path $SourceFile -ItemType File
            New-Item -Path $DestinationFile -ItemType File
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

}
