# Classic ASP Client

*The client is currently implemented in the Powershop codebase on the **SQLite-Migration Sync** branch, so is not currently available for use on the  **default** branch.*

## EKM (Powershop)

The client is contained in the [logging _namespace_](http://hg/ekmPowershop/ekmPowershop/file/76a400c8033f/wwwroot/ekmps/data/ekmpowershop_A/logging) in the **EKM** code.

### How do I use it?

You shouldn't need to add it as an *include*, as it should already be added by the **global_header_footer_system.asp** page. Then all you need to do to get the client is:

```vbscript
Dim logger : Set logger = LogManager.GetEkmLogger("MyLogger")
```

***Or, if it is set as the default in the LogManager***

```vbscript
Dim logger : Set logger = LogManager.GetDefaultLogger("MyLogger")
```

*In the above example, "MyLogger" will be included in the meta of any logs produced by the created logger.*
