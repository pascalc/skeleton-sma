class ApplicationController
  module Views
    class Layout < Mustache
    	def flash_success?
    		not @session[:success].nil?
    	end
    	def flash_success
    		success = @session[:success]
    		@session[:success] = nil
    		success
    	end
    	def flash_notice?
    		not @session[:notice].nil?
    	end
    	def flash_notice
    		notice = @session[:notice]
    		@session[:notice] = nil
    		notice
    	end
    	def flash_error
    		not @session[:error].nil?
    	end
    	def flash_error
    		error = @session[:error]
    		@session[:error] = nil
    		error
    	end
        def previous_link
            skip = @skip - @limit
            "#{url}?skip=#{skip}&limit=#{@limit}" if skip >= 0
        end
        def next_link
            "#{url}?skip=#{@skip + @limit}&limit=#{@limit}"
        end
    end
  end
end