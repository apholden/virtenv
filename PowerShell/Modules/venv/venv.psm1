function New-Venv
{
    if (Test-Path -Path "./.venv")
    {
        $overwrite = Read-Host "Environment already exists.  Do you want to replace it?"
        if (($overwrite -ne "y") -and ($overwrite -ne "Y"))
        {
            return
        }
        
        if (Test-Path -Path function:deactivate)
        {
            Write-Host "Exiting current environment."
            deactivate    
        }
        
        Write-Host "Removing existing environment."
        Remove-Item -Recurse .venv
    }
    elseif (Test-Path -Path function:deactivate)
    {
        Write-Host "Exiting current environment."
        deactivate    
    }

    Write-Host "Creating environment."
    python -m venv .venv --upgrade-deps
    
    Write-Host "Entering environment."
    .\.venv\Scripts\Activate.ps1
    
    pip install --upgrade wheel
    
    if (Test-Path -Path "requirements.txt")
    {
        Write-Host "Installing modules."
        pip install -r requirements.txt
    }
}


function Remove-Venv
{
    if (-not (Test-Path -Path "./.venv"))
    {
        Write-Host "No environment found."
        return
    }
    
    if (Test-Path -Path function:deactivate)
    {
        Write-Host "Exiting current environment."
        deactivate    
    }
    
    Write-Host "Removing environment."
    Remove-Item -Recurse .venv
}


function Enter-Venv
{
    if (-not (Test-Path -Path "./.venv"))
    {
        Write-Host "No environment found."
        return
    }
    
    if (Test-Path -Path function:deactivate)
    {
        Write-Host "Exiting current environment."
        deactivate    
    }
    
    Write-Host "Entering environment."
    .\.venv\Scripts\Activate.ps1
}


function Exit-Venv
{
    if (Test-Path -Path function:deactivate)
    {
        Write-Host "Exiting environment."
        deactivate    
    }
    else
    {
        Write-Host "Not in an environment."
    }    
}