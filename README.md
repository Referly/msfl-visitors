[![Circle CI](https://circleci.com/gh/Referly/msfl_visitors.svg?style=svg)](https://circleci.com/gh/Referly/msfl-visitors)

# msfl_visitors
A visitor pattern based approach for converting MSFL to other forms

## Usage

 ```ruby
 # This is not actually working code yet! @todo revisit once Matt's refactor branch is merged.
 require 'msfl_visitor'

 filter = { make: "Toyota" }

 collector = String.new

 renderer = MSFLVisitors::Renderers::Chewy::TermFilter.new

 visitor = MSFLVisitors::Visitor.new collector, renderer

 MSFLVisitors::AST.new(filter).accept(visitor)

 => 'make == "Toyota"'

 ```

## Architecture

msfl_visitors is designed to consume normalized Mattermark Semantic Filter Language (NMSFL).
msfl_visitors implements a parser (parsers/msfl_parser) that converts NMSFL into an AST.
msfl_visitors implements a visitor that traverses the ast and produces the well formed output.
The behavior of the visitor is controlled through composition at construction. It accepts a collector and a renderer.

## MSFLParser

The parser accepts a Hash containing NMSFL and produces an AST.
The parser uses a simplified version of the visitor pattern to traverse the NMSFL and produce the AST.

Typically one does not interact with the parser directly, instead a consumer of this gem should interact with the AST.

## AST

The abstract syntax tree that represents a certain query filter. In the version of the visitor pattern herein
adopted, each node of the AST is responsible for managing its state and traversal of itself and children.

A consumer of this gem creates a new AST instance passing in a Hash of NMSFL. The AST will leverage the MSFL parser
to construct itself. The AST object is a Node as it implements the #accept(visitor) method.

## visitor

Unlike the classical visitor pattern double dispatch is not strictly achieved through type matching in the visitor.
Instead the visitor is just a single service that is composed of a collector and a renderer.
The double dispatch is codified inside of a renderer, which like the visitors in the classic pattern can produce
multiple output DSLs.

## collector

During traversal the output from each node needs to be stored or buffered somewhere. The collector serves this role.
It can be as simple as a String or an Array, or it can be more elaborate. Ultimately it must respond to the shovel
operator (<<)

## renderer

The logic for rendering the AST nodes into the output DSL is codified in a renderer. The two principle renderers at
this time are Chewy::TermFilter and Chewy:QueryStringFilter