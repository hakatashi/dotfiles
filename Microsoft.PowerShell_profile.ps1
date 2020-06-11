function AliasUtil {
  $NewCommand = $Args[0]
  $OldCommand = $Args[1]
  if ($Args.count > 2) {
    $OldCommandOptions = $Args[2..($Args.Count - 1)]
  }
  function AliasFunction {
    if ($OldCommandOptions) {
      Invoke-Expression -Command $OldCommand @OldCommandOptions
    } else {
      Invoke-Expression -Command $OldCommand
    }
  }
  New-Alias -Name $NewCommand -Value AliasFunction -Option AllScope -Force -Scope Global
}

AliasUtil Nyankoo ls.exe
Nyankoo
