ActiveAdmin.register Feedback::Author, as: 'Author' do
  menu parent: 'Feedback'
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

  index do
    column :id do |author|
      author.id.first(8)
    end
    column :email
    actions
  end
end
