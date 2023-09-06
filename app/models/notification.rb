class Notification < ApplicationRecord
  enum about: { feedback: 0, diary: 1, cashio: 2 }
  belongs_to :user

  def about_icon
    if self.about == 'feedback'
      'bi-chat-left-text'
    elsif self.about == 'diary'
      'bi-journal-bookmark'
    elsif self.about == 'cashio'
      'bi-coin'
    end
  end
end
