[![codecov](https://codecov.io/github/Marc-R2/logger_dart/branch/master/graph/badge.svg?token=XM5NIT73JV)](https://codecov.io/github/Marc-R2/logger_dart)
[![Dart](https://github.com/Marc-R2/logger_dart/actions/workflows/dart.yml/badge.svg?branch=master)](https://github.com/Marc-R2/logger_dart/actions/workflows/dart.yml)

# Logger for Dart

The Logger package is a simple logging package for dart that allows you to
create log messages with different levels of importance.
The package also provides options to add tags to the messages,
as well as the ability to add template values to the messages.

## Installation

Simply make sure to add the following to your `pubspec.yaml`:

```yaml
dependencies:
  transfer_network:
    git:
      url: https://github.com/Marc-R2/logger_dart.git
```

and run `pub get` or `pub upgrade` in the same directory as your `pubspec.yaml`.

## Quick Start

To start using the Logger package, first import it in your dart file:

```dart
import 'package:log_message/logger.dart';
```

### Your first Messages

You can then use the Message class to create log messages with different levels of importance.
You can use the following constructors to create different types of messages: log, info, warning, error, and trace.

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

### Logging in Context

It can be useful to log messages within a current context across different functions or even classes.

To do this, the simplest way is to use the `Logging` mixin and the `startFunction` method.
You will get a `Log` object which you can use to log messages in the current context.

You just need to pass the current context around and tell it when a new function is started.
The rest is handled by the `Log` object.

```dart
class MyClass with Logging {
  void myFunction() {
    final log = startFunction('myFunction');
    
    log.trace(title: 'Trace message');
    log.log(title: 'Log message');
    log.info(title: 'Info message');
    log.warn(title: 'Warning message');
    log.error(title: 'Error message');
    /* throw */ log.exception(title: 'Error message, which can be thrown');
    
    myOtherFunction(log);
  }
  
  void myOtherFunction(Log? context) {
    final log = startFunction('myOtherFunction', context);
        
    log.info(title: 'Second Info message');
  }
}
```

Under the hood, the `Log` keeps track of all messages in the current context
and adds all kinds of useful information to them like the current function and class,
tags to group messages by their unique context later on and information about the program flow across branches.

## MessageTemplates
The Logger package also provides a MessageTemplate class which allows you to create reusable templates for log messages. 
This class allows you to set default values for tags, functions and classes.

To create a MessageTemplate, you can use the constructor:

```dart
final template = MessageTemplate(
  tags: ['default_tag'], // List<String> = const [],
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

Log functionStart(String function, [Log? context]);
```

## Logger

## Message
