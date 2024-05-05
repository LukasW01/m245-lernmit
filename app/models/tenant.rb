class Tenant < ApplicationRecord

  has_many :companies, dependent: :delete_all
  has_many :projects, dependent: :delete_all
  has_many :tasks, dependent: :delete_all

  after_create :create_sample_records

  # If we change the schema we recreate new tenants
  has_defaults schema_version: -> { self.class.schema_version }

  scope :for_current_schema, -> { where(schema_version: schema_version)}

  def self.schema_version
    connection.migration_context.current_version
  end

  def self.clean!
    old_tenants = where('created_at < ?', 7.days.ago)
    incompatible_tenants = where('schema_version != ?', schema_version)
    cleanable_tenants = old_tenants.or(incompatible_tenants)
    cleanable_tenants.find_each(&:destroy)
  end

  def tenants
    # code here
  end

  private

  def create_sample_records
    5.times do
      company = companies.create!(
        name: Faker::Company.unique.name,
        address: sample_address
      )

      (2..3).to_a.sample.times do
        projects.create!(
          company: company,
          name: Project.suggest_name,
          budget: ((1..150).to_a.sample * 1000),
        )
      end
    end

    18.times do
      tasks.create!(
        title: Faker::Lorem.sentence(word_count: 1),
        text: Faker::Lorem.sentence(word_count: 2,  random_words_to_add: 10),
        types: %w[Task Exam].sample,
        points: (1..6).to_a.sample,
        due_date: rand(100).hours.from_now,
        done: [true, false].sample,
        created_at: rand(100).hours.ago
      )
    end
  end

  def sample_address
    <<~ADDRESS
      #{Faker::Address.street_name} #{rand(100) + 1}
      #{Faker::Address.postcode} #{Faker::Address.city}
      #{Faker::Address.country}
    ADDRESS
  end

end

