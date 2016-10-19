# Examples

## Simplest Example

*It assumes that the default logger is set to the EkmLogger*

```vbscript
Dim logger : Set logger = LogManager.GetDefaultLogger()
Dim log : Set log = LogBuilderHelper.Create() _
  .Debug("I am debugging something") _
  .Tag("debug") _
  .Tag("testing") _
  .Meta("details", "Some extra details") _
  .Meta("exception", "Maybe something went wrong?") _
  .Build()

Call logger.Log(log)
```
