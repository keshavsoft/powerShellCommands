function Ensure-BaseFolder {
    param (
        $inBaseFolder
    )

    if (!(Test-Path $inBaseFolder)) {

        New-Item -ItemType Directory -Path $inBaseFolder | Out-Null
    }
};
