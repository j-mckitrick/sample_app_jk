class DeveloperProfile < ActiveRecord::Base
  belongs_to :user
  
  TYPICAL_PROJECT_SIZE = ["$50-250K", "$250-500K", "$500k-$1M", "$1-5M", "$5-10M", "$10-50M", ">$50M"]
  EXPERIENCE = ["0-5 years", "5-10", "10-20", ">20"]
  EMPLOYMENT = ["Part Time", "Full Time"]
  PROJECTS_PER_YEAR = ["0-5", "5-10", "10-20", "20+"]
  WHERE_DID_YOU_HEAR =  ["Web Search", "Facebook", "LinkedIn", "Twitter", "News Article", "Online Discussion Board", "Trade Association", "Friend / Associate"]
  
  before_update :check_for_completed_profile
  
  # validates :employment, presence: true, :on => :update
  # validates :experience, presence: true, :on => :update
  # validates :yearly_projects, presence: true, :on => :update
  # validates :typical_project_size, presence: true, :on => :update
  validates :employment, presence: true
  validates :experience, presence: true
  validates :yearly_projects, presence: true
  validates :typical_project_size, presence: true
  
  state_machine :state, :initial => :started do
    event :complete do
      transition any => :completed
    end    
  end

  def completed_profile?
    (employment && experience && yearly_projects && typical_project_size)
  end

  def check_for_completed_profile
    self.complete if completed_profile? && !self.completed?
  end
end
