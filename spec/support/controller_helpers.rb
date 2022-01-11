# module ControllerHelpers
#   def login_with(user = double('user'), scope = :user)
#     current_user = "current_#{scope}".to_sym
#     if user.nil?
#       allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => scope})
#       allow(controller).to receive(current_user).and_return(nil)
#     else
#       allow(request.env['warden']).to receive(:authenticate!).and_return(user)
#       allow(controller).to receive(current_user).and_return(user)
#     end
#   end

#   def login_user
#     before(:each) do
#       @request.env["devise.mapping"] = Devise.mappings[:user]
#       user = FactoryBot.create(:user)
#       #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
#       sign_in user
#     end
#   end

#   def login(user)
#     user = User.where(:login => user.to_s).first if user.is_a?(Symbol)
#     request.session[:user] = user.id
#   end

#   def current_user
#     User.find(request.session[:user])
#   end

#   def sign_in(user)
#     if user.nil?
#       allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
#       allow(controller).to receive(:current_user).and_return(nil)
#     else
#       allow(request.env['warden']).to receive(:authenticate!).and_return(user)
#       allow(controller).to receive(:current_user).and_return(user)
#     end
#   end

#   def login_as(user)
#     request.session[:user_id] = user.id
#   end
# end