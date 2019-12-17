module SplitHelper
  # Force a specific experiment alternative to always be returned:
  #   use_ab_test(signup_form: "single_page")
  #
  # Force alternatives for multiple experiments:
  #   use_ab_test(signup_form: "single_page", pricing: "show_enterprise_prices")
  #
  def use_ab_test(alternatives_by_experiment)
    allow_any_instance_of(Split::Helper).to receive(:ab_test) do |_receiver, experiment|
      alternatives_by_experiment.fetch(experiment) { |key| raise "Unknown experiment '#{key}'" }
    end
  end
end
