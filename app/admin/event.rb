ActiveAdmin.register Event do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :description, :starts_at, :ends_at, :url, :city, :country
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column :title
    column :description
    column :starts_at
    column :ends_at
    column :url
    column :city
    column :country
    actions
  end

  form do |_f|
    inputs 'Details' do
      input :title
      input :description
      input :url
      input :city
      input :country
      input :starts_at, as: :datepicker
      input :ends_at, as: :datepicker
    end
    actions
  end
end
