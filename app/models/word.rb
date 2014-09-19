class Word < ActiveRecord::Base

  def most_common
    # Word.all.order_by(count, desc).limit(50)
  end
end
