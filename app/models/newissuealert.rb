class Newissuealert < ActiveRecord::Base
  belongs_to :project
  attr_accessible :project_id, :mail_addresses, :enabled, :priority, :tracker_id, :subject, :template
end
