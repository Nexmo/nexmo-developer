# Copyright 2016 Smartling, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'smartling/api'

module Smartling

  class Project < Api
    
    # List Projects - /accounts-api/v2/accounts/{accountUid}/projects (GET)
    def list(accountUid, params = nil)
      uri = uri('accounts-api/v2/accounts/' + accountUid + '/projects', params)
      return get(uri)
    end

    # Project Details - /projects-api/v2/projects/{projectId} (GET)
    def details(projectId, params = nil)
      uri = uri('projects-api/v2/projects/' + projectId, params)
      return get(uri)
    end
    
  end
end

