ActiveAdmin.register Event do
  permit_params :title, :description, :avatar, :created_at,
                :user_id, :tickets, :sales_count, :duration,
                :tickets, :price, :tag_list, :tag, { tag_ids: [] }, :tag_ids,
                :images, images: []

  action_item :publish, only: :show do
    link_to 'Publish', publish_admin_event_path(event), method: :put unless event.created_at?
  end

  member_action :publish, method: :put do
    event = Event.find(params[:id])
    event.update(created_at: Time.zone.now)
    redirect_to admin_event_path(event)
  end

  index do
    selectable_column
    id_column
    column :title
    column :body_text
    column :start_date
    column :duration
    column :price
    column :tickets
    column :sales_count
    column :tag

    actions
  end

  filter :title
  filter :description
  filter :start_date
  filter :created_at
  filter :price
  filter :duration
  filter :tickets
  filter :tag

  form html: { multipart: true } do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :avatar, as: :file, input_html: { multiple: false }
      f.input :images, as: :file, input_html: { multiple: true }
      f.input :start_date
      f.input :duration
      f.input :price
      f.input :tickets
      f.input :tags
    end
    f.actions
  end

  show do |cat|
    h3 cat.title
    h3 cat.description
    h3 cat.start_date
    h3 cat.duration
    h3 cat.price
    h3 cat.tickets
    h3 cat.tags
  end
end
