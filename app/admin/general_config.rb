ActiveAdmin.register GeneralConfig do
permit_params :cron_time, :domain_limit
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  # content do
  #   para "#{Rails.application.config.time_zone}"
  #   para "#{Rails.application.config.allowed_domain}"
  #   # render partial: 'calendar'
  # end
  controller do
    def create
      config = GeneralConfig.first
      if config.present?
        config.update(config_params)
      else
        GeneralConfig.create(config_params)
      end
      redirect_to admin_general_configs_path,notice: 'Configurations Updated Successfully'
    end

    def index
      @config =  GeneralConfig.first || GeneralConfig.new
    end

    private
    def config_params
      params.require(:general_config).permit(:cron_time, :domain_limit)
    end
  end

end
