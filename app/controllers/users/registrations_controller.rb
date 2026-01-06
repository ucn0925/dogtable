class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    def new
        build_resource({})
        resource.build_dog
        respond_with resource
    end

    def edit
        super
        resource.build_dog unless resource.dog
    end

    def update
        if params[:remove_profile_image] == "1"
            resource.profile_image.purge
        end

        if params[:remove_dog_image] == "1"
            resource.dog&.dog_image&.purge
        end
        
        super do |resource|
            redirect_to mypage_path, notice: "プロフィールを更新しました！" and return
        end
    end


    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(
            :sign_up, keys: [
                :name,
                :profile, 
                :profile_image, 
                dog_attributes: [:name, :breed, :size, :dog_image]
            ]
        )
        devise_parameter_sanitizer.permit(
            :account_update, keys: [
                :name,
                :profile, 
                :profile_image, 
                dog_attributes: [:id, :name, :breed, :size, :dog_image]
            ]
        )
    end
end
