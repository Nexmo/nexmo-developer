module BuildingBlockRenderer
  class Android
    def self.dependencies(deps)
      { 'code' => "In your app-level build.gradle file (usually app/build.gradle), add the dependency:

dependencies {
  implementation 'com.nexmo.android:client-sdk:0.7.26'
}

In your project level build.gradle file, add the Maven repository:

buildscript {
    repositories {
        maven {
            url \"https://artifactory.ess-dev.com/artifactory/gradle-dev-local\"
        }
    }
    //...
}

allprojects {
    repositories {
        ...
        maven {
            url \"https://artifactory.ess-dev.com/artifactory/gradle-dev-local\"
        }
    }
}"
    }
    end

    def self.run_command(_command, _filename, _file_path)
      nil
    end

    def self.create_instructions(filename)
      "Create a file named `#{filename}` and add the following code:"
    end

    def self.add_instructions(filename)
      "Add the following to `#{filename}`:"
    end
  end
end
