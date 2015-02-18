module SessionsHelper
	def sign_in(user)
		# 1. �g�[�N����V�K�쐬����
		remember_token = User.new_remember_token
		# 2. �Í�������Ă��Ȃ��g�[�N�����u���E�U��cookie�ɕۑ�����
		cookies.permanent[:remember_token] = remember_token
		# 3. �Í��������g�[�N�����f�[�^�x�[�X�ɕۑ�����
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		# 4. �^����ꂽ���[�U�����݂̃��[�U�Ɏw�肷��
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user) # current_user�ւ̗v�f����������悤�ɐ݌v����Ă���
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
		# ||= ... or equals @current_user������`�̏ꍇ�ɂ̂݁A@current_user�C���X�^���X�ϐ��ɋL���g�[�N����ݒ肷��
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, notice: "Please sign in." unless signed_in?
		end
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end
end