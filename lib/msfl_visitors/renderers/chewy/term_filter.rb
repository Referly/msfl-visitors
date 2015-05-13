module MSFLVisitors
  module Renderers
    module Chewy
      class TermFilter
        BINARY_OPERATORS = {
          Nodes::GreaterThan      => ' > ',
          Nodes::LessThan         => ' < ',
          Nodes::GreaterThanEqual => ' >= ',
          Nodes::LessThanEqual    => ' <= ',
          Nodes::Equal            => ' == ',
        }

        def render(node)
          case node

          when Nodes::Comparison
            BINARY_OPERATORS[node.class]

          when Nodes::BinaryAnd
            ' & '

          when Nodes::Date, Nodes::Time
            node.value.iso8601

          when Nodes::Boolean, Nodes::Number
            node.value

          when Nodes::Field
            node.value.to_s

          when Nodes::Word
            %("#{node.value.to_s}")

          when Nodes::Grouping::Close
            ' )'

          when Nodes::Grouping::Open
            '( '

          when Nodes::Set::Close
            ' ]'

          when Nodes::Set::Delimiter
            ', '

          when Nodes::Set::Open
            '[ '

          when Nodes::Containment
            ' == '

          when Nodes::Foreign
            # noop for now

          when Nodes::Dataset
            node.value.to_s

          else
            fail ArgumentError.new("Unrecognized node type: #{node.class}")
          end
        end
      end
    end
  end
end
