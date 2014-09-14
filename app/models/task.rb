class Task < ActiveRecord::Base
  belongs_to :context
  belongs_to :project
end
