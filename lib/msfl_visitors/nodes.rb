# Using alphabetical order to keep these organized
require_relative 'nodes/and'
require_relative 'nodes/base'
require_relative 'nodes/binary'
require_relative 'nodes/boolean'
require_relative 'nodes/comparison'
require_relative 'nodes/constant_value'
require_relative 'nodes/date'
require_relative 'nodes/date_time'
require_relative 'nodes/equal'
require_relative 'nodes/greater_than'
require_relative 'nodes/greater_than_equal'
require_relative 'nodes/grouping/close'
require_relative 'nodes/grouping/grouping'
require_relative 'nodes/grouping/open'
require_relative 'nodes/less_than'
require_relative 'nodes/less_than_equal'
require_relative 'nodes/number'
require_relative 'nodes/range_value'
require_relative 'nodes/time'
require_relative 'nodes/value'
require_relative 'nodes/word'

module MSFLVisitors
  module Nodes
    # Instead of using string interpolation only supported operators are enabled
    BINARY_OPERATORS = {
      Equal => " == ",
      GreaterThan => " > ",
      GreaterThanEqual => " >= ",
      LessThan => " < ",
      LessThanEqual => " <= ",
      And => " & ",
    }
  end
end