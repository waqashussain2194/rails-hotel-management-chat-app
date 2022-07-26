class NotificationsCollection < BaseCollection
  private

  def relation
    @relation ||= Notification.order(created_at: :desc).all
  end

  def ensure_filters
    hotel_filter
    guest_filter
  end

  def hotel_filter
    return if params[:hotel_id].blank?

    filter do |rel|
      rel.where(hotel_id: params[:hotel_id])
    end
  end

  def guest_filter
    return if params[:guest_id].blank?

    filter do |rel|
      rel.where(guest_id: params[:guest_id])
    end
  end
end
