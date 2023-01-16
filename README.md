[![codecov](https://codecov.io/github/Marc-R2/logger_dart/branch/master/graph/badge.svg?token=XM5NIT73JV)](https://codecov.io/github/Marc-R2/logger_dart)
[![Dart](https://github.com/Marc-R2/logger_dart/actions/workflows/dart.yml/badge.svg?branch=master)](https://github.com/Marc-R2/logger_dart/actions/workflows/dart.yml)

# Logger for Dart

The Logger package is a simple logging package for dart that allows you to create log messages with different levels of importance. The package also provides options to add tags to the messages, as well as the ability to add template values to the messages.

## Quick Start

To start using the Logger package, first import it in your dart file:

```dart
import 'package:log_message/logger.dart';
```

You can then use the Message class to create log messages with different levels of importance. You can use the following constructors to create different types of messages: log, info, warning, error, and trace.

Here's an example of creating a log message:

```dart
Message.log(title: 'Test message', text: 'This is a test message', level: 0);
```

You can also add tags and template values to the message:

```dart
final message = Message.log(
  title: 'Test message', 
  text: 'Hello {name}!', 
  level: 0, 
  tags: ['tag1', 'tag2'], 
  templateValues: {'name': 'Your-Name'},
);
```

By default, the message will be automatically logged when it's created. 

However, if you want to control the logging manually, you can set the log property to false when creating the message. 
Then, you can use the Logger class to log the message:

```dart
final message = Message.log(
  title: 'Test message',
  text: 'Hello {name}!',
  log: false,
);

Logger.log(message);
```

The package also provides the MessageTemplate class, which allows you to create reusable templates for messages. 
Additionally, you can use the Logging mixin to add logging functionality to your own classes. 
Be sure to check out the full documentation for more information on these features.

## MessageTemplates
The Logger package also provides a MessageTemplate class which allows you to create reusable templates for log messages. 
This class allows you to set default values for tags, functions and classes.

To create a MessageTemplate, you can use the constructor:

```dart
final template = MessageTemplate(
  tags: ['default_tag'], // List<String>
  function: 'my_function', // String?
  klasse: 'my_class', // Object?
);
```


## Logging Mixin
The Logging mixin is a convenient way to add logging functionality to your existing classes.

To use the Logging mixin, you need to import the package and mix it into your class:

```dart
import 'package:log_message/logger.dart';

class MyClass with Logging {
  // your class code here
}
```

By mixing in the Logging mixin, your class will now have access to the following members:

```dart
MessageTemplate log;

MessageTemplate functionLog(String functionName);

MessageTemplate classLog(Object className);
```

## Logger

## Message
