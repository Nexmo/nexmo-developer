class ImprovePagePresenter
  def initialize(document_path)
    @document_path = document_path
  end

  def github_url
    @github_url ||= "https://github.com/#{docs_repo}/blob/#{ENV.fetch('branch', 'master')}/#{path_to_url}"
  end

  private

  def path_to_url
    @document_path&.gsub("#{Rails.configuration.docs_base_path}/", '')
  end

  def docs_repo
    @docs_repo ||= YAML.safe_load(File.open("#{Rails.configuration.docs_base_path}/config/business_info.yml"))['docs_repo']
  end
end
