@{
    # Used by Build-Tool.ps1 and by hand:
    #   Invoke-ScriptAnalyzer -Path .\src -Settings .\PSScriptAnalyzerSettings.psd1
    Severity     = @('Error', 'Warning')
    ExcludeRules = @(
        # Event handlers and dialogs change UI state; they are not cmdlets that need -WhatIf.
        'PSUseShouldProcessForStateChangingFunctions'
        # Empty catches are deliberate best-effort steps (window icon, settings, logging, cleanup).
        'PSAvoidUsingEmptyCatchBlock'
        # WPF event handlers keep the standard (sender, e) signature even when one is unused.
        'PSReviewUnusedParameter'
    )
}
