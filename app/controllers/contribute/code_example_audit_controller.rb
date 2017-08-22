module Contribute
  class CodeExampleAuditController < ApplicationController
    def show
      @auditor = CodeExampleAuditor.new
    end
  end
end
