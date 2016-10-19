# Examples

## Simplest Example

```csharp
public class MyAwesomeClass
{
  public void MyAwesomeFunction(string myParam)
  {
    // Do some awesome stuff!

    var client = new EkmLoggerClient(new EkmLoggerClientConfiguration
    {
        ServiceUrl = new Uri("http://localhost:3000")
    });

    client.PostAsync(LogBuilder.For("My Awesome App");
      .Debug("I just got called!")
      .Tag("test")
      .Meta("myParam", myParam)
      .Build());
  }
}
```

## Dependency Injection

Create a **Provider** for the client

```csharp
public interface IEkmLoggerClientProvider
{
  IEkmLoggerClient GetClient();
}

internal class EkmLoggerClientProvider : IEkmLoggerClientProvider
{
  public IEkmLoggerClient GetClient()
  {
    return new EkmLoggerClient(new EkmLoggerClientConfiguration
    {
        ServiceUrl = new Uri("http://localhost:3000")
    });
  }
}
```

And inject it in to your class

```csharp
public class TestModule : NancyModule
{
  public TestModule(IEkmLoggerClientProvider ekmLoggerClientProvider)
    : base("/test")
  {
    _ekmLoggerClientProvider = ekmLoggerClientProvider;

    Get["/"] = GetIndex;
  }

  private readonly IEkmLoggerClientProvider _ekmLoggerClientProvider;

  private dynamic GetIndex(dynamic parameters)
  {
    var client = _ekmLoggerClientProvider.GetClient();
    var log = LogBuilder.For("My Nancy App")
      .Debug("Got to the TestModule")
      .Tag("nancy")
      .Tag("test")
      .Meta("CurrentUser", Request.CurrentUser)
      .Build();

    client.PostAsync(log);

    return HttpStatusCode.OK;
  }
}
```
