class Schedule < Schedulable::Model::Schedule
  def self.rules
    %w(singular daily weekly monthly)
  end
end