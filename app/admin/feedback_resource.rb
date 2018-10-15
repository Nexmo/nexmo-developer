ActiveAdmin.register Feedback::Resource, as: 'Resource' do
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
    column :id do |resource|
      resource.id.first(8)
    end
    column :uri
    column :feedbacks do |resource|
      link_to(resource.feedbacks.size, admin_feedbacks_path(q: { resource_id_eq: resource.id }))
    end
    column :feedbacks_positive do |resource|
      link_to(resource.feedbacks.positive.size, admin_feedbacks_path({
        q: {
          resource_id_eq: resource.id,
          sentiment_equals: 'positive',
        },
      }))
    end
    column :feedbacks_negative do |resource|
      link_to(resource.feedbacks.negative.size, admin_feedbacks_path({
        q: {
          resource_id_eq: resource.id,
          sentiment_equals: 'negative',
        },
      }))
    end
    actions
  end
end
