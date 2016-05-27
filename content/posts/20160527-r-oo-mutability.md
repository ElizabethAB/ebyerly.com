Title: R, OO, and Mutability
Date: 2016-05-27
Tags: r, java, oo, mutability
Authors: Elizabeth Byerly
Summary: Convincing an OO programmer against OO programming in R

A proposal at work: adapt an executable R script into a method using object oriented programming. The idea goes against my instincts, but I wasn't able to immediately articulate my concerns. I'm thinking through the issue here and deciding whether I'm being reasonable or knee-jerk (or just a jerk).

### TL;DR

R's immutable objects are a barrier to using the language within an object oriented programming paradigm. Adding mutability to R is a solved problem, but it requires adding code complexity.

---

## Mutability

[Mutability](https://en.wikipedia.org/wiki/Immutable_object) is important to object oriented programming. Loosely, we can think of mutability as: can an object be changed after it is created? Changing an object is different than assigning over an object reference, in that effects calls to that object from every namespace and not only those namespaces where the assignment takes priority.

Object oriented programming can be implemented in a world of immutable objects, but mutability makes attributes and stateful programming simpler to code and to think about. Mutable classes are staples in Java and Python (my coworker's and my preferred OO languages).

R loves **im**mutable objects. It copies obsessively. Every time you can conceive of the program generating and maintaining a separate copy of data, assume it is doing so. We can mimic mutable objects in R by manipulating namespaces, but it's difficult to code, to read, and to think about.

An example of a "mutable" object in R is provided below.

```r
createMutable <- function() {
  .mut <- list()
  function(key = NULL, val = NULL) {
    curr <- get(".mut")
    if (is.null(val)) return(curr)
    curr[[key]] <- val
    .mut <<- curr
    invisible(.mut)
  }
}

mutable <- createMutable()

mutable("a", 1)
mutable()["a"]
mutable("a", 3)
mutable()["a"]
```

## Functional v. OO programming

Immutable objects and [first-class functions](https://en.wikipedia.org/wiki/First-class_function) make R great for functional programming. R's immutability was not an oversight.

Functional programming is mocked as being an academic wheeze by-and-for mathematicians, but step back and remember R is a *statistical programming language*. For statisticians, functional programming is a practical paradigm. It's easy to reason about a system where every input can be seen and fully understood at the point a function is called. It's easy to reason about a system where a "function" operates the same way a "function" has in your prior education - outputs solely dependent on inputs. When a PhD statistician's billing rate is $600+ an hour (as in my world), making everything but the statistics easy is a priority.

Object oriented programming can be helpful in situations where a program has to account for an objective reality. Some examples of objective realities in software include a user's mouse location or the status of a network connection. When you are using R for applications programming, its lack of OO assets is a real hindrance, which is why R is never recommended for applications programming. 

## R's built-in OO

R does make a nod to object orientation.

The [S3](https://stat.ethz.ch/R-manual/R-devel/library/base/html/UseMethod.html) and [S4](https://stat.ethz.ch/R-manual/R-devel/library/methods/html/Classes.html) systems in R help us build genericized functions using [method dispatch](https://en.wikipedia.org/wiki/Dynamic_dispatch) (that's why you can call `predict()` on so many different model output objects). Aside from applications duplicated by named lists, that's their most interesting use case.

Below is an example of an S4 class and its immutable behavior.

```r
setClass("eg", slots = list(attribute = "numeric"))
my_obj <- new("eg", attribute = 1)

my_obj@attribute
my_obj@attribute <- 2
my_obj@attribute

tmp <- function(person) {
  person@attribute <- 5
  return(person)
}

tmp(my_obj)@attribute
my_obj@attribute
```

R introduced a third form of OO in version 2.12, [RC](https://stat.ethz.ch/R-manual/R-devel/library/methods/html/refClass.html), which includes mutability. I have encountered very few packages or community scripts (and none actively developed) that take advantage of RC's functionality. That is no guarantee of its quality, either way, but it means at least two things:

1. Using RC at work means committing to training on RC, as few people have prior experience, and
2. The R community does not feel a burning need for the mutability offered by RC.

## Conclusions

I stand by my initial reaction. Without an argument for how our use case plays to object oriented programming's strengths, implementing an OO solution in R would add technical debt and code complexity.

I have no interest in discouraging the debate at work. This exercise is helping to develop my understanding of R programming and being proven wrong only means learning something new, which would be great.

---

### Disclaimer

I love classes, mutability, and stateful programming. I use, and occasionally abuse, them in Python. I use R and Python differently and base my separation on what I hope to be a reasonable understanding of their relative strengths.
