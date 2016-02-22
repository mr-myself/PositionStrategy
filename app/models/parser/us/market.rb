module Parser
  module Us
    class Market

      def initialize(name)
        @name = name
      end

      def latest_list
        list = Parser.send(@name)
        UsCompany.delete_not_market(list, @name)
        list
      end
    end
  end
end
