Title: Python Threading Examples
Date: 2016-06-22
Tags: python, threading, concurrence
Authors: Elizabeth Byerly
Summary: Modifiable examples using Python's `threading` module.

I am a huge fan of Python's [documentation](https://docs.python.org/3/). It's intuitive to navigate, the contents are easy to read, and it almost always provides great working examples of functions and modules in action.

An unfortunate exception is Python's [`threading` module](https://docs.python.org/3/library/threading.html). It is easy to use! You would have no idea of that looking at the docs!

I'm going to bolster the doc's contents with three starter examples:

1. Threads that execute functions without arguments
2. Threads that execute functions with arguments specified by placement and by keyword
3. Threads that take advantage of [`Queue` objects](https://docs.python.org/3/library/asyncio-queue.html) to pull in their arguments while a function executes

You can get fancy with threads, particularly by taking advantage of subclassing [`threading.Thread`](https://docs.python.org/3/library/threading.html#thread-objects), but getting started with boring modifiable examples helps *me* and now it can help *you*.

---

### TL;DR

Create a thread:

```python
import threading


def some_func(one, two, an_arg = 0):
    return one + two * an_arg


eg = threading.Thread(target=some_func,
                      args = (1, 2),
                      kwargs = {"an_arg": 3})
```

Start the thread (run its target function):

```python
eg.start()
```

Check if the thread's target function is still running (great for `while` loops):

```python
eg.is_alive()
```

Make your main program wait for a thread to finish:

```python
eg.join()
```

---

Hey, wait, where's my output? Threads run separately from your main program and interact with it by a shared memory space. Try using a function that directly manipulates a global object (by declaration or by using a mutable object as an input).

```python
import threading


def some_func(one, two, an_arg = None):
    global my_var
    my_var += one + two
    an_arg.append(my_var)


my_var = 0
my_list = []
eg = threading.Thread(target=some_func,
                      args = (1, 2),
                      kwargs = {"an_arg": my_list})
eg.start()
eg.join()
my_var
my_list
```

Spoiler alert: [concurrency](https://en.wikipedia.org/wiki/Concurrency_(computer_science)) can be [hard](http://www.dabeaz.com/usenix2009/concurrent/race.py). Python's `threading` module has a lot of tools to help you deal with concurrency, none of which I'm going to deal with below. Just know you need to understand *when* and *how* multiple threads share objects if your use case needs them to share objects.


---

## Threads that execute functions without arguments

```python
import logging
import threading


def a_thread():
    log = logging.getLogger()
    log.warning("Oh no, we're in a thread!")


eg = threading.Thread(target=a_thread)
eg.start()
eg.join()
```

Did you know that logging from a thread is stupid simple? Like, change-none-of-your-code simple? Yeah, me too, because the logging documentation has a [great example](https://docs.python.org/3/howto/logging-cookbook.html#logging-from-multiple-threads) in its cookbook!


---

## Threads that execute functions with arguments specified by placement and by keyword

```python
import logging
import threading


def a_thread_with_arguments(first, second, arbitrary):
    log = logging.getLogger()
    log.warning("Our arguments are %d, %d, %d", first, second, arbitrary)


eg = threading.Thread(target=a_thread_with_arguments,
                      args=(1, 2),
                      kwargs={"arbitrary": 42})
eg.start()
eg.join()
```


### Oh, how about running multiple threads simultaneously...

```python
import logging
import threading
from time import sleep
from random import randint


def a_thread_with_arguments(first, second, arbitrary):
    log = logging.getLogger()
    sleep(randint(1, 4))
    log.warning("Our arguments are %d, %d, %d", first, second, arbitrary)


for val in range(10):
    curr_thread = threading.Thread(target=a_thread_with_arguments,
                                       args=(1, 2),
                                       kwargs={"arbitrary": val})
    curr_thread.start()
```


---

## Threads that take advantage of `Queue` objects to pull in their arguments while a function executes

The closest thing I'm getting to an intermediate topic is an example of how to use Python's queues to pass arguments into running threads.

We're going to use the `threading` and `queue` modules, of course, as well as the `logging` module again.

```python
from queue import Queue
import threading
import logging
```

We change how the log files are written so that they explicitly tell us which thread creates an entry (`%(threadName)s`).

```python
ft = logging.Formatter(fmt=("%(asctime)s:%(msecs)d|%(threadName)s|%(message)s"),
                       datefmt="%Y-%m-%d %H:%M:%S")
ch = logging.StreamHandler()
ch.setFormatter(ft)
log = logging.getLogger()
log.addHandler(ch)
```

Now, we define a function that we're going to set as our threads' targets. It takes as its only argument a `Queue` object. It runs forever (note our infinite `while True` loop), always trying to get a value from its `a_queue`.

```python
def a_thread_with_queue(a_queue):
    log = logging.getLogger()
    while True:
        queue_val = a_queue.get()
        log.warning("This is %s", queue_val)
        a_queue.task_done()
```

Finally, we make a `Queue`, ten `Thread`s all refering to our queue, and then feed our queue the integers 0-99 to print to our log!

```python
my_queue = Queue()

my_threads = []
for val in range(10):
    curr_thread = threading.Thread(target=a_thread_with_queue,
                                   args=(my_queue,))
    curr_thread.start()
    my_threads.append(curr_thread)

for input in range(100):
    my_queue.put(input)
```


---

## Conclusion

See? Threading is easy.

(...when we omit everything that makes threading hard. Let's call what I've covered the base case: not interesting on its own, but essential to understand before you get to the good stuff!)
