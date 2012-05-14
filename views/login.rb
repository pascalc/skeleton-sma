class ApplicationController
  module Views
    class Login < Mustache
      if (@nr_fails != nil)
        puts '@nr_fails not nil'
        if(@nr_fails>0)
          def failed_login
	    puts 'should have defined "failed_login"'
            @nr_fails
          end
        end
      end

          #def failed_login
	#	puts 'should have defined "failed_login"'
           # @nr_fails
          #end 
    end
  end
end
