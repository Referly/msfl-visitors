require_relative 'msfl_visitors/nodes'
require_relative 'msfl_visitors/visitor'
require_relative 'msfl_visitors/parsers/msfl_parser'

module MSFLVisitors

  class << self
    def get_chewy_clauses(dataset, msfl, visitor = MSFLVisitors::Visitor.new)
      unless dataset.is_a? MSFL::Datasets::Base
        raise ArgumentError, "The first argument to MSFLVisitors.get_chewy_clauses must be a descendant of MSFL::Datasets::Base."
      end
      parser    = MSFLVisitors::Parsers::MSFLParser.new dataset
      converter = MSFL::Converters::Operator.new
      nmsfl     = converter.run_conversions msfl
      ast       = parser.parse nmsfl
      visitor.visit_tree ast
    end

    def get_arel(dataset, msfl, visitor = MSFLVisitors::Visitor.new)
      visitor.mode = :arel
      unless dataset.is_a? MSFL::Datasets::Base
        raise ArgumentError, "The first argument to MSFLVisitors.get_arel must be a descendant of MSFL::Datasets::Base."
      end
      parser    = MSFLVisitors::Parsers::MSFLParser.new dataset
      converter = MSFL::Converters::Operator.new
      nmsfl     = converter.run_conversions msfl
      ast       = parser.parse nmsfl
      visitor.visit_tree ast, arel_table: dataset.arel_table
    end
  end
end