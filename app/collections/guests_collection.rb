class GuestsCollection < BaseCollection
  private

  def relation
    @relation ||= Guest.all
  end

  def ensure_filters
    hotel_filter
    checked_in_filter
    checked_out_filter
  end

  def hotel_filter
    return if params[:hotel_id].blank?

    filter do |rel|
      rel.joins(:check_ins).where(check_ins: { hotel_id: params[:hotel_id] })
    end
  end

  def checked_in_filter
    return if params[:checked_in].blank?

    filter do |rel|
      rel.joins(:check_ins).where(check_ins: { checked_out_at: nil })
    end
  end

  def checked_out_filter
    return if params[:checked_out].blank?

    filter do |rel|
      rel.joins(:check_ins).where.not(check_ins: { checked_out_at: nil })
    end
  end
end
