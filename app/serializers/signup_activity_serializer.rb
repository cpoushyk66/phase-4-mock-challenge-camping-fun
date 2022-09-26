class SignupActivitySerializer < ActiveModel::Serializer
    attributes :id, :camper_id, :activity_id, :time

    belongs_to :activity
  end
  