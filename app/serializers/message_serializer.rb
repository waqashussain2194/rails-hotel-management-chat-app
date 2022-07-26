class MessageSerializer < ApplicationSerializer
  attributes :created_at, :content, :is_agent
  belongs_to :user
  belongs_to :guest
end
