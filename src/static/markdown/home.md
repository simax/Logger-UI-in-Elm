# EKM Logger Documentation

## What is it?

The primary purpose of this web service is for **centralizing** logs.

## The Log Model

Here is the structure of the Log Model:

```js
{
  "application": "My Awesome Application",
  "level": 1,
  "message": "I need to tell you something...",
  "meta": [{
    "key": "meta1",
    "value": "I have some extra details"
  }, {
    "key": "exception",
    "value": "Maybe something went wrong?"
  }],
  "tags": [
    "test",
    "debug"
  ]
}
```
