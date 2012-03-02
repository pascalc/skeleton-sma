class ApplicationController
  module Views
    class Users < Layout
        def users
            @users.map { |u| { name: u } }
        end
    end
  end
end