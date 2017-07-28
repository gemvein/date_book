# frozen_string_literal: true

DateBook.configure do |config|
  config.anonymous_customer_stripe_id = 'anonymous-customer'
  config.anonymous_plan_stripe_id = 'anonymous-plan'
  config.free_plan_stripe_id = 'free-plan'

  DateBook.add_feature(
    slug: 'ad_free',
    title: 'Ad Free',
    description: 'Are ads removed from the site with this plan?',
    setting_type: 'boolean'
  )
  DateBook.add_feature(
    slug: 'groups',
    title: 'Groups',
    description: 'How many groups are allowed with this plan?',
    # Table row counting: feature enabled by a positive value
    # for the DateBook::PlanFeatureSetting.setting associated with this
    # DateBook::Feature
    setting_type: 'table_rows'
  )
  DateBook.add_feature(
    slug: 'doodads',
    title: 'Doodads',
    description: 'How many doodads included with this plan?',
    setting_type: 'rolify_rows'
  )
end
