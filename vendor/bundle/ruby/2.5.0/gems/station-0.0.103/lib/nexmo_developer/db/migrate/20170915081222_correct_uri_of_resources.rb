CODE_LANGUAGES = ['curl', 'node', 'java', 'dotnet', 'csharp', 'php', 'python', 'ruby']

class CorrectUriOfResources < ActiveRecord::Migration[5.1]
  def up
    Feedback::Resource.all.each do |resource|
      uri = URI(resource.uri)

      # Get the code_language from the URI. Will return nil if there isn't one
      code_language = CODE_LANGUAGES.detect { |language| language == uri.path.split('/').last }

      # Get the canonical_uri by removing query parameters and then chomp the code_language off the end if present
      canonical_uri = "#{uri.scheme}://#{uri.host}#{uri.path}".chomp("/#{code_language}")

      # Check if the current uri of the resource matches our canonical_uri, if so do nothing
      unless canonical_uri == resource.uri
        # Lets see if a resource with the canonical_uri already exists
        canonical_resource = Feedback::Resource.find_by_uri(canonical_uri)

        if canonical_resource
          # If we do have a canonical_resource update this resources feedbacks to belong to it and destroy this resource
          # since it will no longer be used.
          resource.feedbacks.update_all({ resource_id: canonical_resource.id })
          resource.destroy!
        else
          # Otherwise we'll simply correct the uri of this resource
          resource.update({ uri: canonical_uri })
        end
      end
    end
  end
end
