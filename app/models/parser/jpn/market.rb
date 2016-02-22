module Parser
  module Jpn
    class Market

      def initialize(name)
        @name = name
      end

      def latest_list
        list = Parser.send(@name)
        Company.delete_not_market(list)
        list
      end
    end
  end
end
