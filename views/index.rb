class ApplicationController
  module Views
    class Index < Layout
        def log_tail
            @log_tail.gsub("\n", "<br/>")
        end
    end
  end
end