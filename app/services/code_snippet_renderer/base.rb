module CodeSnippetRenderer
  class Base
    def self.inherited(base)
      base.extend ActionView::Helpers::TranslationHelper
      base.instance_variable_set :@virtual_path, "services.#{base.name.underscore.tr('/', '.')}"
    end
  end
end
