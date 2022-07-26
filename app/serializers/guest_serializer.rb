class GuestSerializer < ApplicationSerializer
  attributes :profile, :initials

  def initials
    return 'NA' if object.profile['name'].blank?

    object.profile['name'].split(' ').map(&:first).join('')
  end
end
