class ApplicationController
    module Views
        class Tagging < Mustache
            def limit
                [{:n => '10'}, {:n => '20'}, {:n => '30'}, {:n => '40'}, {:n => '50'}, {:n => '60'}, {:n => '70'}, {:n => '80'}, {:n => '90'}, {:n => '100'}]
            end
            def messages
                @messages
            end

            def initdummydata
                @dummydata = [{:tags => 'dummy'},{:tags => 'placeholder'},{:tags => 'textdata'},{:tags => 'Test'}]


		
		@dummydata.each_with_index do |item,index|
			item.store('index', index)
		end
            end
            def dummydata
                @dummydata
            end

        end
    end
end
