module Dre
  class Device < ActiveRecord::Base
    # Associations:
    belongs_to :owner, polymorphic: true

    # Validations:
    validates :owner_id, presence: true
    validates :owner_type, presence: true
    validates :token, presence: true
    validates :token, uniqueness: { scope: [:owner_id, :owner_type] }

    # Hooks:
    after_create :invalidate_used_token

    private

    def invalidate_used_token
      Device.where(token: token).where('id != ?', id).delete_all
    end

    class << self
      def for_owner(owner)
        where(owner_id: owner.id, owner_type: owner.class.base_class)
      end
    end
  end
end
