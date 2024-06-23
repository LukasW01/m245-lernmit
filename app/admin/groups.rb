ActiveAdmin.register Group do
  form partial: 'form'
  permit_params :name, :desc, :size

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :desc, :size
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :desc, :size]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
